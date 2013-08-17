require "yaml"

module ArduinoIrRemote

  DATA_FILE = ENV["IR_DATA_FILE"] || File.expand_path('.ir_remote.yml', ENV['HOME'])
  DATA = File.exists?(DATA_FILE) ? YAML.load_file(DATA_FILE) : {}

  def DATA.save
    File.open DATA_FILE, "w+" do |f|
      f.write self.to_yaml
    end
  end

end
