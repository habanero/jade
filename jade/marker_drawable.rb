
module Jade
  module NullMarkerDrawable
    def draw_marker;end
  end

  module MarkerDrawable
    def draw_marker
      translate_y(graph_margin_height)
      @graphics.setColor(@color_manager.marker)
      @graphics.setFont(@font_manager.marker)

      m = case  @data_manager.spread
      when 0 then LineDrawerDataPointsNotSeparate
      when 1 then LineDrawerDataPoints1TimeSeparate
      else        LineDrawerDataPointsManyTimesSeparate
      end
      extend m
      __draw_marker
    end

    module LineDrawerDataPointsManyTimesSeparate
      DIVIDE_RANGE_CANDIDATE = (3..7)
      
      def __draw_marker
        marker_divide_number.times do |i|
          @graphics.drawString((@data_manager.max_value - @data_manager.spread*i/marker_divide_number).to_i.to_s,
                               marker_x_pos, graph_height * i/marker_divide_number + ascent*0.5)
          @graphics.drawLine(graph_margin_width, graph_height * i/marker_divide_number,
                             graph_margin_width + graph_width, graph_height * i/marker_divide_number)
        end
        @graphics.drawString(@data_manager.min_value.to_i.to_s, marker_x_pos, graph_height + ascent*0.5)
        @graphics.drawLine(graph_margin_width, graph_height,
                           graph_margin_width + graph_width, graph_height)
      end

      def marker_divide_number
        DIVIDE_RANGE_CANDIDATE.each{|i| return i if @data_manager.spread % i == 0 }
        2
      end
    end

    module LineDrawerDataPoints1TimeSeparate
      def draw_top_marker
        @graphics.drawString(@data_manager.max_value.to_i.to_s, marker_x_pos, ascent*0.5)
        @graphics.drawLine(graph_margin_width, 0,
                           graph_margin_width + graph_width, 0)
      end

      def draw_under_marker
        @graphics.drawString(@data_manager.min_value.to_i.to_s, marker_x_pos, graph_height + ascent*0.5)
        @graphics.drawLine(graph_margin_width, graph_height,
                           graph_margin_width + graph_width, graph_height)
      end

      def __draw_marker
        draw_top_marker
        draw_under_marker
      end
    end

    module LineDrawerDataPointsNotSeparate
      include LineDrawerDataPoints1TimeSeparate
      def draw_under_marker
      end
    end
  end
end
