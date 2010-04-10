
module Jade
  class ColorManager < Loader 'theme'
    def self.properties
      [:colors, :title, :legend, :marker, :label, :background]
    end

    def self.themes
      Dir.entries(load_path()).select{|file| file =~ /\.yml$/}.map{|file| file.sub("\.yml", "")}
    end

    def self.new_instance(config)
      c = new
      c.colors = config['colors'].map{|color_name| Util.create_color_object(color_name)}
      c.title  = Util.create_color_object(config['title'])
      c.legend = Util.create_color_object(config['legend'])
      c.marker = Util.create_color_object(config['marker'])
      c.label  = Util.create_color_object(config['label'])
      c.background = config['background']
      c
    end

    attr_accessor(*properties)

    def initialize()
      @colors = [Color.white]
      @pos = 0
      @title = @legend = @marker = @label = Color.white

      @background = { 0.0 => 'black', 1.0 => 'white' }
    end

    def background_paint(width, height)
      relatively = []
      colors = []
      @background.keys.sort.each do |k|
        relatively << k
        colors << Util.create_color_object(@background[k])
      end
      Util.create_gradient_paint(width, height, relatively, colors)
    end

    def fetch
      ret = @colors[@pos]
      @pos = (@pos + 1) % @colors.length
      ret
    end

    class Builder
      ColorManager.properties.each do |prop|
        define_method(prop) do |value|
          instance_variable_set( "@#{prop}", value)
        end
      end

      def merge(color_manager)
        ColorManager.properties.each do |prop|
          if value = instance_variable_get("@#{prop}")
            value = case prop
              when :background
                value
              when :colors
                value.map{|color_name| Util.create_color_object(color_name)}
              else
                Util.create_color_object(value)
              end
            color_manager.__send__("#{prop}=", value)
          end
        end
      end
    end # Builder
  end # ColorManager
end