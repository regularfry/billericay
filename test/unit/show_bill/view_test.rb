# -*- coding: utf-8 -*-
require 'nokogiri'
require_relative("../unit_test_case")
require "show_bill/view"

module ShowBill
  class ViewTest < UnitTestCase
    def test_shows_total
      node = html("total" => "136.03").at("#statement .total")
      assert_equal("£136.03", node.text())
    end

    def test_shows_subscriptions
      doc = html("package" =>
                  {"subscriptions" =>
                    [{"type" => "tv", "name" => "Variety", "cost" => 50.00}]})
      assert(package_node = doc.at("#package"), "No package shown")
      assert(first_sub_row = package_node.at("tr.sub"), "No subscriptions shown")
      assert_equal("£50.00", package_node.at("td.cost").text(), "Wrong cost shown")
      assert_equal("Variety", package_node.at("td.name").text(), "Wrong name shown")
    end

    def test_shows_subscriptions_subtotal
      doc = html("package" => {"total" => 71.40})
      assert(node = doc.at("#package .total"), "No package total shown")
      assert_equal("£71.40", node.text())
    end

    private
    def html(data)
      rendered_view = View.new.render(data)
      Nokogiri::HTML(rendered_view)
    end
  end
end
