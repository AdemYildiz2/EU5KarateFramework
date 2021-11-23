Feature: Data driven tests

#  based on pipes, it is the same as cucumber while we have small kind of excel
  Scenario Outline: get token for user <email>
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = '<email>'
    And param password = '<password>'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken

    Examples:
      | email                       | password           |
      | sbirdbj@fc2.com             | asenorval          |
      | htwinbrowb4@blogspot.com    | kanyabang          |
      | dfrederickb5@yellowbook.com | engraciahuc        |
      | apainb6@google.co.jp        | rosettalightollers |
      | fbawmeb7@studiopress.com    | sherilyngohn       |

 #  BUT based on CSV it has huge advantage in Karate frame work/ It does not happen in cucumber
  Scenario Outline: get token for user <email>
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = '<email>'
    And param password = '<password>'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken

    Examples:
  | read('data/users.csv') |
  # it reads csv file from the data package and execute one by one

  Scenario: get user information verification(Database vs API)
#Let's get user information from DATABASE
    * def DBUtils = Java.type('utilities.DBUtils')
    * def query = "select id,firstname,lastname, role from users where email='sbirdbj@fc2.com'"
    * def dbResult = DBUtils.getRowMap(query)
    * print 'FROM DB', dbResult

#Let's get user information from API
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = 'sbirdbj@fc2.com'
    And param password = 'asenorval'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'api/users/me'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response

#  Verify
#  match dbResult == response does not work because key names different eg: firstname(in DB), firstName(API)
#  SO we have to do one by one
    Then match response.id ==dbResult.id
    Then match response.firstName ==dbResult.firstname
    Then match response.lastName ==dbResult.lastname
    Then match response.role ==dbResult.role

#  @ignore --> we just tried to run parallel with this tag
#  Let's create one DDT with CSV and DB integrated
  @wip @ignore
  Scenario Outline: get user information verification(Database vs API) <email>
# Let's get user information from DATABASE
#  changing email dynamically for db
    * def DBUtils = Java.type('utilities.DBUtils')
    * def query = "select id,firstname,lastname, role from users where email='<email>'"
    * def dbResult = DBUtils.getRowMap(query)
    * print 'FROM DB', dbResult
# Let's get user information from API
# changing email and password dynamically for api
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'sign'
    And header Accept = 'application/json'
    And param email = '<email>'
    And param password = '<password>'
    When method GET
    Then status 200
    And print response.accessToken
    And def token = response.accessToken
    Given url 'https://cybertek-reservation-api-qa2.herokuapp.com/'
    And path 'api/users/me'
    And header Authorization = 'Bearer ' + token
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response
# verify
    Then match response.id ==dbResult.id
    Then match response.firstName ==dbResult.firstname
    Then match response.lastName ==dbResult.lastname
    Then match response.role ==dbResult.role

   Examples:
  | read('data/users.csv') |