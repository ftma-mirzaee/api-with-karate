@Smoke
Feature: create new account
  @CreateAccount
  Scenario: create account
    Given url BASE_URL
    And path "/api/accounts/add-primary-account"
    And request
    """
    {
  "id": 0,
  "email": "std.17@gmail.com",
  "firstName": "melany",
  "lastName": "ruiz",
  "title": "Mrs",
  "gender": "FEMALE",
  "maritalStatus": "SINGLE",
  "employmentStatus": "student",
  "dateOfBirth": "2014-04-24T23:26:32.713Z",
  "new": true
}
    """
    When method post
    Then status 201
    And print response
    And assert response.email == "std.17@gmail.com"
    * def accountId = response.id
    * def result = callonce read('GenerateValidToken.feature')
    * def token = "Bearer " + result.response.token
    Given path "/api/accounts/delete-account"
    And header Authorization = token
    And param primaryPersonId = accountId
    When method delete
    Then status 200
