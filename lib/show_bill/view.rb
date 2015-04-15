require 'haml'

module ShowBill

  class View

    def initialize(bill_hash = {})
      @haml_engine = Haml::Engine.new(template)
    end

    def to_s
      @haml_engine.render
    end

    private
    def template
      (ShowBill.templates + "bill.haml").read
    end


  end # module View


end # module ShowBill
