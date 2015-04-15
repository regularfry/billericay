require 'cuba'
require 'webrick'
require_relative "sample_data"

# This class serves the sample bill.json on a local port from a
# background thread, to avoid calling out to the live service in
# acceptance tests.
class InProcessBillServer
  PORT = 17001

  class FakeBillServer < Cuba; end
  FakeBillServer.define do
    on "bill.json" do
      res.write(SampleData.new.to_s)
    end
  end


  def run
    @thread = Thread.new do
      silent_log = ::WEBrick::Log.new(File.new("/dev/null", "a+"))
      Rack::Handler::WEBrick.run( FakeBillServer,
                                  :Port => PORT,
                                  :Logger => silent_log,
                                  :AccessLog => silent_log )
      puts "Retured from run"
    end
    # WEBrick doesn't give us a way to tell when it's ready other than
    # polling the port, so this is the best we can do to avoid a race
    # with the test
    sleep(0.05) until running?
  end


  def shutdown
    # In theory, this wants to be a Rack::Handler::WEBrick.shutdown.
    # In practice, that hangs.
    @thread.kill
  end


  def self.href
    "http://localhost:#{PORT}/bill.json"
  end


  def href
    self.class.href
  end


  def running?
    uri = URI.parse(self.class.href)
    begin
      Timeout.timeout(0.05) do
        # A HEAD request would be more correct here, but this is less
        # code and doesn't cause any problems
        response = Net::HTTP.get_response(uri)
        !!response
      end
    rescue Timeout::Error, Errno::ECONNREFUSED
      false
    end
  end


end

