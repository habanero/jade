require 'jade'
require 'jade/rectangle_geometry'

module Jade
  class Line < Base
    include RectangleGeometry
    include LegendDrawable
    include MarkerDrawable
    include LabelDrawable

    def draw_graph
      @graphics.setStroke(BasicStroke.new(6))
      @data_manager.each do |data|
        @graphics.setColor(data.color)
        x = graph_margin_width
        y = nil
        data.data_points.each do |ratio|
          height = (1.0 - ratio) * graph_height
          if y
            @graphics.drawLine(x, y, x+avelage_graph_width, height)
            draw_circle(x, y, 20)
            x += avelage_graph_width
          end
          y = height
        end
        draw_circle(x, y, 20)
      end
      translate_y(graph_height)
    end

    def draw_circle(x, y, diameter)
      @graphics.fillOval(x - diameter*0.5, y - diameter*0.5, diameter, diameter)
    end

    def label_x_pos(h)
      graph_margin_width + avelage_graph_width*h[:index] - string_width(h[:string])/2.0
    end

    def avelage_graph_width
      graph_width / (@data_manager.max_data_points_size - 1)
    end
  end
end
