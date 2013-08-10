$:.unshift File.expand_path '../libs', File.dirname(__FILE__)
require 'ir_remote'

ir = IR::Remote.new ARGV.shift
ir.temp_pin = 0

loop do
  0.upto(5).each{ |i|
    puts "[analog#{i}] #{ir.analog_read i}"
  }
  puts "temp #{ir.temp_sensor}"
  sleep 1
end
