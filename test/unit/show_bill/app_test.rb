# -*- coding: utf-8 -*-
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
      app.retriever = stub("(retriever)", :get => {})
      get("/")
      assert(last_response.ok?)
    end


    def test_uses_retrieved_data
      app.retriever = mock("(retriever)", :get => {"total" =>"42.00"})
      app.view = mock("(view)", :render => "£42.00")
      get("/")
    end


  end
end
