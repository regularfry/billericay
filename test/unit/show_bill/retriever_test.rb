require_relative("../unit_test_case")
require 'webmock/minitest'
require 'show_bill/retriever'

module ShowBill

  class RetrieverTest < UnitTestCase

    def setup
      @test_uri = "http://test.host/bill.json"
    end



    def test_gets_bill
      stub_response(:status => 200, :body => '{"expected": "body"}')
      response, err = get()
      assert_equal( {"expected" => "body"}, response )
      refute err
    end


    def test_handles_not_found
      stub_response(:status => 404, :body => "Not found")
      response, err = get()
      refute response
      assert_equal "Not found", err
    end



    private
    def stub_response(opts={})
      stub_request(:get, @test_uri).to_return(opts)
    end

    def get
      Retriever.new(@test_uri).get
    end

  end


end
