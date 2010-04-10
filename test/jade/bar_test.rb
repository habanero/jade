# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade/bar'

class BarTest < Test::Unit::TestCase
  def test_bar_graph
    assert_nothing_raised do
      g = Jade::Bar.new
      g.title("Bar Graph")
      g.theme_37signals
      g.data("Lemon", [20, 40, 60, 80, 100])
      g.data("Apple", [100, 80, 60 , 40, 20])
      g.data("Orange", [20, 80, 20, 80, 20])
      g.data("Peach", [22.5, 30.5, 40.5, 80.5, 55.5])
      g.min_value= 0
      g.labels(["2007", "2008", "2009", "2010", "2011"])
      g.write("bar.png")  
    end
  end

  def teardown
    File.unlink("bar.png") if File.exist?("bar.png")
  end
end
