
module Jade
  class FontManager < Loader 'font'

    def self.properties
      [:title, :legend, :labels, :marker]
    end

    def self.new_instance(config)
      f = new
      properties.each do |p|
        font = Font.new(config['font'], Font.const_get(config["#{p}_style"]), config["#{p}_size"])
        f.__send__("#{p}=", font)
      end
      f
    end

    def self.available_font_family_names
      GraphicsEnvironment.getLocalGraphicsEnvironment.getAvailableFontFamilyNames
    end

    attr_accessor(*properties)

    def merge(prop, &block)
      b = Builder.new(__send__(prop))
      b.instance_eval(&block)
      __send__("#{prop}=", b.font)
    end

    class Builder

      def initialize(font)
        @family = font.getFamily
        @style = font.getStyle
        @size = font.getSize
      end

      def family(family_name)
        @family = family_name
      end

      def style(value)
        @style = Font.const_get(value)
      end

      def size(num)
        @size = num
      end

      def font
        Font.new(@family, @style, @size)
      end
    end
  end
end
