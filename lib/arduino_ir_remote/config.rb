module ArduinoIrRemote
  DATA_FILE = File.expand_path '.ir_remote.yml', ENV['HOME']
  DATA = Hashie::Mash.new YAML::load File.open(DATA_FILE).read
end
