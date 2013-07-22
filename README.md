Arduino IR::Remote
==================
- IR Learning Remote
- https://github.com/shokai/arduino_ir_remote


Dependencies
------------
- Mac or Linux
  - Ruby 1.8.7 ~ 2.0.0
- [Arduino](http://arduino.cc)
  - [38KHz IR Receiver](http://akizukidenshi.com/catalog/g/gI-00614/)
  - IR LED


Install Dependencies
--------------------

### Setup Arduino

- Firmware
  - https://github.com/shokai/arduino_ir_remote/blob/master/arduino/arduino.ino
- IR LED
  - Digital PIN 12
- IR Receiver
  - Digital PIN 3

### Install Rubygems

    % gem install bundler
    % bundle install


data.yml
--------

save IR data into "data.yml"

    % sample.data.yml data.yml


Run
---

    % bundle exec bin/arduino_ir_remote /dev/tty.usb-devicename
