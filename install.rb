# Install hook code here
require 'fileutils'

FileUtils.cp File.dirname(__FILE__) + '/camatar.swf', "/../../../public"
FileUtils.cp File.dirname(__FILE__) + '/camatar_example.yml', "/../../../config/camatar.yml"
puts IO.read(File.join(File.dirname(__FILE__), 'README'))