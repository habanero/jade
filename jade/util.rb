include Java

module Jade
  module Util
    extend self

    def create_color_object(color_name)
      return Color.new(color_name) if color_name.is_a? Numeric
      color_name.split(/\./).inject(Color){|obj, method_name| obj.__send__(method_name.to_sym) }
    end

    def create_gradient_paint(width, height, relatively, colors)
      LinearGradientPaint.new(0, 0, width, height, 
                              relatively.to_java(:float),
                              colors.to_java("java.awt.Color".to_sym))
    end

    def create_image(width, height)
      BufferedImage.new(width, height, BufferedImage::TYPE_INT_RGB )
    end

    AVAILABLE_FILE_FORMAT = ImageIO.getWriterFormatNames.map{|s| s.downcase}.uniq!
    class NotSupportFileFormat <  StandardError; end
    
    def check_file_format(filename)
      ext = File.extname(filename).sub(/^\./, "")
      unless AVAILABLE_FILE_FORMAT.include?(ext)
        raise NotSupportFileFormat, "#{ext}:format error. available format \[#{AVAILABLE_FILE_FORMAT.join(',')}\]"
      end
      ext
    end

    def write_image(image, format, filename)
      ImageIO.write(image, format, java.io.File.new(filename))
    end

    def set_rendering_hints_high_quality(g)
      g.setRenderingHint(RenderingHints::KEY_RENDERING,
                         RenderingHints::VALUE_RENDER_QUALITY)
      g.setRenderingHint(RenderingHints::KEY_ANTIALIASING,
                         RenderingHints::VALUE_ANTIALIAS_ON)
      g.setRenderingHint(RenderingHints::KEY_TEXT_ANTIALIASING,
                         RenderingHints::VALUE_TEXT_ANTIALIAS_ON)
    end
  end
end
