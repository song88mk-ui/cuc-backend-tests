Then('I will have an operator token') do
  unless last_response.headers['Content-Type'] =~ /json/
    raise "Content-Type is not application/json"
  end

  json = JSON.parse(last_response.body)
  unless json['result']
    raise "Response did not contain a valid JSON with result property"
  end

  unless json['result']['operatorToken']
    raise "No Operator Token Found"
  end

  $tmp_operator_token = json['result']['operatorToken']
end

When('I add the operator token') do
  header 'x-operator-token', $tmp_operator_token
end

When('I add the access token') do
  header 'Authorization', "Bearer " + @access_token
end


Then('show me the operator token') do
  puts "Operator Token = " + @operator_token
end

Then('show me the access token') do
  puts "Operator Token = " + @access_token
end
