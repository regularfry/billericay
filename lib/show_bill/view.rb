# -*- coding: utf-8 -*-
require 'haml'
require 'map'

require 'show_bill'

module ShowBill

  class View

    attr_accessor :data

    def initialize
      @haml_engine = Haml::Engine.new(template)
    end

    def render(bill_hash)
      @data = Map.new(bill_hash)
      @haml_engine.render(binding)
    end

    def money(amount_pounds)
      "£%0.2f" % amount_pounds.to_f
    end

    private
    def template
      str = (ShowBill.templates + "bill.haml").read
      str.force_encoding("UTF-8")
    end


  end # module View


end # module ShowBill
