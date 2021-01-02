Feature: sample karate session scenario
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
   #*  url "http://dummy.restapiexample.com"
    * url baseURL
    * def createEmployeeTemplate = read('classpath:testData/employee_info.json')


  Scenario: User should be able to get list of employees
    Given path "api/v1/employees"
    And method GET
    And status 200
    And print response

  Scenario Outline: User should be able to get details of specific employee
    Given path "api/v1/employee/"+"<employeeID>"
    And method GET
    And status 200
    And print response
    And match $ contains { data: '#notnull'}
    * def myFilterSchema = read('classpath:testData/employee_schema.json')
    And match response == myFilterSchema

    Examples:
      | employeeID |
      | 3          |
#      | 4          |
#      | 26789      |

  Scenario:  User should be able to create a new employee
    Given path "api/v1/create"
    And request {"name":"testSession","salary":"25000","age":"45"}
    And method POST
    And status 200
    And print response.data.id
    And path "api/v1/employee/"+response.data.id
    And method GET
    And status 200
    And print response

  Scenario: User should be able to create a new employee with the help of data from external file
    Given path "api/v1/create"
    And request read ('classpath:testData/employee_info.json')
    And method POST
    And status 200
     # And print response
    And print response.data.id
    And path "api/v1/employee/"+response.data.id
    And method GET
    And status 200
    And print response

  Scenario: User should be able to create a new employee with data from employee template
    Given path "api/v1/create"
    And set createEmployeeTemplate.name = 'Demouser'
    And request createEmployeeTemplate
    And method POST
    And status 200
#      And print response
    And print response.data.id
    And path "api/v1/employee/"+response.data.id
    And method GET
    And status 200
    And print response
