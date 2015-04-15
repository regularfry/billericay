require 'cuba'
require 'haml'
require_relative("view")

module ShowBill
  class App < Cuba

    def self.bill_href=(bill_href)
      self.settings[:bill_href] = bill_href
    end

    define do
      on root do
        haml_engine = Haml::Engine.new(File.read("templates/bill.haml"))
        res.write(haml_engine.render)
      end
    end

  end # class App

end # module ShowBill
