class User < ApplicationRecord
  has_many :packed_items, class_name: "InventoryItem", inverse_of: :inventoried_by

  scope :active, -> { where(active: true) }

  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name, message: "and last name already exists for another user" }
  validates :initials, presence: true, length: { maximum: 3 }, uniqueness: true

  validate do
    errors.add(:base, "User must have at least one role") if !admin? && !packer? && !picker?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def roles
    roles = []
    roles << "Admin" if admin?
    roles << "Packer" if packer?
    roles << "Picker" if picker?
    roles
  end

  def picker_access?
    picker? || admin?
  end

  def packer_access?
    packer? || admin?
  end

  def most_recently_packed_items
    packed_items.order(created_at: :desc).limit(10)
  end

  def recently_packed_item
    packed_items.where(created_at: Date.today..).order(created_at: :desc).first
  end
end
