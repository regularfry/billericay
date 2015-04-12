require_relative("unit_test_case")
require 'rack/test'

require 'show_bill'

class ShowBillTest < UnitTestCase
  include Rack::Test::Methods

  def app
    ShowBill
  end

  def test_responds_to_root_get_request
    get("/")
    assert(last_response.ok?)
  end
end
