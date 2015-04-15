require 'net/http'
require 'json'

module ShowBill

  class Retriever

    def initialize(bill_href)
      @bill_uri = URI.parse(bill_href)
    end


    def get
      response = Net::HTTP.get_response(@bill_uri)
      [JSON.parse(response.body), nil]
    end


  end


end
