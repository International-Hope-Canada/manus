class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @inventory_item = InventoryItem.new
  end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    @inventory_item.inventoried_by = current_user
    @inventory_item.item_subcategory_id = params[:item_subcategory_id]
    if @inventory_item.save
      redirect_to new_inventory_item_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @inventory_item.update(inventory_item_params)
      redirect_to @inventory_item, notice: 'Inventory item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @inventory_item.destroy
    redirect_to inventory_items_url, notice: 'Inventory item was successfully destroyed.'
  end

  private

  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:id])
  end

  def inventory_item_params
    params.require(:inventory_item).permit(:barcode, :oldest_expiry_date, :description, :manual_type)
  end
end