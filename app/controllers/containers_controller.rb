class ContainersController < ApplicationController
  before_action :authorize_picker!
  before_action :set_container, only: %i[show edit update destroy mark_as_shipped items]

  def new
    @breadcrumbs = [ [ "Containers", containers_path ], "New Container" ]
    next_application_number = Container.order(application_number: :desc).pick(:application_number).to_i + 1
    @container = Container.new(application_number: next_application_number)
  end

  def create
    @container = Container.new(container_params)
    if @container.save
      redirect_to container_path(@container)
    else
      render :new
    end
  end

  def index
    @pagy, @containers = pagy(:offset, Container.order(application_number: :desc))
    @breadcrumbs = [ "Containers" ]
  end

  def show
    @breadcrumbs = [ [ "Containers", containers_path ], @container.application_number ]
  end

  def edit
    raise "Not editable" unless @container.editable?

    @breadcrumbs = [ [ "Containers", containers_path ], [ @container.application_number, container_path(@container) ], "Edit" ]
    render :new
  end

  def update
    raise "Not editable" unless @container.editable?

    respond_to do |format|
      if @container.update(container_params)
        format.html { redirect_to @container, notice: "Container was successfully updated." }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    raise "Not destroyable" unless @container.destroyable?

    @container.destroy
    respond_to do |format|
      format.html { redirect_to containers_path, notice: "Container was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def mark_as_shipped
    @container.mark_as_shipped!

    respond_to do |format|
      format.html { redirect_to @container, notice: "Container marked as shipped." }
      format.json { render :show, status: :ok, location: @container }
    end
  end

  def choose_for_picking
    @containers = Container.can_receive_items
    @breadcrumbs = [ "Picking" ]
  end

  def pick
    @container = Container.can_receive_items.find(params[:id])
    @breadcrumbs = [ [ "Picking", choose_for_picking_containers_path ], @container.display_text ]
    @success = flash[:success]
    @success_message = flash[:success_message]
  end

  def add_item
    @container = Container.can_receive_items.find(params[:id])
    inventory_item = InventoryItem.find_by(barcode: params[:barcode])

    @breadcrumbs = [ [ "Picking", choose_for_picking_containers_path ], @container.display_text ]

    if inventory_item.nil?
      @success = false
      @error = "Item #{params[:barcode]} not found."
    elsif inventory_item.container == @container
      @success = false
      @error = "Item #{params[:barcode]} already in container."
    elsif !inventory_item.can_be_added_to_container?
      @success = false
      @error = "Item cannot be added to container - #{inventory_item.can_be_added_to_container_failure_reason}"
    else
      @success = flash[:success] = true
      flash[:success_message] = "Item #{params[:barcode]} added to container."
      inventory_item.add_to_container!(@container)
    end

    respond_to do |format|
      if @success
        format.html { redirect_to pick_container_path(@container, inventory_item_sort: params[:inventory_item_sort]) }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :pick, status: :unprocessable_entity }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_item
    container = Container.can_receive_items.find(params[:id])
    inventory_item = container.inventory_items.find(params[:inventory_item_id])

    raise "Container cannot be modified." unless container.can_receive_items?

    inventory_item.remove_from_container!
    respond_to do |format|
      format.html { redirect_to container_path(container, inventory_item_sort: params[:inventory_item_sort]), notice: "Item removed." }
      format.json { render :show, status: :ok, location: container }
    end
  end

  def items
    render partial: "inventory_items", locals: { container: @container }
  end

  private

  def container_params
    params.require(:container).permit(:application_number, :name, :address, :country, :contact, :phone, :email)
  end

  def set_container
    @container = Container.find_by(id: params[:id])
  end
end
