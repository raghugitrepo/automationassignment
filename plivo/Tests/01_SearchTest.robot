*** Settings ***
Library  Collections
Resource  ../Keywords/Common.robot
Resource  ../Keywords/Search.robot
Variables  ../TestData/SearchData.py
Test Setup  Create plivo session

*** Test Cases ***
Search phone numbers by pattern
    ${get_request_search_resp}  Make get request for search endpoint  ${SEARCH_QUERY_DICT}
    should be equal as integers  ${get_request_search_resp.status_code}  200
    ${response}  json load  ${get_request_search_resp.content}
    run keyword if  ${response['meta']['total_count']} > 2  Get two sample number  ${response}
    ...  ELSE  run keyword  fail  msg=Two phone numbers not found.