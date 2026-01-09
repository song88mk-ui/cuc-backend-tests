@external
@platformapi
@betting
Feature: Platform Integration API - Betting
  As DevOps
  I want to make sure all the endpoints are working

  @current
  @requires_operator_token
  Scenario: Get Balance
    When I send a GET request to "/v1/wallet/balance"
    Then show me the response
    Then the response status should be "200"
    And the "statusCode" should be "100"
    And the "message" should be "Success"
    And the "result.currencyCode" should have "USD"

  @requires_operator_token
  @error
  Scenario: Bet Placement - Error
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a POST request to "/v2/bet/placement" with the following:
    """
    {
      "BetDate": "2025-12-01T10:34:59.581Z",
      "BetId": "0e0a5a17-64c0-48f9-a33e-f49a737932d2",
      "Channel": 0,
      "CurrencyCode": "CNY",
      "IPAddress": "127.0.0.1",
      "IPAddressV6": "",
      "OddsChangeType": 1,
      "OddsType": 0,
      "UserId": "none",
      "Stake": 10.01,
      "Selections": [
        {
          "FixtureSpecifier": "bg:match:123456",
          "MarketSpecificer": "",
          "Odds": 1.54,
          "MarketTemplateId": "1",
          "SelectionTemplateId": "1"
        }
      ]
    }
    """
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "1000"
    And the JSON response should have "$.message" with the text "Error"
    And the "result" should be null

  @requires_operator_token
  @error
  Scenario: Max Stake API - Error
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a POST request to "/v2/bet/placement" with the following:
    """
    {
      "BetDate": "2025-12-01T10:34:59.581Z",
      "BetId": "0e0a5a17-64c0-48f9-a33e-f49a737932d2",
      "Channel": 0,
      "CurrencyCode": "CNY",
      "IPAddress": "127.0.0.1",
      "IPAddressV6": "",
      "OddsChangeType": 1,
      "OddsType": 0,
      "UserId": "none",
      "Stake": 10.01,
      "Selections": [
        {
          "FixtureSpecifier": "bg:match:123456",
          "MarketSpecificer": "",
          "Odds": 1.54,
          "MarketTemplateId": "1",
          "SelectionTemplateId": "1"
        }
      ]
    }
    """
    Then the response status should be "400"
    And the "statusCode" should be "1000"
    And the "message" should be "Error"
    And the "result" should be null

  @requires_operator_token
  Scenario: Bet Config
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a GET request to "/v1/bet/config" with the following:
      | currencyCode | EUR |
    Then the response status should be "200"
    And the "statusCode" should be "100"
    And the "message" should be "Success"

  @requires_operator_token
  @GM-115
  Scenario: Bet Status for Unknown betId
    When I add the operator token
    When I use the test client id
    When I send and accept JSON
    When I send a GET request to "/v1/bet/status" with the following:
      | betId | 00000000-0000-0000-0000-000000000000 |
    Then the response status should be "400"
    And the "statusCode" should be "1000"
    And the "message" should be "Object reference not set to an instance of an object."
    And the "result" should be "0"

  @requires_operator_token
  @GM-115
  Scenario: Bet Status for known betId
    When I add the operator token
    When I use the test client id
    When I send and accept JSON
    When I send a GET request to "/v1/bet/status" with the following:
      | betId | F3CC5901-D3FB-4A2F-36AB-08DE4F7FD84D |
    Then the response status should be "200"
    And the "statusCode" should be "100"
    And the "message" should be null
