
module Jade
  module NullLabelDrawable
    def draw_labels; end
  end
  
  module LabelDrawable
    def draw_labels
      @graphics.setColor(@color_manager.label)
      @graphics.setFont(@font_manager.labels)
      @labels.each_with_index do |str, i|
        @graphics.drawString(str, label_x_pos(:index => i, :string => str), ascent*1.5)
      end
    end
  end
end
