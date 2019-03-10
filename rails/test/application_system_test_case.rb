require "test_helper"
require "capybara/email"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Capybara::Email::DSL

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
