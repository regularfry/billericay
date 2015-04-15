require 'haml'
require 'map'

require 'show_bill'

module ShowBill

  class View

    attr_accessor :data

    def initialize(bill_hash = {})
      @data = Map.new(bill_hash)
      @haml_engine = Haml::Engine.new(template)
    end


    def to_s
      @haml_engine.render(binding)
    end

    private
    def template
      (ShowBill.templates + "bill.haml").read
    end


  end # module View


end # module ShowBill
