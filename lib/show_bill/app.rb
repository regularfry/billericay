require 'cuba'
require_relative("view")
require_relative("retriever")

module ShowBill
  class App < Cuba

    DEFAULT_BILL_HREF = "http://safe-plains-5453.herokuapp.com/bill.json"

    def self.retriever
      @retriever || Retriever.new(self.bill_href || DEFAULT_BILL_HREF)
    end

    def self.view
      @view || View.new
    end

    class << self
      attr_writer :retriever
      attr_writer :view
      attr_accessor :bill_href
    end

    define do
      on root do
        bill_data,err = self.class.retriever.get()
        res.write(self.class.view.render(bill_data))
      end
    end

  end # class App

end # module ShowBill
