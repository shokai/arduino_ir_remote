$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'arduino_ir_remote'

ir = ArduinoIrRemote.connect ARGV.shift
ir.temp_pin = 0

loop do
  0.upto(5).each{ |i|
    puts "[analog#{i}] #{ir.analog_read i}"
  }
  puts "temp #{ir.temp_sensor}"
  sleep 1
end
