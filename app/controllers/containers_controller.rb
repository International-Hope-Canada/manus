class ContainersController < ApplicationController
  before_action :authorize_picker!
  before_action :set_container, only: %i[show edit update destroy]

  def new
    @breadcrumbs = [['Containers', containers_path], 'New Container']
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
    @containers = Container.order(application_number: :desc)
  end

  def show
    @breadcrumbs = [['Containers', containers_path], @container.application_number]
  end

  def edit
    @breadcrumbs = [['Containers', containers_path], [@container.application_number, container_path(@container)], 'Edit']
    render :new
  end

  def update
    respond_to do |format|
      if @container.update(container_params)
        format.html { redirect_to @container, notice: 'Container was successfully updated.' }
        format.json { render :show, status: :ok, location: @container }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @container.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @container.destroy
    respond_to do |format|
      format.html { redirect_to containers_path, notice: 'Container was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def container_params
    params.require(:container).permit(:application_number, :name, :address, :country, :contact, :phone, :email)
  end

  def set_container
    @container = Container.find_by(id: params[:id])
  end
end