Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  @GetAllUsers
  Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200

  @CreateUser
  Scenario: create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

  # path will be url+ what parameter we will pass
  # In following example url is https://jsonplaceholder.typicode.com/users and parameter is 10
  Scenario: User should get a specific user information based on provided id
    Given url 'https://jsonplaceholder.typicode.com/users'
    And path 10
    When method get
    Then status 200
    And match response contains {"name": "Clementina DuBuque"}

  @PutRequest
  Scenario: User can update data using PUT request
    Given url 'https://jsonplaceholder.typicode.com/posts'
    * def user  =
    """
    {
      id: 1,
      title: 'updating Resource using PUT',
    }
    """
    Given path 1
    And request user
    When method PUT
    Then status 200
    And print response
    And match response contains {"id": 1, "title": "updating Resource using PUT"}

  @PatchRequest
  Scenario: User can update data using PATCH request
    Given url 'https://jsonplaceholder.typicode.com/posts'
    * def user  =
      """
      {
        id: 1,
        title: 'updating Resource using patch',
      }
      """
    Given path 1
    And request user
    When method PATCH
    Then status 200
    And print response
    And match response contains {"id": 1, "title": "updating Resource using patch"}

  @DeleteRequest
  Scenario: User can delete data using Delete request
    Given url 'https://jsonplaceholder.typicode.com/posts'
    Given path 1
    When method DELETE
    Then status 200

