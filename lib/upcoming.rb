require 'upcoming/version'
require 'upcoming/factory'
require 'upcoming/upcoming'

require 'upcoming/generators/generator'
Dir[File.join(File.dirname(__FILE__), 'upcoming', 'generators', '**/*.rb')].each do |generator|
  require generator
end
