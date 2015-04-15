require 'net/http'
require 'json'

module ShowBill

  class Retriever

    def initialize(bill_href)
      @bill_uri = URI.parse(bill_href)
    end


    def get
      response = Net::HTTP.get_response(@bill_uri)
      case response
      when Net::HTTPOK
        [JSON.parse(response.body), nil]
      else
        [nil, response.body]
      end
    end


  end


end
