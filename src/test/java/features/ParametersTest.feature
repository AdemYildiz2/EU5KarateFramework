Feature: Parameters examples

  Background:
    * def baseUrl = 'https://api.exchangeratesapi.io'
    * def spartanUrl = 'http://54.237.100.89:8000'
    * def hrUrl = 'http://54.237.100.89:1000/ords/hr'

  Scenario: path parameters
    Given url baseUrl
    And path "latest"
    When method get
    Then status 200

  Scenario: path parameters
    Given url baseUrl
    And path "2010-01-12"
    When method get
    Then status 200

  Scenario: get all spartans with path
    Given url spartanUrl
    And path 'api/spartans'
    When method get
    Then status 200
    And print response

#way 1- verify json
  Scenario: get one spartan only
    Given url spartanUrl
    And path 'api/spartans'
    And path '2002'
    When method get
    Then status 200
    And print response
    Then match response =={"gender": "Male","phone": 9362576592,"name": "Antonio","id": 2002}

#way 2- verify json
  Scenario: get one spartan only
    * def expectedSpartan =
    """
     {
      "gender": "Male",
      "phone": 9362576592,
      "name": "Antonio",
      "id": 2002
      }
    """
    Given url spartanUrl
    And path 'api/spartans'
    And path '2002'
    When method get
    Then status 200
    And print response
    Then match response == expectedSpartan

  Scenario: query parameters
    Given url spartanUrl
    And path 'api/spartans/search'
    And param nameContains = 'j'
    And param gender = 'Female'
    When method Get
    Then status 200
    And match header Content-Type == 'application/json'
    And print response
#    verify each content has gender = Female
#    way 1- iteration
    And match each response.content contains {"gender":"Female"}
#    way 2- iteration
    And match each response.content[*].gender == 'Female'
    And match response.content[0].name == 'Jamal'
#    verify each content phone is number
    And match each response.content contains {"phone":'#number'}
    And match each response.content[*]phone == '#number'

  Scenario: hr regions example
    Given url hrUrl
    And path 'regions'
    When method get
    Then status 200
    And print response
    And match response.limit == 25
    And match each response.items[*].region_id == '#number'






