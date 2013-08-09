Arduino IR::Remote WebUI
========================
controll IR Learning Remote via Web.

<img src="http://farm6.staticflickr.com/5498/9343211005_69a25a811e.jpg">

Dependencies
------------
- Ruby 1.8.7 ~ 2.0.0


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

    % export BASIC_AUTH_USERNAME=username
    % export BASIC_AUTH_PASSWORD=password
    % export ARDUINO=/dev/tty.device-name
    % export WS_PORT=9000
    % bundle exec rackup config.ru -p 5000

=> http://localhost:5000


Install as a Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app arduino-ir-remote -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/arduino-ir-remote-web-1.plist

for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app arduino-ir-remote -d `pwd` -u `whoami`
    % sudo service arduino-ir-remote start
