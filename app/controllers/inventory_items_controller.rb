class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_packer!, only: [ :new, :create, :edit, :update ]
  before_action :authorize_admin!, only: [ :index ]

  def new
    @breadcrumbs = [ index_breadcrumb, "New" ]
    @body_class = "inventory-entry"
    @inventory_item = InventoryItem.new

    preselected_category = current_user.recently_packed_item&.item_subcategory&.item_category
    if preselected_category
      @classification = preselected_category.classification
      @item_category_id = preselected_category.id
    end
  end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    @inventory_item.inventoried_by = current_user
    @inventory_item.item_subcategory_id = params[:item_subcategory_id]
    if @inventory_item.save
      flash[:highlight_inventory_item_id] = @inventory_item.id
      redirect_to new_inventory_item_path
    else
      @breadcrumbs = [ index_breadcrumb, "New" ]
      @body_class = "inventory-entry"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @pagy, @inventory_items = pagy(:offset, view_context.apply_inventory_item_sorts_and_filters(InventoryItem))
    @breadcrumbs = [ "Inventory" ]
  end

  def show
    @breadcrumbs = [ index_breadcrumb, @inventory_item.barcode ]
  end

  def edit
    @breadcrumbs = [ index_breadcrumb, [ @inventory_item.barcode, inventory_item_path(@inventory_item) ], "Edit" ]
    @body_class = "inventory-entry"
    render :new
  end

  def update
    if @inventory_item.update(inventory_item_params)
      redirect_to @inventory_item, notice: "Inventory item was successfully updated."
    else
      @breadcrumbs = [ index_breadcrumb, [ @inventory_item.barcode, inventory_item_path(@inventory_item) ], "Edit" ]
      @body_class = "inventory-entry"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory_item.destroy
    if params[:context] == "inventory_entry"
      redirect_to new_inventory_item_path
    else
      redirect_to inventory_items_url, notice: "Inventory item was successfully destroyed."
    end
  end

  private

  def set_inventory_item
    @inventory_item = InventoryItem.find(params[:id])
  end

  def inventory_item_params
    params.require(:inventory_item).permit(:barcode, :oldest_expiry_year, :description, :manual_type, :status)
  end

  def index_breadcrumb
    current_user&.admin? ? [ "Inventory", inventory_items_path ] : "Inventory"
  end
end
