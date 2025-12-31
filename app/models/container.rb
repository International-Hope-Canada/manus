class Container < ApplicationRecord
  validates :application_number, presence: true

  has_many :inventory_items, dependent: :nullify
end