# Install hook code here
require 'ftools'
File.cp 'camatar.swf', "#{RAILS_ROOT}/public"
File.cp 'camatar_example.swf', "#{RAILS_ROOT}/config/camatar.yml"