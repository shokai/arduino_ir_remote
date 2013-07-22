helpers do
  def app_name
    "Arduino IR::Remote"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
  end
end
