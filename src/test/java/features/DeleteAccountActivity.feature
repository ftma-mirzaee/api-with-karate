@Regression
Feature: End 2 End Account with Create to Delete

#  Activity
#  1) Using /api/accounts/add-primary-account
#  Create an Account.
#  2) Using /api/accounts/get-account retrieve created account info
#  And assert email, First Name and Gender
#  3) Using /api/accounts/delete-account
#  Delete create account
#  4) Using /api/account/delete-account make second attempt
#  And assert status code 404
#  And assert errorMessage "Account with id <AccountID> not exist"

  @CreateDelete
  Scenario: Create, Retrieve and Delete Account
    Given url BASE_URL
    * def createResult = callonce read('CreateAccountWithJava.feature')
    * def accountId = createResult.response.id
    * def accountEmail = createResult.response.email
    * def tokenResult = callonce read('GenerateValidToken.feature')
    * def validToken = "Bearer " + tokenResult.response.token
    Given path "/api/accounts/get-account"
    And header Authorization = validToken
    And param primaryPersonId = accountId
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.email == accountEmail
    And assert response.primaryPerson.firstName == "Mohammad"
    And assert response.primaryPerson.gender == "MALE"
    Given path "/api/accounts/delete-account"
    And header Authorization = validToken
    And param primaryPersonId = accountId
    When method delete
    Then status 200
    Given path "/api/accounts/delete-account"
    And header Authorization = validToken
    And param primaryPersonId = accountId
    When method delete
    Then status 404
    And assert response.errorMessage == "Account with id " + accountId + " not exist"