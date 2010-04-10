require 'yaml'

module Jade
  def self.Loader(type)
    path = File.join(File.dirname(__FILE__), type)
    klass = Class.new
    meta = class<<klass; self; end
    meta.__send__(:define_method, :load_path) do
      path
    end

    meta.__send__(:define_method, :load) do |filename|
      data = File.read(File.join(load_path() , filename + '.yml'))
      new_instance(YAML.load(data))
    end
    klass
  end
end
