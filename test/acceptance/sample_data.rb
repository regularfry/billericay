class SampleData

  def initialize
    this_dir = Pathname.new(__FILE__).dirname
    @data_path = this_dir + "data" + "bill.json"
  end

  def to_s
    @data_path.read
  end

  def to_h
    JSON.parse(raw)
  end


end # SampleData
