class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_seller, only: [:index, :create]  # ←追加

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_form_params)
  
    if @purchase_form.valid?
      @purchase_form.save   # DB保存（purchase + address）
      redirect_to root_path  
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_form_params
    params.require(:purchase_form).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token
    ).merge(user_id: current_user.id, item_id: @item.id)
  end
  
  def redirect_if_seller
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
