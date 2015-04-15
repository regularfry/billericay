require 'cuba'
require_relative("view")

module ShowBill
  class App < Cuba

    def self.bill_href=(bill_href)
      self.settings[:bill_href] = bill_href
    end


    define do
      on root do
        res.write(View.new("total" => "136.03").to_s)
      end
    end

  end # class App

end # module ShowBill
