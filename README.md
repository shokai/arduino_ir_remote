Arduino IR::Remote
==================
This Rubygem provides a wrapper for IR-Learning-Remote that has been built using the Arduino.

- https://github.com/shokai/arduino_ir_remote
- Read/Write IR Remote on CUI and WebUI
- [Arduinoで赤外線リモコン作ってWebから操作できるようにした](http://shokai.org/blog/archives/8012)


Installation
------------

    % gem install arduino_ir_remote


Dependencies
------------

### Requirements

- Mac or Linux
  - Ruby 1.8.7 ~ 2.0.0
- [Arduino](http://arduino.cc), testing on Micro or Leonard
  - [38KHz IR Receiver](http://akizukidenshi.com/catalog/g/gI-00614/)
  - IR LED
  - [Temperature Sensor LM35DZ](http://akizukidenshi.com/catalog/g/gI-00116/)

### Hardware Setup

- Arduino Firmware
  - `arduino` directory in this repository
  - https://github.com/shokai/arduino_ir_remote/blob/master/arduino/arduino.ino
- IR LED
  - Digital PIN 12
- IR Receiver
  - Digital PIN 3
- Temperature Sensor (optional)
  - Analog PIN 0
- Additional Sensors (optional)
  - Analog PIN 1~5


IR Receiver + LED (Minimum setup)
<a href="http://www.flickr.com/photos/shokai/9367954015/"><img src="http://farm3.staticflickr.com/2843/9367954015_6035e68d8d_z.jpg"></a>


IR Receiver + LED + Temperature Sensor + CdS
<a href="http://www.flickr.com/photos/shokai/9508961982/"><img src="http://farm3.staticflickr.com/2818/9508961982_54948f1303_z.jpg"></a><a href="http://www.flickr.com/photos/shokai/9506165953/"><img src="http://farm3.staticflickr.com/2861/9506165953_14c36e50cc_z.jpg"></a>


Usage
-----

### arduino_ir_remote command


    % arduino_ir_remote --help
    % arduino_ir_remote --list

Read IR Data

    % arduino_ir_remote --read tv_on

Write IR Data

    % arduino_ir_remote --write tv_on



### Rubygem

Connect
```ruby
require 'arduino_ir_remote'

ir = ArduinoIrRemote.connect   # use default device
ir = ArduinoIrRemote.connect "/dev/tty.usb-devicename"
```

Read IR DATA
```ruby
ir.read do |data|
  p data
end
ir.wait
```

Write IR DATA
```ruby
ir.write data
ir.wait
```

Read Sensors
```ruby
ir.temp_pin = 0  # set temperature sensor pin

loop do
  0.upto(5).each{ |i|
    puts "[analog#{i}] #{ir.analog_read i}"  # read analog input pin 0~5
  }
  puts "temp #{ir.temp_sensor}"  # read temperature sensor
  sleep 1
end
```


Test
----

    % gem install bundler
    % bundle install
    % export ARDUINO=/dev/tty.usb-devicename
    % bundle exec rake test


Contributing
------------
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
