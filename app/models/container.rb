class Container < ApplicationRecord
  validates :application_number, presence: true

  has_many :inventory_items, dependent: :nullify

  def mark_as_shipped!
    raise 'Already shipped' unless can_be_marked_as_shipped?

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
end