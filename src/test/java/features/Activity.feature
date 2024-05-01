@Regression @Activity
Feature: recap of previous APL methods

  Background: Setup test
    Given url BASE_URL

    Scenario: retrieve created account info
      And path "/api/accounts/add-primary-account"
      * def dataGenerator = Java.type('data.DataGenerator')
      * def randomEmail = dataGenerator.getEmail()
      And request
    """
    {
  "id": 0,
  "email": "#(randomEmail)",
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
      And assert response.email == randomEmail
      And assert response.firstName == "melany"
      * def accountId = response.id
      * def result = callonce read('GenerateValidToken.feature')
      * def token = "Bearer " + result.response.token
      Given path "/api/accounts/delete-account"
      And header Authorization = token
      And param primaryPersonId = accountId
      When method delete
      Then status 200
      And print response

      When method delete
      Then status 404
      And print response
      And assert response.status == "404"
      And assert response.error == "Not Found"



  #[6:08 PM] Mohammad Shokriyan
  #Activity
  #1) Using /api/accounts/add-primary-account
  #Create an Account.

  #2) Using /api/accounts/get-account retrieve created account info
  #And assert email, First Name and Gender

  #3) Using /api/accounts/delete-account
  #Delete create account

  #4) Using /api/account/delete-account make second attempt
  #And assert status code 404
  #And assert errorMessage "Account with id <AccountID> not exist"