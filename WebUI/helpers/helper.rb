helpers do
  def app_name
    "Arduino IR::Remote"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
  end

  def protect!
    return if ENV['BASIC_AUTH_USERNAME'].to_s.empty? or ENV['BASIC_AUTH_PASSWORD'].to_s.empty?
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    username = ENV['BASIC_AUTH_USERNAME']
    password = ENV['BASIC_AUTH_PASSWORD']
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [username, password]
  end
end
