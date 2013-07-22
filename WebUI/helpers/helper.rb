helpers do
  def app_name
    "Arduino Ir::Remote"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
  end
end
