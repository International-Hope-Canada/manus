class User < ApplicationRecord
  enum :role, [:admin, :packer, :picker]

  validates :first_name, :last_name, :role, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  def name
    "#{first_name} #{last_name}"
  end
end
