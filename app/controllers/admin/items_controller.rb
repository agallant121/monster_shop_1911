class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    item = Item.find(params[:item_id])
    item.updates_active
    if item.active? == false
      flash[:update] = "#{item.name} is no longer for sale."
    else
      flash[:update] = "#{item.name} is now available for sale."
    end
    redirect_to "/admin/merchants/#{params[:merchant_id]}/items"
  end

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    flash[:destroy] = "#{item.name} is now deleted."
    redirect_to "/admin/merchants/#{params[:merchant_id]}/items"
  end

end
