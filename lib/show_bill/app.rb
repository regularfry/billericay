require 'cuba'
require_relative("view")
require_relative("retriever")

module ShowBill
  class App < Cuba

    def self.bill_href=(bill_href)
      self.settings[:bill_href] = bill_href
    end

    def self.retriever
      @retriever || Retriever.new
    end

    def self.view
      @view || View.new
    end

    class << self
      attr_writer :retriever
      attr_writer :view
    end

    define do
      on root do
        bill_data = self.class.retriever.get()
        res.write(self.class.view.render(bill_data))
      end
    end

  end # class App

end # module ShowBill
