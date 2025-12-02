class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_form_params)
    if @purchase_form.save
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
end