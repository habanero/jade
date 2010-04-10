

module Jade
  class AbstructDataManager
    include Enumerable

    Data = Struct.new("Data", :name, :data_points, :color)

    def initialize
      @raw_datas = []
      @normalized_datas = []
    end

    def add_data(name, data_points, color)
      @raw_datas << Data.new(name, data_points, color)
    end

    def normalized_datas
      @normalized_datas.clone
    end

    def size
      @normalized_datas.size
    end

    def each
      @normalized_datas.each{ |data| yield data }
    end

    def spread
      @max_value - @min_value
    end
  end

  class LineDataManager < AbstructDataManager
    attr_reader :max_value, :min_value, :max_data_points_size
    
    def normalize
      init_data_points_boundary(@raw_datas.first.data_points)
      
      @raw_datas.each do |d|
        decide_data_points_boundary(d.data_points)
        @max_data_points_size ||= d.data_points.size()
        @max_data_points_size = d.data_points.size() if d.data_points.size() > @max_data_points_size
      end
      create_normalized_data(@max_value - @min_value)
    end

    def max_value=(n)
      @max_value = n.to_f
    end

    def min_value=(n)
      @min_value = n.to_f
    end

    def init_data_points_boundary(ary)
      ary.each do |num|
        next if num.nil?
        @max_value = num.to_f unless instance_variable_defined?(:@max_value)
        @min_value = num.to_f unless instance_variable_defined?(:@min_value)
        break
      end
    end

    def decide_data_points_boundary(ary)
      ary.each do |num|
        next if num.nil?
        num = num.to_f
        @max_value = num if num > @max_value
        @min_value = num if num < @min_value
      end
    end

    def create_normalized_data(spread)
      @normalized_datas = @raw_datas.map do |d|
        normalized = d.data_points.map{|n| n.nil? ? n : (n-@min_value)/ spread }
        Data.new(d.name, normalized, d.color)
      end
    end
  end

  class PieDataManager < AbstructDataManager
    def normalize
      sum = @raw_datas.inject(0){|ret, d| ret += d.data_points}.to_f
      @normalized_datas = @raw_datas.map do |d|
        Data.new(d.name, d.data_points/sum, d.color)
      end
    end
  end
end
