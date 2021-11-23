Feature:

  Scenario: how to print 
    Given print "Hello World"
    When print 'another print'
    Then print 'then print'
#' ' or " " --> can be used  for string
#  *        -->can be used for given, when and then
#  ,     --> can be used for concatenation it has already has space with it

  Scenario: more printing
    Given print 'some words to print'
    * print my name is','karate kid'
    * print 2+2

  Scenario: variables
    * def name = 'Mike'
    * print 'my name is', name
    * def age = 20
    * print name, 'is', age, 'years old'

  Scenario: difficult parameters: json object
    * def student = {'name':'sam','owes_tuition':false}
    * print student
    * print student.name
    * print student.owes_tuition

  Scenario: json object 2
    * def student =
    """{
        "firstName":"Steven",
        "lastName":"King",
        "salary":"2099"
    }
    """
    * print student.firstName
    * print student.lastName
    * print student.salary

  Scenario: Spartan Variable
    * def spartan =
    """
    {
       "id": 205,
        "name": "Meta",
        "gender": "Female",
        "phone": 1938695106
    }
    """
    * print spartan.name
    * print spartan.gender
    * print spartan.id
    * print spartan.phone


  Scenario: json array object
    * def students =
    """
    [
      {
        'name':'sam',
        'owes_tuition':false
      },
      {
        'name':'mike',
        'owes_tuition':true
      }
    ]
    """
    * print students
    * print students[0].name
    * print students[1].owes_tuition
