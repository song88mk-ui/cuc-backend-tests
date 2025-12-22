require 'rack'
require 'rack/test'
require 'rspec'
require 'cucumber/api_steps'

require 'active_support'
require 'active_support/core_ext'

require 'dotenv/load'

module RackProxyHelper
  def app
    Rack::Builder.new do
      use Proxy, :backend => ENV['SERVICE_URL']
      run lambda { |env| [200, { 'Content-Type' => 'text/html' }, ['Hello from the proxy!']] }
    end
  end
end

World(RackProxyHelper)
