require "rubygems"
require "serialport"
require "event_emitter"
require File.expand_path "config", File.dirname(__FILE__)

module Ir 
  class Remote
    include EventEmitter

    def initialize(port)
      @sp = SerialPort.new(port, 57600, 8, 1, SerialPort::NONE) # 57600bps, 8bit, stopbit1, parity-none
      Thread.new do
        loop do
          recv = @sp.gets.strip
          if recv =~ /^READ,[\d,]+$/
            data = recv.gsub(/^READ,/,"")
            emit :__ir_read, data
          end
          emit :receive, recv
        end
      end
    end

    def write(data)
      "w#{data}W".split(//).each do |c|
        @sp.write c
        sleep 0.001
      end
    end

    def read(&block)
      once :__ir_read, &block if block_given?
      @sp.write "r"
    end
  end
end
