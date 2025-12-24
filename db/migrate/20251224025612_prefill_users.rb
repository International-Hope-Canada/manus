class PrefillUsers < ActiveRecord::Migration[8.1]
  def change
    User.create!(name: 'Jason Barnabe', role: :admin)
  end
end
