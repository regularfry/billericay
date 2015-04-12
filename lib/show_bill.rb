require 'cuba'

class ShowBill < Cuba; end

ShowBill.define do
  on root do
    res.write("<h1>Title</h1>")
  end
end
