class User < ApplicationRecord
  enum :role, [:admin, :packer, :picker]

  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
end
