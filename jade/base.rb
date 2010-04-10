
module Jade
  class Base
    attr_writer :title

    def initialize(width=800, height=600)
      @image_width = width.to_f
      @remaining_height = @image_height = height.to_f

      @title = ""
      @labels = []
      
      @color_manager = ColorManager.load('default')
      @font_manager = FontManager.load('default')
      initialize_data_manager
    end

    def initialize_data_manager
      @data_manager = LineDataManager.new
    end

    def max_value=(value)
      @data_manager.max_value = value
    end

    def min_value=(value)
      @data_manager.min_value = value
    end

    def data(name, data_points, color=nil)
      color = @color_manager.fetch unless color
      @data_manager.add_data(name, data_points, color)
    end

    def write(filename)
      @data_manager.normalize
      format = Util.check_file_format(filename)
      image = Util.create_image(@image_width, @image_height)
      @graphics = image.getGraphics
      Util.set_rendering_hints_high_quality(@graphics)
      draw_background
      draw_title
      draw_legend
      draw_marker
      draw_graph
      draw_labels
      @graphics.dispose
      Util.write_image(image, format, filename)
    end

    def draw_background
      @graphics.setPaint(@color_manager.background_paint(0, @image_height))
      @graphics.fillRect(0, 0, @image_width, @image_height)
    end

    def draw_title
      @graphics.setColor(@color_manager.title)
      @graphics.setFont(@font_manager.title)
      @graphics.drawString(@title,
                           (@image_width - string_width(@title))/2.0,
                           30 + ascent)
      translate_y(30 + ascent)
    end

    def title(str, &block)
      @title = str
      @font_manager.merge(:title, &block) if block
    end

    def labels(array, &block)
      @labels = array
      @font_manager.merge(:labels, &block) if block
    end

    def legend(&block)
      @font_manager.merge(:legend, &block)
    end

    def maker(&block)
      @font_manager.merge(:maker, &block)
    end

    ColorManager.themes.each do |t|
      method_name = t[/^theme_/] ? t : "theme_" + t
      define_method(method_name) do
        @color_manager = ColorManager.load(t)
      end
    end

    def theme(&block)
      t = ColorManager::Builder.new
      t.instance_eval(&block)
      t.merge(@color_manager)
    end

    private
    
    def font_metrics
      @graphics.getFontMetrics
    end

    def string_width(str)
      font_metrics.stringWidth(str)
    end

    def ascent
      font_metrics.getAscent
    end

    def translate_y(num)
      @graphics.translate(0, num)
      @remaining_height -= num
    end
  end
end
