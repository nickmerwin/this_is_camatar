# Install hook code here
require 'fileutils'

FileUtils.cp File.dirname(__FILE__) + '/camatar.swf', "#{RAILS_ROOT}/public"
FileUtils.cp File.dirname(__FILE__) + '/camatar_example.swf', "#{RAILS_ROOT}/config/camatar.yml"
puts IO.read(File.join(File.dirname(__FILE__), 'README'))