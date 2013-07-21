require 'hashie'
require 'yaml'

module Ir
  Config = Hashie::Mash.new YAML::load File.open(File.expand_path '../config.yml', File.dirname(__FILE__)).read
end
