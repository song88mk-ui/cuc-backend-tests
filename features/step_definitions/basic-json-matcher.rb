require 'jsonpath'
require 'nokogiri'

Then /^the "([^"]*)" should (not)?\s?(have|be) "([^"]*)"$/ do |negative, _, field, value|
  json = JSON.parse(last_response.body)
  json_path = "$.#{field}"
  result = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  if self.respond_to?(:expect)
    if negative.present?
      expect(result).not_to include(value)
    else
      expect(result).to include(value)
    end
  else
    if negative.present?
      assert !result.include?(value)
    else
      assert result.include?(value)
    end
  end
end

## nullability
Then /^the "([^"]*)" should be null$/ do |field|
  json = JSON.parse(last_response.body)
  json_path = "$.#{field}"
  result = JsonPath.new(json_path).on(json).to_a.map(&:to_s)
  if self.respond_to?(:expect)
    expect(result[0]).to eq("")
  else
    assert_nil result[0]
  end
end
