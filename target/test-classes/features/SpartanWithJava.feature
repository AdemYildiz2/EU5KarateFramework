Feature:

  Background:
    * def spartanUrl = 'http://54.237.100.89:8000'

  Scenario: Create a spartan with request header
    Given url spartanUrl
    And path 'api/spartans'
    And header Accept = 'Application/json'
    When method get
    Then status 200

#Posting data as Json wi use request key word
# 1- statically adding data with 'request'
  Scenario: Create a new spartan
    Given url spartanUrl
    And path 'api/spartans'
    And header Accept = 'Application/json'
    And header Content-Type = 'Application/json'
    And request
  """
    {
      "gender": "Female",
      "name": "Lorenza",
      "phone": 2345678234
    }
    """
    When method post
    Then status 201
    And print response
# 2- dynamically adding data from utilities by using faker object
  Scenario: reading java methods
     #point the class that we want to run
     #Java.type --> used to connect to java class
    * def SDG = Java.type('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
     #run the static method in that class and capture the result
     #the return map object is represented as a json
    * print newSpartan

  Scenario: Create a spartan with Random Data (JAVA) and delete
    * def SDG = Java.type('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    Given url spartanUrl
    And path 'api/spartans'
    And header Accept = 'Application/json'
    And header Content-Type = 'Application/json'
    And request newSpartan
    When method post
    Then status 201
    And print response
    And match response.success =='A Spartan is Born!'
#    verify names
    And match response.data.name == newSpartan.name
#    delete the spartan we created randomly
    And def idToDelete = response.data.id
    Given url spartanUrl
    And path 'api/spartans',idToDelete
    When method DELETE
    Then status 204
