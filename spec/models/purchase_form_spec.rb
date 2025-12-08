require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: user.id, item_id: item.id)
  end

  describe "商品購入" do
    context "購入できるとき" do
      it "全ての項目が正しく入力されていれば有効" do
        expect(@purchase_form).to be_valid
      end

      it "建物名が空でも有効" do
        @purchase_form.building = ""
        expect(@purchase_form).to be_valid
      end
    end

    context "購入できないとき" do
      it "郵便番号にハイフンがないと無効" do
        @purchase_form.postal_code = "1234567"
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code はハイフンを含む形式で入力してください")
      end

      it "都道府県が1だと無効" do
        @purchase_form.prefecture_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture を選択してください")
      end

      it "市区町村が空だと無効" do
        @purchase_form.city = ""
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it "番地が空だと無効" do
        @purchase_form.address = ""
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
      end

      it "電話番号が空だと無効" do
        @purchase_form.phone_number = ""
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank", "Phone number は10〜11桁の数字で入力してください")
      end

      it "電話番号が10桁未満だと無効" do
        @purchase_form.phone_number = "123456789"
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number は10〜11桁の数字で入力してください")
      end

      it "電話番号が12桁以上だと無効" do
        @purchase_form.phone_number = "123456789012"
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number は10〜11桁の数字で入力してください")
      end

      it "user_id が空だと無効" do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it "item_id が空だと無効" do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
