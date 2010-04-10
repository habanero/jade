
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade'

class UtilTest < Test::Unit::TestCase
  def test_create_color_object
    assert_equal(java.awt.Color.white, Jade::Util.create_color_object('white'))
    assert_equal(java.awt.Color.new(0xd1edf5), Jade::Util.create_color_object(0xd1edf5))
    assert_equal(java.awt.Color.gray.brighter, Jade::Util.create_color_object('gray.brighter'))
  end

  def test_create_gradient_paint
    rel = [0.2, 0.8]
    color = [java.awt.Color.white, java.awt.Color.black]

    assert_nothing_raised do
      Jade::Util.create_gradient_paint(100, 200, rel, color)
    end
  end

  def test_create_image
    assert_instance_of(java.awt.image.BufferedImage, Jade::Util.create_image(300, 200))
  end

  def test_check_file_format
    assert_equal("jpeg", Jade::Util.check_file_format("test.jpeg"))
    assert_equal("png", Jade::Util.check_file_format("test.png"))
  end
end
