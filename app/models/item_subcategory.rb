class ItemSubcategory < ApplicationRecord
  belongs_to :item_category

  validates :name, presence: true, uniqueness: { scope: :item_category_id }
  validates :value, :weight_kg, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  delegate :equipment?, :supply?, to: :item_category
end
