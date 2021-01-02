@3p_Revision
Feature: 3p_Revision

  Background:
    * configure headers = {Cookie : null}
    * def setup = callonce read('classpath:resources/features/Thirdparty_revision_token.feature')
    * def accessToken = setup.accessToken
    * def basePath = "https://revision-historystaging.exiger.com/api/v1/"
    * header Authorization = 'Bearer ' + accessToken

  Scenario: Edited 3p details would be visible through an API
    Given url "https://revision-historystaging.exiger.com/api/v1/saverevision"
    And request read('classpath:testdata/revision_request.json')
    And header Content-Type = 'application/json'
    And retry until responseStatus == 200
    And method post
    Then status 200
    And print response
    * match response.RevisionId == '#number'
    * match response.ReferenceId == 200616

  Scenario: Get Full Revision Details
    Given url "https://revision-historystaging.exiger.com/api/v1/getrevisionjson?RevisionId=14"
    And header Content-Type = 'application/json'
    And method get
    Then status 200
    * string strVar = response
    * print strVar
    * replace strVar
      | token | value |
      | "     | ' '   |
      | '     | '"'   |
    * print strVar," new string"
    * json jsonVar = strVar
    * print jsonVar
    * print jsonVar.FirstName
    * match jsonVar.FirstName == '#string'
    * match jsonVar.LastName == '#string'
    * match jsonVar.Email == '#string'
    * match jsonVar contains { "FirstName" : "#regex [A-Z][a-z]+", "LastName" : "#regex [A-Z][a-z]+", "Email" : "#regex \\b[\\w.%-]+@[-.\\w]+\\.[A-Za-z]{2,4}\\b+" }


