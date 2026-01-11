class ItemCategory < ApplicationRecord
  has_many :item_subcategories, dependent: :destroy

  enum :classification, [ :equipment, :supply ]

  validates :name, presence: true, uniqueness: { scope: :classification }
  validates :classification, presence: true
  validates :value, :weight_kg, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def selectable?
    item_subcategories.any?(&:selectable?)
  end

  def missing_subcategories?
    item_subcategories.empty?
  end

  def subcategories_missing_weights?
    return false if weight_kg

    item_subcategories.where(weight_kg: nil).any?
  end

  def subcategories_missing_values?
    return false if value

    item_subcategories.where(value: nil).any?
  end

  def ensure_subcategory!
    if item_subcategories.empty?
      item_subcategories.create!(name: "General")
    end
  end

  def destroyable?
    InventoryItem.where(item_subcategory: item_subcategories).none?
  end
end
