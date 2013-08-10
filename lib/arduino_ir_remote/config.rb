module ArduinoIrRemote
  DATA = Hashie::Mash.new YAML::load File.open(File.expand_path '.ir_remote.yml', ENV['HOME']).read
end
