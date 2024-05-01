@AddingCarAndPhone
Feature: Adding Car to Account

  #1) Using /api/accounts/add-primary-account
  #Create an Account.

  #Then using /api/accounts/add-account-car
  #Add a car to Created Account

  #Then using /api/accounts/add-account-phone
  #Add a phone to Created Account.

  Background: Setup test with creating account
    Given url BASE_URL
    * def createAccountResult = callonce read('CreateAccountWithJava.feature')
    * def createdAccountId = createAccountResult.response.id

    Scenario:Adding car to Account
      * def tokenResult = callonce read('GenerateValidToken.feature')
      * def token = "Bearer " + tokenResult.response.token
      Given path "/api/accounts/add-account-car"
      And param primaryPersonId = createdAccountId
      And header Authorization = token
      When request
      """
      {
  "make": "TOYOTA",
  "model": "CAMERY",
  "year": "2020",
  "licensePlate": "YA-2312"
}
      """
      When method post
      Then status 201
      Then print response

      Scenario: Adding Phone Number
        * def tokenResult = callonce read('GenerateValidToken.feature')
        * def token = "Bearer " + tokenResult.response.token
        Given path "/api/accounts/add-account-phone"
        And param primaryPersonId = createdAccountId
        And header Authorization = token
        When request
        """
        {
  "phoneNumber": "2346789456",
  "phoneExtension": "+1",
  "phoneTime": "Morning",
  "phoneType": "Mobile"
}
        """
        When method post
        Then status 201
        Then print response