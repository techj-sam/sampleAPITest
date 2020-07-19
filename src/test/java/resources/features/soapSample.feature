Feature:  soap Requests
   Background:
    * url "http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso?WSDL"

  Scenario: User should be able to get capital of the country
    Given request
    """
    <Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
    <CapitalCity xmlns="http://www.oorsprong.org/websamples.countryinfo">
    <sCountryISOCode>IN</sCountryISOCode>
    </CapitalCity>
    </Body>
    </Envelope>
    """
    And soap action 'CapitalCity'
    And status 200
    And print response
    And match response contains '<m:CapitalCityResult>New Delhi</m:CapitalCityResult>'
    And match responseHeaders['Content-Type'][*] contains 'text/xml; charset=utf-8'
    And assert responseTime < 3000






