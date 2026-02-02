require "csv"

class Container < ApplicationRecord
  has_many :inventory_items, dependent: :nullify

  validates :application_number, presence: true

  scope :can_receive_items, -> { where(shipped_at: nil) }

  def mark_as_shipped!
    raise "Already shipped" unless can_be_marked_as_shipped?

    update!(shipped_at: Time.now)
  end

  def mark_as_not_shipped!
    raise "Already not shipped" unless shipped?

    update!(shipped_at: nil)
  end

  def can_be_marked_as_shipped?
    !shipped?
  end

  def editable?
    !shipped?
  end

  def destroyable?
    !shipped? && inventory_items.empty?
  end

  def display_text
    "##{application_number} - #{consignee_name} #{consignee_country}"
  end

  def short_display_text
    "##{application_number}"
  end

  def can_receive_items?
    !shipped?
  end

  def shipped?
    shipped_at.present?
  end

  def consignee_city_region_country
    [ consignee_city, consignee_region, consignee_country ].select(&:present?).join(", ")
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << [ "Application number", "Created at", "Shipped at", "Consignee name", "Consignee address", "Consignee city", "Consignee region", "Consignee country", "Consignee postal code", "Consignee contact name", "Consignee contact email", "Consignee contact phone", "Item count" ]

      find_each do |container|
        csv << container.csv_values
      end
    end
  end

  def csv_values
    [ application_number, created_at, shipped_at, consignee_name, consignee_address, consignee_city, consignee_region, consignee_country, consignee_postal_code, consignee_contact_name, consignee_contact_email, consignee_contact_phone, inventory_items.count ]
  end
end
