# -*- coding: utf-8 -*-
require_relative "capybara_test_case"
require_relative "in_process_bill_server"
require 'json'
require 'map'
require 'pathname'


Thread.abort_on_exception = true

class TitleTest < CapybaraTestCase

  def self.bill_server
    # This is slightly unusual: we want this instance to persist
    # across tests.  It carries no state, so this isn't a problem; the
    # reason we want it to hang around is that we don't want to wait
    # for the socket shutdown between tests, which would otherwise
    # cause a collision.
    @bill_server ||= InProcessBillServer.new.tap{|s| s.run}
  end

  def setup
    @bill_server = self.class.bill_server
    ShowBill::App.bill_href = @bill_server.href
    visit("/")
  end

  def sample_data
    this_dir = Pathname.new(__FILE__).dirname
    data_path = this_dir + "data" + "bill.json"
    Map.new(JSON.parse(data_path.read))
  end

  def test_shows_statement_title
    title_node = page.find("h1")
    assert(title_node, "There is no statement title.")
    assert_match(/statement/i, title_node.text)
  end

   def test_shows_statement_total
     total_node = page.find("#statement .total")
     assert_match(/£136.03\b/, total_node.text)
  end


end
