
module Jade
  module RectangleGeometry
    private
    
    def graph_margin_width
      @image_width * 0.1
    end

    def graph_width
      @image_width * 0.8
    end

    def graph_margin_height
      @image_height * 0.05
    end

    def graph_height
      @remaining_height * 0.85
    end

    def marker_x_pos
      graph_margin_width * 0.5
    end
  end
end
