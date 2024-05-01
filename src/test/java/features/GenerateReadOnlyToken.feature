Feature: Generate read only Token

  Scenario: Valid token
    Given url BASE_URL
    Given path "/api/token"
    And request
      """
      {
        "username": "operator_readonly",
        "password": "Tek4u2024"
      }
      """
    When method post
    Then status 200
    And print response