class ItemCategory < ApplicationRecord
  has_many :item_subcategories

  enum :classification, [:equipment, :supply]

  validates :name, presence: true, uniqueness: { scope: :classification }
  validates :classification, presence: true

  validates :value, :weight_kg, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
