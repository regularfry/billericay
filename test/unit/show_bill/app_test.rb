require_relative("../unit_test_case")
require 'rack/test'

require 'show_bill/app'

module ShowBill
  class AppTest < UnitTestCase
    include Rack::Test::Methods

    def app
      ShowBill::App
    end

    def test_responds_to_root_get_request
      get("/")
      assert(last_response.ok?)
    end


  end
end
