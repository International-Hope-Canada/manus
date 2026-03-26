require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def login(user: User.first)
    visit root_path
    fill_in 'initials', with: user.initials
    click_on 'Log in'
    assert_content "Logged in as #{user.initials}"
  end
end
