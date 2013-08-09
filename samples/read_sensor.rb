$:.unshift File.expand_path '../libs', File.dirname(__FILE__)
require 'ir_remote'

ir = IR::Remote.new ARGV.shift
ir.temp_pin = 0

ir.on :analog do |pin, value|
  puts "[analog#{pin}] #{value}"
end
ir.on :temp do |temp|
  puts "temp #{temp}"
end

loop do
  sleep 1
end
