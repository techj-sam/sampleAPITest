Feature: Gets third party revision Auth token

  @ignore
  Scenario: Third party revision Auth token
    * configure headers = {Cookie : null}
    Given url 'https://insightauthstaging.exiger.com/oauth2/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'
    * form field grant_type = 'password'
    * form field username = 'rhs_qa_api_user'
    * form field password = 'Password123!'
      And retry until responseStatus == 200
    * method post
    * status 200
    * def accessToken = response.access_token