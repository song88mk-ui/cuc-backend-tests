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
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Bet Placement
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
    Then show me the response
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "104"
    And the JSON response should have "$.message" with the text "Insufficient Funds"

  @requires_operator_token
  Scenario: Max Stake API
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
    Then show me the response
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "104"
    And the JSON response should have "$.message" with the text "Insufficient Funds"

  @requires_operator_token
  Scenario: Bet Config
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a GET request to "/v1/bet/config" with the following:
    #Examples:
      | currencyCode | EUR |
    Then the response status should be "200"

  @requires_operator_token
  Scenario: Bet Status
    When I add the operator token
    When I set headers:
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a GET request to "/v1/bet/status" with the following:
    # Examples
      | betId | 6c97ec01-8c6d-46ac-a84e-548f004de304 |
    # assuming this bet id is not found on the db
    Then the response status should be "400"
    And the JSON response should have "$.message" with the text "Object reference not set to an instance of an object."
