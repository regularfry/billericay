require 'cuba'
require 'haml'

class ShowBill < Cuba; end

ShowBill.define do
  on root do
    haml_engine = Haml::Engine.new(File.read("templates/bill.haml"))
    res.write(haml_engine.render)
  end
end
