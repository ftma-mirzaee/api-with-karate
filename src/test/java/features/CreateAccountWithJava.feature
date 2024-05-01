Feature: Create Account with Java Data Generator

  @CreateAccount
  Scenario: Create An Account with Random Email address
    Given url BASE_URL
    And path "/api/accounts/add-primary-account"
    * def dataGenerator = Java.type('data.DataGenerator')
    * def randomEmail = dataGenerator.getEmail()
    And request
      """
      {
        "email": "#(randomEmail)",
        "firstName": "Mohammad",
        "lastName": "Shokriyan",
        "title": "Mr.",
        "gender": "MALE",
        "maritalStatus": "SINGLE",
        "employmentStatus": "Software developer",
        "dateOfBirth": "1985-02-16"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == randomEmail