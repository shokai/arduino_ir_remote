io = Sinatra::RocketIO
raise ArgumentError, 'please set ENV["ARDUINO"]' unless ENV["ARDUINO"]
ir = Ir::Remote.new ENV["ARDUINO"]

get '/' do
  haml :index
end

get '/style.css' do
  scss :style
end

io.on :connect do |client|
  $logger.info "new client <#{client}>"
end

io.on :disconnect do |client|
  $logger.info "leave client <#{client}>"
end

io.on :ir_write do |name|
  unless Ir::DATA.has_key? name
    $logger.info "[#{name}] is not Ir::DATA"
    io.push :log, "[#{name}] is not Ir::DATA"
  else
    $logger.info "[#{name}]"
    io.push :log, "[#{name}]"
    ir.write Ir::DATA[name]
  end
end
