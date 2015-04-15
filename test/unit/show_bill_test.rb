require_relative("unit_test_case")
require 'show_bill'

class ShowBillTest < UnitTestCase
  def test_root_path
    assert((ShowBill.root + "test").exist?, "No test directory was found in the project root")
  end

  def test_templates_path
    assert(ShowBill.templates.exist?, "No templates directory was found in the project root")
  end
end
