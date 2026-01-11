@external
@platformapi
@sportsbook
@authenticated
Feature: Platform Integration API - Sportsbook (Authenticated)
  As a returning / authenticated user
  I want to make sure all the endpoints are working

  #todo: add fixture id to test
  @requires_operator_token
  Scenario: Livestream
    When I send a GET request to "/v1/sportsbook/livestream" with the following:
    #Examples
      | providerFixtureId | bg:match:12345 |
      | ipAddress         | 1.2.3.4        |
      | isMobile          | true           |
    Then the response status should be "400"

  @requires_operator_token
  Scenario: Top Leagues (All)
    When I send a GET request to "/v1/sportsbook/sports/topleagues" with the following:
    #Examples
      | sportId            | 0   |
      | fixtureStatusGroup | 0   |
      | minuteUTCOffset    | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Top Leagues (Prematch)
    When I send a GET request to "/v1/sportsbook/sports/topleagues" with the following:
    #Examples
      | sportId            | 0   |
      | fixtureStatusGroup | 1   |
      | minuteUTCOffset    | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Top Leagues (Live)
    When I send a GET request to "/v1/sportsbook/sports/topleagues" with the following:
    #Examples
      | sportId            | 0   |
      | fixtureStatusGroup | 2   |
      | minuteUTCOffset    | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: All Leagues
    When I send a GET request to "/v1/sportsbook/sports/allleagues" with the following:
    #Examples
      | sportId            | 0   |
      | fixtureStatusGroup | 0   |
      | minuteUTCOffset    | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Top Fixtures FixtureId
    When I send a GET request to "/v2/sportsbook/topfixtures/fixtureId"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Market Template Groups
    When I send a GET request to "/v1/sportsbook/markettemplategroups"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Selector Market Template
    When I send a GET request to "/v1/sportsbook/selectormarkettemplates"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Market Sort Order
    When I send a GET request to "/v1/sportsbook/marketsortorder"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Fixture Sort Order
    When I send a GET request to "/v1/sportsbook/fixturesortorder"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: User Favorites
    When I send a GET request to "/v1/sportsbook/userfavorites/fixtures"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Top Fixtures
    When I send a GET request to "/v2/sportsbook/topfixtures"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Active Fixtures - Live
    When I send a GET request to "/v1/sportsbook/activefixtures" with the following:
      | fixtureStatus   | live |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Active Fixtures - Prematch
    When I send a GET request to "/v1/sportsbook/activefixtures" with the following:
    #Examples
      | fixtureStatus   | prematch |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  @known
  @todo
  Scenario: Active Fixtures Details
    When I send a GET request to "/v1/sportsbook/activefixtures/details" with the following:
    #Examples
      | fixtureId | 1437404267307610112 |
    Then the response status should be "200"

  @requires_operator_token
  Scenario: Live Fixture Count
    When I send a GET request to "/v1/sportsbook/livefixturecount" with the following:
    #Examples
      | sportGroupId | 0 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Today Fixture Count
    When I send a GET request to "/v1/sportsbook/todayfixturecount" with the following:
    #Examples
      | sportGroupId | 0 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Sports
    When I send a GET request to "/v1/sportsbook/sports" with the following:
    #Examples
      | sportGroup      | 0   |
      | minuteUTCOffset | 480 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Sports - (No Fixture Scope / Today )
    When I send a GET request to "/v1/sportsbook/sports" with the following:
    #Examples
      | sportGroup      | 1 |
      | minuteUTCOffset | 0 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Sports - (Early)
    When I send a GET request to "/v1/sportsbook/sports" with the following:
    #Examples
      | sportGroup      | 1 |
      | fixtureScope    | -1 |
      | minuteUTCOffset | 0 |
    Then show me the response
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Live Fixtures (Football)
    Given I have platform API Key
    When I send a GET request to "/v1/sportsbook/sports/livefixtures" with the following:
    #Examples
      | sportId | 10 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Live Fixtures (Baseball)
    When I send a GET request to "/v1/sportsbook/sports/livefixtures" with the following:
    #Examples
      | sportId | 8 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Live Fixtures (Basketball)
    When I send a GET request to "/v1/sportsbook/sports/livefixtures" with the following:
    #Examples
      | sportId | 4 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Segment Fixtures
    When I send a GET request to "/v1/sportsbook/sports/segments/fixtures" with the following:
    #Examples
      | sportId   | 4   |
      | segmentId | 140 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Live Fixtures
    When I send a GET request to "/v1/sportsbook/sports/segments/leagues/livefixtures" with the following:
    #Examples
      | sportId   | 1 |
      | segmentId | 0 |
      | leageId   | 0 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Today Fixtures
    When I send a GET request to "/v1/sportsbook/sports/todayfixtures" with the following:
    #Examples
      | sportId         | 1   |
      | minuteUTCOffset | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Get Today Fixtures By League
    When I send a GET request to "/v1/sportsbook/sports/segments/leagues/todayfixtures" with the following:
    #Examples
      | sportId         | 1   |
      | segmentId       | 0   |
      | minuteUTCOffset | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Upcoming Fixtures
    When I send a GET request to "/v1/sportsbook/sports/upcomingfixtures" with the following:
    #Examples
      | sportId         | 1   |
      | minuteUTCOffset | 300 |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Upcoming Fixtures By League
    When I send a GET request to "/v1/sportsbook/sports/segments/leagues/upcomingfixtures" with the following:
    #Examples
      | sportId         | 1   |
      | minuteUTCOffset | 300 |
      | leagueId        | 0   |
      | segmentId       | 0   |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Daily Fixtures
    When I send a GET request to "/v1/sportsbook/sports/dailyfixtures" with the following:
    #Examples
      | sportId         | 1          |
      | dateUTC         | 2025-12-04 |
      | minuteUTCOffset | 300        |
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  # Most endpoints are True Wave Endpoints :P
  @requires_operator_token
  Scenario: Announcements
    When I send a GET request to "/v1/sportsbook/announcements"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: CCF
    When I send a GET request to "/v1/sportsbook/ccf" with the following:
    #Examples:
      | userId | 3546c6d2-a83b-47c5-8a37-c1e2111543b5 |
    Then the response status should be "200"

  @requires_operator_token
  Scenario: Boosted Odds
    When I send a GET request to "/v1/sportsbook/boostedfixtures"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  @requires_operator_token
  Scenario: Translations
    When I send a GET request to "/v1/sportsbook/translations"
    Then the response status should be "200"
    And the JSON response should have "$.statusCode" with the text "100"
    And the JSON response should have "$.message" with the text "Success"

  # sb bet recommendation
  @requires_operator_token
  Scenario: Bet Recommendations Unsupported Currency
    When I send a GET request to "/v1/sportsbook/betrecommendations" with the following:
    #Examples:
      | currencyCode | NA |
    Then the response status should be "400"
    And the JSON response should have "$.statusCode" with the text "105"
    And the JSON response should have "$.message" with the text "Unsupported CurrencyCode"

  @requires_operator_token
  @failing
  @current
  @known
  Scenario: Bet Recommendations
    When I send a GET request to "/v1/sportsbook/betrecommendations" with the following:
      | currencyCode | EUR |
    #Then show me the response
    Then the response status should be "200"
