class Container < ApplicationRecord
  has_many :inventory_items, dependent: :nullify

  validates :application_number, presence: true

  scope :can_receive_items, -> { where(shipped_at: nil) }

  def mark_as_shipped!
    raise "Already shipped" unless can_be_marked_as_shipped?

    update!(shipped_at: Time.now)
  end

  def can_be_marked_as_shipped?
    !shipped_at
  end

  def editable?
    !shipped_at
  end

  def destroyable?
    !shipped_at && inventory_items.empty?
  end

  def display_text
    "##{application_number} - #{name} #{country}"
  end

  def can_receive_items?
    !shipped_at
  end
end
