
module Jade
  module CircleGeometry
    private
    
    def degree_to_radian(deg)
      2 * java.lang.Math::PI * (deg/360.0)
    end

    def center_x
      @image_width * 0.5
    end

    def center_y
      @remaining_height * 0.5
    end

    def diameter
      @remaining_height * 0.9
    end

    def radius
      diameter * 0.5
    end

    def graph_margin_height
      @image_height * 0.05
    end
  end
end
