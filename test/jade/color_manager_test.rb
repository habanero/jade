

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade'

class ColorManagerTest < Test::Unit::TestCase
  def setup
    @color_manager = Jade::ColorManager.load('default')
  end

  def test_interface
    public_methods = [
      :fetch,
      :title,
      :legend,
      :marker,
      :label
    ]
    public_methods.each do |name|
      assert_respond_to(@color_manager, name)
    end
  end

  def test_theme
    theme = [
      'default',
      'keynote',
      'theme_37signals',
      'rails_keynote',
      'odeo'
    ]

    theme.each do |t|
      m = Jade::ColorManager.load(t)
      assert_instance_of(java.awt.Color, m.title)
      assert_instance_of(java.awt.Color, m.legend)
      assert_instance_of(java.awt.Color, m.marker)
      assert_instance_of(java.awt.Color, m.label)
      assert_instance_of(java.awt.LinearGradientPaint, m.background_paint(100, 200))
    end
  end
end
