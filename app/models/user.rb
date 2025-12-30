class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  def name
    "#{first_name} #{last_name}"
  end

  def roles
    roles = []
    roles << 'Admin' if admin?
    roles << 'Packer' if packer?
    roles << 'Picker' if picker?
    roles
  end

  def picker_access?
    picker? || admin?
  end

  def packer_access?
    packer? || admin?
  end
end
