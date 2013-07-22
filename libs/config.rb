require "hashie"
require "yaml"

module Ir
  DATA = Hashie::Mash.new YAML::load File.open(File.expand_path '../data.yml', File.dirname(__FILE__)).read
end
