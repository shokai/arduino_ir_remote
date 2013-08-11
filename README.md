Arduino IR::Remote
==================
This rubygem provides a wrapper for IR-Learning-Remote that has been built using the Arduino.

- Read/Write IR Remote on CUI and WebUI
- https://github.com/shokai/arduino_ir_remote
- [Arduinoで赤外線リモコン作ってWebから操作できるようにした](http://shokai.org/blog/archives/8012)


Installation
------------

    % gem install arduino_ir_remote


Dependencies
------------
- Mac or Linux
  - Ruby 1.8.7 ~ 2.0.0
- [Arduino](http://arduino.cc)
  - [38KHz IR Receiver](http://akizukidenshi.com/catalog/g/gI-00614/)
  - IR LED
  - [Temperature Sensor LM35DZ](http://akizukidenshi.com/catalog/g/gI-00116/)


Install Dependencies
--------------------

### Setup Arduino

- Firmware
  - https://github.com/shokai/arduino_ir_remote/blob/master/arduino/arduino.ino
- IR LED
  - Digital PIN 12
- IR Receiver
  - Digital PIN 3
- Temperature Sensor
  - Analog PIN 0

<img src="http://farm4.staticflickr.com/3779/9469310547_ef06fe7949.jpg">
<img src="http://farm4.staticflickr.com/3831/9472093512_fee45ca7c3.jpg">


data.yml
--------

save IR data into "data.yml"

    % sample.data.yml data.yml


Run
---

use default Arduino

    % bundle exec bin/arduino_ir_remote

specify Arduino port

    % bundle exec bin/arduino_ir_remote /dev/tty.usb-devicename


Contributing
------------
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
