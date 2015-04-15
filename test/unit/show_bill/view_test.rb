# -*- coding: utf-8 -*-
require 'nokogiri'
require_relative("../unit_test_case")
require "show_bill/view"

module ShowBill
  class ViewTest < UnitTestCase
    def test_shows_total
      rendered_view = View.new.render("total" => "136.03")
      parsed = Nokogiri::HTML(rendered_view)
      node = parsed.at("#statement #total")
      assert_equal("£136.03", node.text)
    end
  end
end
