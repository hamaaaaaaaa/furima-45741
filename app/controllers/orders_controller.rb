class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_seller, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_form = PurchaseForm.new
  end

  def create  
    @purchase_form = PurchaseForm.new(purchase_form_params)
  
    if @purchase_form.valid?
      pay_item  
      @purchase_form.save   # DB保存（purchase + address）
      redirect_to root_path  
    else
      render :index
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

 def purchase_form_params
  params.require(:purchase_form).permit(
    :postal_code, :prefecture_id, :city, :address, :building, :phone_number
  ).merge(
    user_id: current_user.id,
    item_id: @item.id,
    token: params[:token]
  )
 end

   def redirect_if_seller
    redirect_to root_path if current_user.id == @item.user_id
  end

  def redirect_if_sold_out
    redirect_to root_path if @item.sold_out?
  end
end

