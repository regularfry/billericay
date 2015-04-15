require 'pathname'
require_relative("show_bill/app")

module ShowBill
  def self.root
    (Pathname.new(__FILE__) + ".." + "..").expand_path
  end

  def self.templates
    root + "templates"
  end
end
