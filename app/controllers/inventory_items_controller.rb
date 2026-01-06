class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_packer!, only: [:new, :create]

  def show
  end

  def new
    @breadcrumbs = ['New Inventory Item']
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

  def index
    @inventory_items = InventoryItem.order(id: :desc)
    @breadcrumbs = ['Inventory Items']
  end

  def show
    @breadcrumbs = [['Inventory Items', inventory_items_path], @inventory_item.id]
  end

  def edit
    @breadcrumbs = [['Inventory Items', inventory_items_path], [@inventory_item.id, inventory_item_path(@inventory_item)]]
    render :new
  end

  def update
    if @inventory_item.update(inventory_item_params)
      redirect_to @inventory_item, notice: 'Inventory item was successfully updated.'
    else
      render :new
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
    params.require(:inventory_item).permit(:barcode, :oldest_expiry_year, :description, :manual_type, :status)
  end
end