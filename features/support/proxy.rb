require 'rack/proxy'

class Proxy < Rack::Proxy

  def rewrite_env(env)
    backend = URI(ENV['SERVICE_URL'])
    env['HTTP_HOST'] = backend.host
    env['HTTP_USER_AGENT'] = ENV['USER_AGENT'] || "UnknownUserAgent/1.0.0"
    env['SERVER_NAME'] = backend.host
    env['SERVER_PORT'] = backend.port
    env['HTTP_X_FORWARDED_PROTO'] = backend.scheme
    env['rack.url_scheme'] = backend.scheme
    env['HTTPS'] = 'on' if backend.scheme == 'https'
    env
  end

  def perform_request(env)
    super(env)
  end
end
