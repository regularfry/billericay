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


    def test_shows_calls
      call = { "called" => "07716393769", "duration" => "00:23:03", "cost" => 2.13 }
      doc = html("callCharges" => {"calls" => [call,call]})
      assert(calls_node = doc.at("#calls"), "No calls shown")
      call_nodes = calls_node.search("tr.call")
      assert_equal(2, call_nodes.length, "Wrong number of calls shown")
      assert_equal(call['called'], call_nodes.first.at(".called").text())
    end


    def test_shows_calls_subtotal
      doc = html("callCharges" => {"total" => 59.64})
      assert(node = doc.at("#calls .total"), "No calls total shown")
      assert_equal("£59.64", node.text())
    end


    def test_shows_store_rentals
      rental = { "title" => "50 Shades of Grey", "cost" => 4.99 }
      doc = html("skyStore" => {"rentals" => [rental, rental]})
      assert(rental_node = doc.at("#store #rentals"), "No rental transactions were shown")
      rental_nodes = rental_node.search("tr.rental")
      assert_equal(2, rental_nodes.length, "Wrong number of rentals shown")
      assert_equal(rental['title'], rental_nodes.first.at(".title").text())
    end


    def test_shows_store_purchases
      purchase = { "title" => "That's what she said", "cost" => 9.99 }
      doc = html("skyStore" => {"buyAndKeep" => [purchase, purchase]})
      assert(purchase_node = doc.at("#store #purchases"),
             "No purchase transactions were shown")
      purchase_nodes = purchase_node.search("tr.purchase")
      assert_equal(2, purchase_nodes.length, "Wrong number of purchases shown")
      assert_equal(purchase['title'], purchase_nodes.first.at(".title").text())
    end

    def test_shows_store_subtotal
      doc = html("skyStore" => {"total" => 24.97})
      assert(node = doc.at("#store .total"), "No store total shown")
      assert_equal("£24.97", node.text())
    end

    def test_shows_statement_dates
      doc = html("statement" => {
                   "due" => "2015-01-25",
                   "period" => {
                     "from" => "2015-01-26",
                     "to" => "2015-02-25"}})

      assert(due_node = doc.at("#statement #due"))
      assert_equal("25 Jan 2015", due_node.text())
      assert(period_node = doc.at("#statement #period"))
      assert_match(/26 Jan 2015\s+to\s+25 Feb 2015/, period_node.text())
    end

    def test_shows_generated_date
      doc = html("statement" => {"generated" => "2015-01-11"})
      assert(generated_node = doc.at("#generated"))
      assert_equal("11 Jan 2015", generated_node.text())
    end

    private
    def html(data)
      rendered_view = View.new.render(data)
      Nokogiri::HTML(rendered_view)
    end
  end
end
