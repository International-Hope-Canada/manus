class ItemSubcategory < ApplicationRecord
  belongs_to :item_category

  validates :name, presence: true, uniqueness: { scope: :item_category_id }
  validates :value, :weight_kg, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  delegate :equipment?, :supply?, :classification, to: :item_category

  def missing_weight?
    weight_kg.nil? && item_category.weight_kg.nil?
  end

  def missing_value?
    value.nil? && item_category.value.nil?
  end

  def selectable?
    !missing_weight? && !missing_value?
  end

  def display_name
    "#{item_category.name}: #{name}"
  end
end
