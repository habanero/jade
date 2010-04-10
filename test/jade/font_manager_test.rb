
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade'

class FontManagerTest < Test::Unit::TestCase

  def setup
    @fm = Jade::FontManager.load('default')
  end

  def test_title_font
    @fm.merge(:title) do
      family 'Serif'
      style 'PLAIN'
      size 20
    end

    assert_equal 'Serif', @fm.title.getFamily
    assert_equal Java::JavaAwt::Font::PLAIN, @fm.title.getStyle
    assert_equal 20, @fm.title.getSize
  end

  def test_legend_font
    @fm.merge(:legend) do
      family "SansSerif"
      style 'ITALIC'
      size  38
    end

    assert_equal "SansSerif", @fm.legend.getFamily
    assert_equal Java::JavaAwt::Font::ITALIC, @fm.legend.getStyle
    assert_equal 38, @fm.legend.getSize
  end

  def test_labels_font
    @fm.merge(:labels) do
      family "Arial"
      style 'BOLD'
      size 12
    end

    assert_equal "Arial", @fm.labels.getFamily
    assert_equal Java::JavaAwt::Font::BOLD, @fm.labels.getStyle
    assert_equal 12, @fm.labels.getSize
  end

  def test_marker_font
    @fm.merge(:marker) do
      family "Monospaced"
      style 'ITALIC'
      size 30
    end

    assert_equal "Monospaced", @fm.marker.getFamily
    assert_equal Java::JavaAwt::Font::ITALIC, @fm.marker.getStyle
    assert_equal 30, @fm.marker.getSize
  end
end
