namespace :camatar do
  desc "Generate new config/camatar_config.yml"
  task :generate_config do
    require 'ftools'
    File.copy "#{RAILS_ROOT}/vendor/plugins/camatar/camatar_example.yml", "#{RAILS_ROOT}/config/camatar.yml"
    puts "camatar.yml has been placed in your config directory, please fill it out now."
  end
end