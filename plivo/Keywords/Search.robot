*** Settings ***
Library  RequestsLibrary
Library  ../Lib/testlib.py
Resource  Common.robot
Variables  ../TestData/SearchData.py

*** Variables ***
${SEARCH_ENDPOINT}  PhoneNumber
${MESSAGE_ENDPOINT}  Message
${PRICING_ENDPOINT}  Pricing

*** Keywords ***
Make get request for search endpoint
    [Arguments]  ${url_params}
    ${headers}  Create Dictionary   Content-Type=application/json  Accept=application/json
    ${query_string}  url encode  ${url_params}
    ${get_request_search_resp}  get request  plivo  ${API_VERSION}${SEARCH_ENDPOINT}?${query_string}  headers=${headers}
    [Return]  ${get_request_search_resp}

Get two sample number
    [Arguments]  ${response}
    set global variable   ${FIRST_NUMBER}   ${response['objects'][0]['number']}
    set global variable   ${SECOND_NUMBER}  ${response['objects'][1]['number']}


Make post request to buy numbers
    [Arguments]  ${number}
    ${headers}  Create Dictionary   Content-Type=application/json  Accept=application/json
    ${post_request_resp}  post request  plivo   ${API_VERSION}${SEARCH_ENDPOINT}/${number}/  headers=${headers}
    [Return]  ${post_request_resp}

Make post request to send message
    [Arguments]  ${payload}
    ${headers}  create dictionary  Content-Type=application/json  Accept=application/json
    ${post_request_resp}  post request  plivo  ${API_VERSION}${MESSAGE_ENDPOINT}/  data=${payload}  headers=${headers}
    [Return]  ${post_request_resp}

Make get request to fetch message details
    [Arguments]  ${message_id}
    ${headers}  create dictionary  Content-Type=application/json  Accept=application/json
    ${get_request_resp}  get request  plivo  ${API_VERSION}${MESSAGE_ENDPOINT}/${message_id}/  headers=${headers}
    [Return]  ${get_request_resp}

Make get request to pricing details
    [Arguments]  ${url_params}
    ${headers}  create dictionary  Content-Type=application/json  Accept=application/json
    ${query_string}  url encode  ${url_params}
    ${get_request_resp}  get request  plivo  ${API_VERSION}${PRICING_ENDPOINT}?${query_string}  headers=${headers}
    [Return]  ${get_request_resp}

Make get request to get acct details
    ${headers}  create dictionary  Content-Type=application/json  Accept=application/json
    ${get_request_resp}  get request  plivo  ${API_VERSION}  headers=${headers}
    [Return]  ${get_request_resp}



