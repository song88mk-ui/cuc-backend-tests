Before('@platformapi') do
  ENV['SERVICE_URL'] = ENV['PLATFORM_PUBLIC_API']
end

Before('@oddsfeed-client-api') do
  ENV['SERVICE_URL'] = ENV['ODDSFEED_CLIENT_API']
end

Before('@oddsfeed-client-platform-api') do
  ENV['SERVICE_URL'] = ENV['ODDSFEED_CLIENT_PLATFORM_API']
end

Before('@operator-api') do
  ENV['SERVICE_URL'] = ENV['PLATFORM_OPERATOR_API']
end

# reset
After do
  ENV['SERVICE_URL']  = ""
end

Before('@requires_client_id') do
  header 'x-client-id', ENV['TEST_CLIENT_ID']
  header 'x-api-key', ENV['PLATFORM_API_KEY']
  header 'accept', 'application/json'
  header 'content-type', 'application/json'
end

After('@requires_client_id') do
  # reset
end

# This helper tag explicitly set the operator token to use
Before('@requires_operator_token') do
  @operator_token = ENV['G01_OPERATOR_TOKEN']
  header 'x-client-id', ENV['TEST_CLIENT_ID']
  header 'x-api-key', ENV['PLATFORM_API_KEY']
  header 'x-operator-token', @operator_token
  header 'accept', 'application/json'
  header 'content-type', 'application/json'
end

After('@requires_operator_token') do
  @operator_token = nil
end
