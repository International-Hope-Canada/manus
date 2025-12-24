class PrefillUsers < ActiveRecord::Migration[8.1]
  def up
    User.create!(first_name: 'Jason', last_name: 'Barnabe', role: :admin)
  end
end
