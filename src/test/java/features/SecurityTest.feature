@Security
Feature: Insurance APP Security Test
  #    url Step to assign BASE URL for API
  #    Path is to specify with Endpoint
  #    Request step for adding request body
  #    method step to send request for method type. post, get, put , delete
  #    status assert response status code

  Background: given data
    Given url BASE_URL
    And path "/api/token"

  Scenario Outline: Happy Path Token Generation
    And request
    """
  {"username": "<username>",
  "password": "<password>"}

    """
    When method post
    Then status <statusCode>
    And print response

    Examples:
      | username          | password       | statusCode |
      | supervisor        | tek_supervisor | 200        |
      | operator_readonly | Tek4u2024      | 200        |


    @WrongCredentials
    Scenario Outline: sending data with invalid credentials
      And request
      """
  {"username": "<username>",
  "password": "<password>"}

    """
      When method post
      Then status <statusCode>
      And print response
      Then assert response.errorMessage == "<errorMessage>"
      Then assert response.httpStatus == "<httpStatus>"

      Examples:
        | username     | password       | statusCode | httpStatus  | errorMessage                |
        | supervisor23 | tek_supervisor | 404     | NOT_FOUND   | User supervisor23 not found |
        | supervisor   | wrongPassword  | 400     | BAD_REQUEST | Password not matched        |
        | wrongUser    | wrongPassword  | 404     | NOT_FOUND   | User wrongUser not found    |