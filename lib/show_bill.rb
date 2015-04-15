require 'cuba'
require 'haml'

class ShowBill < Cuba

  def self.bill_href=(bill_href)
    self.settings[:bill_href] = bill_href
  end

  define do
    on root do
      haml_engine = Haml::Engine.new(File.read("templates/bill.haml"))
      res.write(haml_engine.render)
    end
  end


end # class ShowBill
