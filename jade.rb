include Java

%w( 
    include_java_class
    util
    loader
    color_manager
    font_manager
    data_manager
    base
    legend_drawable
    marker_drawable
    label_drawable
   ).each do |filename|
  require File.join(File.dirname(__FILE__), "jade", filename)
end
