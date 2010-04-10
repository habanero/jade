

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade/pie'

class PieTest < Test::Unit::TestCase
  def test_pie_graph
    assert_nothing_raised do
      g = Jade::Pie.new
      g.title("Pie graph")
      g.theme_keynote
      g.data("Lemon", 35)
      g.data("Apple", 28)
      g.data("Orange", 22)
      g.data("Peach", 15)
      g.write("pie_graph.png")
    end
  end

  def teardown
    File.unlink("pie_graph.png") if File.exist?("pie_graph.png")
  end
end
