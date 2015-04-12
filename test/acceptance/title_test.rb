require_relative "capybara_test_case"

class TitleTest < CapybaraTestCase
  def test_shows_statement_title
    visit("/")
    title_node = page.find("h1")
    assert(title_node, "There is no statement title.")
  end
end
