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
    "##{application_number} - #{name} #{country}"
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

  def city_region_country
    [ city, region, country ].select(&:present?).join(", ")
  end
end
