class AddInitialSettings < ActiveRecord::Migration[8.1]
  def change
    execute <<~SQL
      INSERT INTO settings (setting_key, setting_value) VALUES 
      ('ihc_address', 'International HOPE Canada Inc.\nP.O. Box 23041\nRPO McGillivray\nWinnipeg, Manitoba, CANADA R3T 5S3\nEmail: info@internationalhope.ca\nwww.internationalhopecanada.ca'),
      ('ihc_charity_number', '85942 7049 RR0001')
    SQL
  end
end
