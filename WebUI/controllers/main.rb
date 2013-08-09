io = Sinatra::RocketIO
ir = IR::Remote.new ENV["ARDUINO"]
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
  unless IR::DATA.has_key? name
    $logger.info "[#{name}] is not IR::DATA"
    io.push :log, "[#{name}] is not IR::DATA"
  else
    log = "[#{name}] - #{Time.now}"
    $logger.info log
    io.push :log, log
    logs.push log
    while logs.size > 1000
      logs.shift
    end
    ir.write IR::DATA[name]
  end
end
