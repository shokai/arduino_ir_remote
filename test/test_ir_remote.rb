require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestIrRemote < MiniTest::Test

  def setup
    @ir = ArduinoIrRemote.connect ENV["ARDUINO"]
  end

  def teardown
    @ir.close
  end

  def test_analog_read
    0.upto(5) do |pin|
      ain = @ir.analog_read pin
      assert 0 <= ain and ain < 1024
    end
  end

  def test_temp_sensor
    assert_instance_of Float, @ir.temp_sensor
  end

end
