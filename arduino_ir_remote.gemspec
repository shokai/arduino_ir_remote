# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arduino_ir_remote/version'

Gem::Specification.new do |spec|
  spec.name          = "arduino_ir_remote"
  spec.version       = ArduinoIrRemote::VERSION
  spec.authors       = ["Sho Hashimoto"]
  spec.email         = ["hashimoto@shokai.org"]
  spec.description   = %Q{This Rubygem provides a wrapper for IR-Learning-Remote that has been built using the Arduino.\nPlease setup Arduino -> https://github.com/shokai/arduino_ir_remote}
  spec.summary       = spec.description
  spec.post_install_message = spec.description
  spec.homepage      = "https://github.com/shokai/arduino_ir_remote"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).reject{|i| i=="Gemfile.lock" }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "serialport"
  spec.add_dependency "args_parser"
  spec.add_dependency "event_emitter"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
