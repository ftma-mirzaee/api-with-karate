Feature: CSR Account plan section

  Background:
    Given url BASE_URL

  @Accounts_1
  Scenario: get accounts without authorization
    And path "/api/accounts/get-all-accounts"
    When method get
    Then status 401

    @Accounts_2
    Scenario: get Accounts with Authorization
      And path "/api/token"
      And request
      """
       {
      "username" : "supervisor",
      "password" : "tek_supervisor"
    }

      """
      When method post
      Then status 200
      And print response
      * def validToken = response.token
      Given path "/api/accounts/get-all-accounts"
      And header Authorization = "Bearer " + validToken
      When method get
      Then status 200
      And print response

  @Accounts_3
  Scenario: Get single account with params
    * def result = callonce read('GenerateValidToken.feature')
    * def validToken = "Bearer " + result.response.token
    Given path "/api/accounts/get-account"
    * def accountId = 6023
    And header Authorization = validToken
    And param primaryPersonId = accountId
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == accountId

  @Account_4
  Scenario: Get Account with non-existing id
    #        Generate token with calling another feature.
    * def result = callonce read('GenerateValidToken.feature')
    And print result
    * def validToken = result.response.token
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = 61277777
    When method get
    Then status 404
    And print response
    And assert response.httpStatus == "NOT_FOUND"