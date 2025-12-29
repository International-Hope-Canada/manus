class InventoryItem < ApplicationRecord
  belongs_to :item_subcategory
  belongs_to :inventoried_by, class_name: 'User'

  enum :manual_type, [:no_manual, :pdf, :paper]

  delegate :equipment?, :supply?, to: :item_subcategory, allow_nil: true

  validates :barcode, presence: true, uniqueness: true
  validates :oldest_expiry_date, presence: true
  validates :manual_type, presence: true, if: :equipment?
end