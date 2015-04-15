$LOAD_PATH << "lib"
require 'show_bill'

ShowBill::App.use Rack::Static, :urls => ["/css"], :root => "static"
run ShowBill::App