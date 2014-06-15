require 'upcoming/version'
require 'upcoming/factory'
require 'upcoming/upcoming'

Dir[File.join(File.dirname(__FILE__), 'upcoming', 'generators', '**/*.rb')].each do |generator|
  require generator
end
