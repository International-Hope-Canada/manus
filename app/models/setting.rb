class Setting < ApplicationRecord
  def self.fetch(key)
    find_by!(setting_key: key).setting_value
  end
end
