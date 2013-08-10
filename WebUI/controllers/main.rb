io = Sinatra::RocketIO
ir = ArduinoIrRemote.connect ENV["ARDUINO"]
logs = []

before '/*' do
  protect!
end

get '/' do
  haml :index
end

get '/style.css' do
  scss :style
end

ir.temp_pin = 0
io.on :start do
  EM::add_periodic_timer 1 do
    io.push :temp_sensor, ir.temp_sensor
    io.push :light_sensor, ir.analog_read(1)
  end
end

io.on :connect do |client|
  $logger.info "new client <#{client}>"
  logs.each do |log|
    io.push :log, log, :to => client.session
  end
end

io.on :disconnect do |client|
  $logger.info "leave client <#{client}>"
end

io.on :ir_write do |name|
  unless ArduinoIrRemote::DATA.has_key? name
    $logger.info "[#{name}] is not ArduinoIrRemote::DATA"
    io.push :log, "[#{name}] is not ArduinoIrRemote::DATA"
  else
    log = "[#{name}] - #{Time.now}"
    $logger.info log
    io.push :log, log
    logs.push log
    while logs.size > 1000
      logs.shift
    end
    ir.write ArduinoIrRemote::DATA[name]
  end
end
