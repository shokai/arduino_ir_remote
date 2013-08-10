module ArduinoIrRemote
  def self.list
    Dir.entries('/dev').grep(/tty\.?(usb|acm)/i).map{|fname| "/dev/#{fname}"}
  end

  def self.connect(port=nil)
    port = list[0] unless port
    raise ArgumentError, "IR Remote not found" unless port
    ArduinoIrRemote::Device.new port || list[0]
  end
end
