# Install hook code here
require 'fileutils'
pwd = File.dirname(__FILE__)
FileUtils.cp  "#{pwd}/camatar.swf", "#{pwd}/../../../public"
FileUtils.cp "#{pwd}/camatar_example.yml", "#{pwd}/../../../config/camatar.yml"
puts IO.read(File.join(pwd, 'README.markdown'))