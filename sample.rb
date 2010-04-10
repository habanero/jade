require 'jade/line'
require 'jade/pie'
require 'jade/bar'

#  折れ線グラフ1
g = Jade::Line.new
g.title("Line Graph")
g.data("Lemon", [2, 4, 8, 10, 9])
g.data("Apple", [8, 2, 6 , 0, 3])
g.data("Orange", [0, 1, 3, 7, 8])
g.data("Peach", [6, 10, 2, 1, 5])
g.labels(["2007", "2008", "2009", "2010", "2011"])
g.write("sample/line_graph.png")

#  折れ線グラフ2
#  色のテーマを指定
#  TODO
#  dataを実行した後に、themeを変えても、線の色が変わらないので直す
theme = [:theme_keynote, :theme_37signals, :theme_rails_keynote, :theme_odeo, :theme_pastel, :theme_greyscale]
theme.each do |t|
  g = Jade::Line.new
  g.title("Line Graph")
  g.__send__(t)
  g.data("Lemon", [2, 4, 8, 10, 9])
  g.data("Apple", [8, 2, 6 , 0, 3])
  g.data("Orange", [0, 1, 3, 7, 8])
  g.data("Peach", [6, 10, 2, 1, 5])
  g.labels(["2007", "2008", "2009", "2010", "2011"])
  g.write("sample/line_graph_" + t.to_s + ".png")
end


#  円グラフ
g = Jade::Pie.new
g.title("Pie graph")
g.theme_keynote
g.data("Lemon", 35)
g.data("Apple", 28)
g.data("Orange", 22)
g.data("Peach", 15)
g.write("sample/pie_graph.png")

#  円グラフ2
#  themeを指定
g = Jade::Pie.new
g.title("Pie graph")
g.theme_keynote
g.data("Lemon", 35)
g.data("Apple", 28)
g.data("Orange", 22)
g.data("Peach", 15)
g.theme do
  colors ['yellow', 'red', 'magenta', 'pink']
  title 'white'
  legend 'white'
  marker 'black'
  label 'gray'
  background 0.0 => 'cyan', 0.8 => 'white'
end
g.write("sample/pie_graph_custom_theme.png")


#　棒グラフ
g = Jade::Bar.new
g.title("Bar Graph")
g.theme_37signals
g.data("Lemon", [20, 40, 60, 80, 100])
g.data("Apple", [100, 80, 60 , 40, 20])
g.data("Orange", [20, 80, 20, 80, 20])
g.data("Peach", [22.5, 30.5, 40.5, 80.5, 55.5])
g.min_value= 0
g.labels(["2007", "2008", "2009", "2010", "2011"])
g.write("sample/bar.png")