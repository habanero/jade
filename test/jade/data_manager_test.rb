

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'jade'

class DataManagerTest < Test::Unit::TestCase
  def test_normalize
    m = Jade::LineDataManager.new
    m.add_data("comp1", [0, 1, 2, 3, 4, 5], nil)
    m.add_data("comp2", [10, 9, 8, 7, 6, 5], nil)
    m.normalize

    assert_equal(10, m.max_value)
    assert_equal(0, m.min_value)
    assert_equal(6, m.max_data_points_size)
    assert_equal("comp1", m.normalized_datas[0].name)
    assert_equal([0, 0.1, 0.2, 0.3, 0.4, 0.5], m.normalized_datas[0].data_points)
    assert_equal("comp2", m.normalized_datas[1].name)
    assert_equal([1.0, 0.9, 0.8, 0.7, 0.6, 0.5], m.normalized_datas[1].data_points)


    m = Jade::LineDataManager.new
    m.add_data("comp1", [-1, 0, 1, 2], java.awt.Color.white)
    m.add_data("comp2", [9, 8, 7, 6, 5, 4, 3, 2, 1], java.awt.Color.blue)
    m.add_data("comp3", [0, 3], nil)
    m.normalize

    assert_equal(9, m.max_value)
    assert_equal(-1, m.min_value)
    assert_equal(9, m.max_data_points_size)
    assert_equal("comp1", m.normalized_datas[0].name)
    assert_equal([0.0, 0.1, 0.2, 0.3], m.normalized_datas[0].data_points)
    assert_equal(java.awt.Color.white, m.normalized_datas[0].color)
    assert_equal("comp2", m.normalized_datas[1].name)
    assert_equal([1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2], m.normalized_datas[1].data_points)
    assert_equal(java.awt.Color.blue, m.normalized_datas[1].color)
    assert_equal("comp3", m.normalized_datas[2].name)
    assert_equal([0.1, 0.4], m.normalized_datas[2].data_points)

    m = Jade::PieDataManager.new
    m.add_data("comp1", 1, nil)
    m.add_data("comp2", 7, nil)
    m.add_data("comp3", 2, nil)
    m.normalize

    assert_equal("comp1", m.normalized_datas[0].name)
    assert_equal(0.1, m.normalized_datas[0].data_points)
    assert_equal("comp2", m.normalized_datas[1].name)
    assert_equal(0.7, m.normalized_datas[1].data_points)
    assert_equal("comp3", m.normalized_datas[2].name)
    assert_equal(0.2, m.normalized_datas[2].data_points)
  end
end
