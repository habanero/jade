

module Jade
  module NullLegendDrawable
    def draw_legend; end
  end
  
  module LegendDrawable
    def draw_legend
      @graphics.setFont(@font_manager.legend)
      rect_width = font_metrics.getHeight * 0.7
      margin = 20.0
      x = (@image_width - @data_manager.inject(0.0){|total, data| total + string_width(data.name) + rect_width + margin}) / 2.0
      @data_manager.each do |data|
        @graphics.setColor(data.color)
        @graphics.fillRect(x, 20 + ascent * 0.2 , rect_width, rect_width)
        x += rect_width + margin / 2.0
        @graphics.setColor(@color_manager.legend)
        @graphics.drawString(data.name, x, 20 + ascent)
        x += string_width(data.name) + margin / 2.0
      end
      translate_y(20 + ascent)
    end
  end
end