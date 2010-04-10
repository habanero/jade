

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade/line'

class LineTest < Test::Unit::TestCase
  def test_Jade_line
    assert_nothing_raised do
      g = Jade::Line.new
      g.title("Line Graph")
      g.data("Lemon", [2, 4, 8, 10, 9])
      g.data("Apple", [8, 2, 6 , 0, 3])
      g.data("Orange", [0, 1, 3, 7, 8])
      g.data("Peach", [6, 10, 2, 1, 5])
      g.labels(["2007", "2008", "2009", "2010", "2011"])
      g.write("line_graph.png")
    end

    assert_nothing_raised do
      g = Jade::Line.new
      g.title("Line Graph")
      g.data("Lemon", [2, 4])
      g.data("Apple", [8, 2])
      g.labels(["2007", "2008"])
      g.write("line_graph.png")
    end

    assert_nothing_raised do
      g = Jade::Line.new
      g.title("Line Graph")
      g.theme_keynote
      g.data("Lemon", [2, 4, 6])
      g.data("Apple", [8, 2, 5])
      g.data("Orange", [3, 1, 3])
      g.data("Peach", [6, 9, 2])
      g.labels(["2007", "2008", "2009"])
      g.min_value = 0
      g.max_value = 10
      g.write("line_graph.png")
    end
  end

  def test_theme_not_raised
    assert_nothing_raised do
      g = Jade::Line.new
      g.data("Lemon", [2, 4, 8, 10, 9])
      g.data("Apple", [8, 2, 6 , 0, 3])
      g.data("Orange", [0, 1, 3, 7, 8])
      g.data("Peach", [6, 10, 2, 1, 5])
      g.labels(["2007", "2008", "2009", "2010", "2011"])
      g.theme do
        colors ['black', 'white', 'yellow']
        title 'black'
        legend 'black'
        marker 'black'
        label 'black'
        background 0.0 => 'black', 0.8 => 'white'
      end
      g.write("line_graph.png")
    end
  end

  def teardown
    File.unlink("line_graph.png") if File.exist?("line_graph.png")
  end
end
