require 'capybara'
require 'show_bill'
require 'test/unit'

Capybara.default_driver = :selenium
Capybara.app = ShowBill

class CapybaraTestCase < Test::Unit::TestCase
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
