@external
@oddsfeed
@oddsfeed-client-platform-api
Feature: OddsFeed Client Platform API
  As DevOps
  I want to make sure all the endpoints are working

  Scenario: Unauthenticated Request to competitors endpoint
    When I send a GET request to "/v1/platform/competitor/sr:competitor:100" with the following:
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "101"
    And the JSON response should have "$.message" with the text "Missing Or Unsupported APIKey In Request Headers"

  Scenario: No API Key but with ClientID Header
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send a GET request to "/v1/platform/competitor/sr:competitor:100" with the following:
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "101"
    And the JSON response should have "$.message" with the text "Missing Or Unsupported APIKey In Request Headers"

  Scenario: Authenticated Request with ClientID
    Given I have oddsfeed API Key
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send a GET request to "/v1/platform/competitor/sr:competitor:100" with the following:
    Then show me the response
    #Then the response status should be "200"
    #And the JSON response should have "$.statusCode" with the text "100"
    #And the JSON response should have "$.message" with the text "Success"
