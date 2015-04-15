require 'cuba'
require_relative("view")
require_relative("retriever")

module ShowBill
  class App < Cuba

    def self.retriever
      @retriever || Retriever.new(self.bill_href)
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
