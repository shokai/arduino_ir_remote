Arduino IR::Remote
==================
IR Learning Remote

- Read/Write IR Remote on CUI and WebUI
- https://github.com/shokai/arduino_ir_remote
- [Arduinoで赤外線リモコン作ってWebから操作できるようにした](http://shokai.org/blog/archives/8012)

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

<img src="http://farm8.staticflickr.com/7282/9343246881_4bccff6386.jpg">

### Install Rubygems

    % gem install bundler
    % bundle install


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
