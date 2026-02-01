class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_packer!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :authorize_admin!, only: [ :index, :barcode_lookup, :by_category ]

  def new
    @breadcrumbs = [ index_breadcrumb, "New" ]
    @body_class = "inventory-entry"
    @inventory_item = InventoryItem.new(barcode: params[:barcode])

    preselected_subcategory = current_user.recently_packed_item&.item_subcategory
    if preselected_subcategory
      @classification = preselected_subcategory.classification
      @item_category_id = preselected_subcategory.item_category_id
      @item_subcategory_id = preselected_subcategory.id
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
    @inventory_items = apply_pagy(view_context.apply_inventory_item_sorts_and_filters(InventoryItem))
    @breadcrumbs = [ "Inventory" ]
  end

  def by_category
    scope = InventoryItem
    scope = scope.where(status: params[:status]) if params[:status].present?
    @inventory_items_by_subcategory = scope.group(:item_subcategory_id).count
    @subcategories = ItemSubcategory.joins(:item_category).where(id: @inventory_items_by_subcategory.keys).order(item_categories: { name: :asc }, item_subcategories: { catchall: :asc, name: :asc })
    @breadcrumbs = [ index_breadcrumb, "By category" ]
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

  def barcode_lookup
    @breadcrumbs = [ index_breadcrumb, "Barcode lookup" ]
  end

  def do_barcode_lookup
    inventory_item = InventoryItem.find_by(barcode: params[:barcode])
    if inventory_item
      redirect_to inventory_item
      return
    end

    @message = "No item with barcode #{params[:barcode]} found. #{view_context.link_to('Add it?', new_inventory_item_path(barcode: params[:barcode]))}"
    @breadcrumbs = [ index_breadcrumb, "Barcode lookup" ]
    render :barcode_lookup, status: :not_found
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
