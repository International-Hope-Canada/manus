class Container < ApplicationRecord
  has_many :inventory_items, dependent: :nullify

  validates :application_number, presence: true

  scope :can_receive_items, -> { where(shipped_at: nil) }

  def mark_as_shipped!
    raise "Already shipped" unless can_be_marked_as_shipped?

    update!(shipped_at: Time.now)
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
end
