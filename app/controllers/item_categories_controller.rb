class ItemCategoriesController < ApplicationController
  before_action :set_item_category, only: %i[show edit update destroy]

  # GET /item_categories or /item_categories.json
  def index
    @item_categories = ItemCategory.order(:classification, :name)
  end

  # GET /item_categories/1 or /item_categories/1.json
  def show; end

  # GET /item_categories/new
  def new
    @item_category = ItemCategory.new
  end

  # GET /item_categories/1/edit
  def edit; end

  # POST /item_categories or /item_categories.json
  def create
    @item_category = ItemCategory.new(item_category_params)

    respond_to do |format|
      if @item_category.save
        @item_category.ensure_subcategory! if params[:ensure_subcategory]

        format.html { redirect_to @item_category, notice: 'Item category was successfully created.' }
        format.json { render :show, status: :created, location: @item_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item_category.update(item_category_params)
        @item_category.ensure_subcategory! if params[:ensure_subcategory]

        format.html { redirect_to @item_category, notice: 'Item category was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item_category.destroy
    respond_to do |format|
      format.html { redirect_to item_categories_url, notice: 'Item category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def item_category_params
    params.require(:item_category).permit(:name, :classification, :value, :weight_kg)
  end

  def set_item_category
    @item_category = ItemCategory.find(params[:id])
  end
end