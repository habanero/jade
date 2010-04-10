require 'jade'
require 'jade/circle_geometry'

module Jade
  class Pie < Base
    include CircleGeometry
    include LegendDrawable
    include NullMarkerDrawable
    include NullLabelDrawable
    
    attr_accessor :zero_degree
    def initialize(width=800, height=600)
      super(width.to_f, height.to_f)
      @zero_degree = 90
    end

    def initialize_data_manager
      @data_manager = PieDataManager.new
    end

    def draw_graph
      translate_y(graph_margin_height)
      @graphics.setFont(@graphics.getFont.deriveFont(Font::BOLD, 18))
      prev_degrees = @zero_degree
      total_angle = 0
      @data_manager.each do |data|
        angle = (360.0 * data.data_points).to_i
        angle = 360 - total_angle if @data_manager.normalized_datas.last == data
        draw_percent((data.data_points*100).to_i.to_s + "%", prev_degrees + angle/2.0)
        @graphics.setColor(data.color)
        fill_arc(prev_degrees, angle)
        prev_degrees += angle
        total_angle += angle
      end
    end

    def draw_percent(str, angle)
      rad = degree_to_radian(angle)
      x = center_x + java.lang.Math.cos(rad) * (radius * 1.2)
      y = center_y + java.lang.Math.sin(rad) * (radius * 1.2) * (-1)

      # 円の上側、または下側に描くときは、Y座標を調整して描く
      offset_y = 0
      offset_y += 10 if java.lang.Math.sin(rad) > 0.5
      offset_y -= 25 if java.lang.Math.sin(rad) < -0.5

      @graphics.setColor(@color_manager.marker)
      @graphics.drawString(str, x, y + offset_y)
    end

    def fill_arc(start_arc, angle)
      x = (@image_width - diameter) / 2.0
      @graphics.fillArc(x, 0, diameter, diameter, start_arc, angle)
    end
  end
end
