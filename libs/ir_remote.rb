require "rubygems"
require "serialport"
require "event_emitter"
require File.expand_path "config", File.dirname(__FILE__)

module IR
  class Remote
    include EventEmitter

    def initialize(port)
      @state = nil
      @sp = SerialPort.new(port, 57600, 8, 1, SerialPort::NONE) # 57600bps, 8bit, stopbit1, parity-none
      Thread.new do
        loop do
          process_input @sp.gets.strip
        end
      end
    end

    private
    def process_input(input)
      case input
      when "READ"
        @state = :read
        return
      when "WRITE"
        @state = :write
        return
      when /^ANALOG\d+$/
        @state = input
      end

      case @state
      when :read
        if input =~ /^[\d,]+$/
          emit :__ir_read, input
          emit :read, input
        end
      when :write
        if input =~ /^[\d,]+$/
          emit :write, input
        end
      when /^ANALOG\d+$/
        if input =~ /^\d+$/
          emit :analog, @state.scan(/(\d+)$/)[0][0].to_i, input.to_i
        end
      else
      end
      emit :data, input
    end

    public
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
