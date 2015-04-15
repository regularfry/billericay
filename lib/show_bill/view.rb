# -*- coding: utf-8 -*-
require 'haml'
require 'map'

require 'show_bill'

module ShowBill

  module ViewHelpers
    # Render amount_pounds to a string.  We're passed float pounds for
    # money values in the input JSON, so there's a limit to how
    # careful it's worth being here.
    def money(amount_pounds)
      "£%0.2f" % amount_pounds.to_f
    end

    # Take in a date in "2015-1-11" format, spit out a date in "11 Jan
    # 2015" format, which is more human-friendly
    def date(iso8601_date)
      Date.parse(iso8601_date).strftime("%-d %b %Y")
    end

  end


  class View

    attr_accessor :data

    def initialize
      @haml_engine = Haml::Engine.new(template)
    end

    def render(bill_hash)
      @data = Map.new(bill_hash)
      @haml_engine.render(binding)
    end

    include ViewHelpers

    private
    def template
      str = (ShowBill.templates + "bill.haml").read
      str.force_encoding("UTF-8")
    end


  end # module View




end # module ShowBill
