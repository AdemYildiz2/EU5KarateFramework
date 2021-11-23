# we can use a feature file as utilities class or like a method in a java
# we'll create a Auth token here and use this feature file inside the another feature file
# so that we can use this token for scenarios in the other features

Feature: get user token

  Scenario: get one user token
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = 'sbirdbj@fc2.com'
    And param password = 'asenorval'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken
    And def name = 'Stevan'