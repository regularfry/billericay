require_relative("../unit_test_case")
require 'webmock/minitest'
require 'show_bill/retriever'

module ShowBill

  class RetrieverTest < UnitTestCase

    def test_gets_bill
      test_uri = "http://test.host/bill.json"
      stub_request(:get, test_uri).
        to_return(:status => 200,
                  :body => '{"expected": "body"}')
      response, err = Retriever.new(test_uri).get
      assert_equal( {"expected" => "body"}, response )
      refute err
    end


  end


end
