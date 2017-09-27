*** Settings ***
Library  Collections
Resource  ../Keywords/Common.robot
Resource  ../Keywords/Search.robot
Variables  ../TestData/SearchData.py
Test Setup  Create plivo session
Test Template  Buy phone number

*** Test Cases ***
Buy first phone number   ${FIRST_NUMBER}
    [Tags]  plivo  p0

Buy second phone number  ${SECOND_NUMBER}
    [Tags]  plivo  p1



*** Keywords ***
Buy phone number
    [Arguments]  ${number}
    ${post_request_resp}  Make post request to buy numbers  ${number}
    log  ${post_request_resp.content}
    should be equal as integers  ${post_request_resp.status_code}  201
    ${response}  json load  ${post_request_resp.content}
    ${status}  run keyword and return status  should be equal  ${response['numbers'][0]['status']}  Success
    run keyword unless  ${status}  fail  msg=Can't buy a phone number

