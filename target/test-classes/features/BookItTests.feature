Feature: Bookit Api tests

  Background:
    * def baseUrl = 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    # point another file
    * def AuthFeature = call read('classpath:features/BookItAuth.feature')
    * def accessToken = AuthFeature.token
    * def firstname = AuthFeature.name
    * print firstname
    * print 'Taken from Background',accessToken
# we can get firstname and accessToken in this way from BookItAuth.feature file
# 'Taken from Background' is just comment to explain

    Scenario: get user information
      Given url baseUrl
      And path 'api/users/me'
      And header Authorization = 'Bearer ' + accessToken
      And header Accept = 'application/json'
      When method get
      Then status 200
      And print response
      And match response =={"id":57,"firstName":"Ase","lastName":"Norval","role":"student-team-leader"}


  Scenario: get campus information
    Given url baseUrl
    And path 'api/campuses'
    And header Authorization = 'Bearer ' + accessToken
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And print response
#verify whole json/campus info
#to verify this we created a data package under java and a file/campuses.json under the package then we put whole json body in it.
# then finally, read the campuses.json file in the data directory
#  expected json comes from the file --actual json comes from api
    And def expectedCampuses = read('classpath:data/campuses.json')
    And match response ==expectedCampuses
