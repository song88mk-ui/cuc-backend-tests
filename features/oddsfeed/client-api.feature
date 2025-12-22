@external
@oddsfeed
@oddsfeed-client-api
Feature: OddsFeed Client API
  As DevOps
  I want to make sure all the endpoints are working

  Scenario: Unauthenticated Request to livestream
    When I send a GET request to "/v1/livestream/0" with the following:
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "101"
    And the JSON response should have "$.message" with the text "Missing Or Unsupported APIKey In Request Headers"

  Scenario: Authenticated Request to livestream
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 1.2.3.4 |
    When I send a GET request to "/v1/livestream/0" with the following:
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "123"
    And the JSON response should have "$.message" with the text "Fixture Has No Livestream"

  Scenario: Livestream on Invalid IPv4
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 1.256.0.1  |
    When I send a GET request to "/v1/livestream/0" with the following:
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "122"
    And the JSON response should have "$.message" with the text "IPAddress Must Be IPv4"

  Scenario: Livestream does not support IPv6
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | xfe80::7897:01:03:c2e0  |
    When I send a GET request to "/v1/livestream/0" with the following:
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "122"
    And the JSON response should have "$.message" with the text "IPAddress Must Be IPv4"

  Scenario: Bet Placement must always be in JSON
    Given I have oddsfeed API Key
    When I send a POST request to "/v1/bet/placement" with the following:
      | sample | data |
    Then the response status should be "415"
    And the JSON response should have "$.status" with the text "415"
    And the JSON response should have "$.title" with the text "Unsupported Media Type"

  Scenario: Bet Placement - missing ClientId header
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 127.0.0.1 |
    When I send and accept JSON
    When I send a POST request to "/v1/bet/placement" with the following:
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
    And the JSON response should have "$.statusCode" with the text "102"
    And the JSON response should have "$.message" with the text "Missing Or Unsupported ClientId In Request Headers"

  Scenario: Bet Placement - Valid but not offered
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 127.0.0.1 |
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a POST request to "/v1/bet/placement" with the following:
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
    And the JSON response should have "$.statusCode" with the text "125"
    And the JSON response should have "$.message" with the text "Market Is Not Offered"

  # bet is  missing
  Scenario: Bet Cancellation
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 127.0.0.1 |
      | X-Client-Id  | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a POST request to "/v1/bet/cancel" with the following:
    """
    {
      "BetId": "0e0a5a17-64c0-48f9-a33e-f49a737932d2",
      "Reason": "For testing only"
    }
    """
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "1000"
    And the JSON response should have "$.message" with the text "Error"

  Scenario: Odds Recovery
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 127.0.0.1 |
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a POST request to "/v1/odds/recovery" with the following:
    """
    {
      "SportId": -1,
      "FixtureSpecifier": "bg:match:12345"
    }
    """
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "139"
    And the JSON response should have "$.message" with the text "No Record Found"

  Scenario: Settlement Recovery
    Given I have oddsfeed API Key
    When I set headers:
      | x-ip-address | 127.0.0.1 |
      | X-Client-Id | F5251362-64F1-4BF4-28E9-08D8EE99CA8E |
    When I send and accept JSON
    When I send a POST request to "/v1/settlement/recovery" with the following:
    """
    {
      "SportId": -1,
      "FixtureSpecifier": "bg:match:12345"
    }
    """
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "139"
    And the JSON response should have "$.message" with the text "No Record Found"
