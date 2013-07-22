require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'logger'
$logger = Logger.new $stdout
if development?
  $stdout.sync = true
  $logger.level = Logger::INFO
  require 'sinatra/reloader'
elsif production?
  $logger.level = Logger::WARN
end

require 'sinatra/rocketio'
require 'sinatra/content_for'
require 'haml'
require 'sass'
require 'json'
require 'hashie'
$:.unshift File.expand_path '../', File.dirname(__FILE__)
require 'libs/ir_remote'
require 'WebUI/helpers/helper'
require 'WebUI/controllers/main'

set :haml, :escape_html => true

case RUBY_PLATFORM
when /linux/i then EM.epoll
when /bsd/i then EM.kqueue
end
EM.set_descriptor_table_size 20000

run Sinatra::Application
