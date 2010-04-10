
require 'jade'
require 'jade/rectangle_geometry'

module Jade
  class Bar <Base
    include RectangleGeometry
    include LegendDrawable
    include MarkerDrawable
    include LabelDrawable

    def draw_graph
      padding_x = 0
      @data_manager.each do |data|
        x = graph_margin_width
        @graphics.setColor(data.color)
        data.data_points.each do |ratio|
          height = (1.0 - ratio) * graph_height
          @graphics.fillRect(x+padding_x, height, 
                         (avelage_graph_width / @data_manager.normalized_datas.size)*0.9, graph_height-height)
          x += avelage_graph_width
        end
        padding_x += avelage_graph_width / @data_manager.normalized_datas.size
      end
      translate_y(graph_height)
    end

    def avelage_graph_width
      graph_width / (@data_manager.max_data_points_size)
    end

    def label_x_pos(h)
      graph_margin_width + avelage_graph_width*h[:index] +
        (avelage_graph_width - string_width(h[:string]))/2.0
    end
  end
end
