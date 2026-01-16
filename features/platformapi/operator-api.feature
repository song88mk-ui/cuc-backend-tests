@external
@operator-api
Feature: Operator API
  As DevOps
  I want to make sure all the endpoints are working

  Scenario: Authentication
    Given I have platform API Key
    When I send and accept JSON
    When I set headers:
    #| x-operator-token | 17BB8B27-30C7-4C9A-8FBA-7AF9E5F773F5 |
      | x-operator-token | A44009EB-7D51-4A41-B063-4157BA7FBAB0 |
    When I send a POST request to "/v1/authentication" with the following:
    """
      {
        "UserName" : "test",
        "Password" : "test"
      }
    """
    Then the response status should be "200"
    And the JSON response should have "$.statusId" with the text "1000"
