class ItemSubcategoriesController < ApplicationController
  before_action :set_item_subcategory, only: %i[show edit update destroy]

  def show
    @breadcrumbs = [['Categories', item_categories_path], [@item_subcategory.item_category.name, item_category_path(@item_subcategory.item_category)], @item_subcategory.name]
  end

  def new
    @item_subcategory = ItemSubcategory.new
  end

  def edit
    @breadcrumbs = [['Categories', item_categories_path], [@item_subcategory.item_category.name, item_category_path(@item_subcategory.item_category)], [@item_subcategory.name, item_subcategory_path(@item_subcategory)], 'Edit']
  end

  def create
    @item_subcategory = ItemSubcategory.new(item_subcategory_params)

    if @item_subcategory.save
      redirect_to @item_subcategory, notice: 'Item subcategory was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item_subcategory.update(item_subcategory_params)
      redirect_to @item_subcategory, notice: 'Item subcategory was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item_subcategory.destroy
    redirect_to item_subcategories_url, notice: 'Item subcategory was successfully destroyed.'
  end

  def picker
    @item_categories = ItemCategory.where(classification: params[:classification]).order(:name).select(&:selectable?) if params[:classification].present?
    @item_subcategories = ItemSubcategory.where(item_category_id: params[:item_category_id]).order(:name).select(&:selectable?) if params[:item_category_id].present?
  end

  private

  def set_item_subcategory
    @item_subcategory = ItemSubcategory.find(params[:id])
  end

  def item_subcategory_params
    params.require(:item_subcategory).permit(:name, :item_category_id, :value, :weight_kg)
  end
end