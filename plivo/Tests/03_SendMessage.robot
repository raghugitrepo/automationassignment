*** Settings ***
Library  Collections
Resource  ../Keywords/Common.robot
Resource  ../Keywords/Search.robot
Variables  ../TestData/SearchData.py
Test Setup  Create plivo session

*** Test Cases ***
Send message
    ${credits}   Get Account credits
    set suite variable  ${credits_before}  ${credits}
    ${send_message_resp}  Make post request to send message   ${MESSAGE_PAYLOAD}
    log  ${send_message_resp.content}
    should be equal as integers  ${send_message_resp.status_code}  202
    ${response}  json load  ${send_message_resp.content}
    should be equal  ${response['message']}  ${MESSAGE_QUEUED}
    set suite variable  @{message_id}  ${response['message_uuid']}

Get message details
    ${get_message_details}  Make get request to fetch message details  @{message_id[0]}
    log  ${get_message_details.content}
    should be equal as integers  ${get_message_details.status_code}  200
    ${response}  json load  ${get_message_details.content}
    should be equal  @{message_id[0]}  ${response['message_uuid']}
    set suite variable  ${message_rate_in_resp}  ${response['total_rate']}

Get pricing
    ${get_price_details}  Make get request to pricing details  ${PRICE_QUERY_DICT}
    log  ${get_price_details.content}
    should be equal as integers  ${get_price_details.status_code}  200
    ${response}  json load  ${get_price_details.content}
    set suite variable   ${outbound_message_price}  ${response['message']['outbound']['rate']}
    should be equal  ${outbound_message_price}  ${message_rate_in_resp}  msg=message rate and price are not equally

Verify deducted amt equals to message rate
     # Given a sleep 0f 1 min to reflect the credit change in account api.
     sleep  60
     ${credits_A}  Get Account credits
     set suite variable  ${credits_After}  ${credits_A}
     ${actual_rate}  evaluate  ${credits_before} - ${credits_After}
     should be equal as numbers  ${actual_rate}  ${outbound_message_price}

*** Keywords ***
Get Account credits
    ${acct_details_resp}  Make get request to get acct details
    log  ${acct_details_resp.content}
    should be equal as integers  ${acct_details_resp.status_code}  200
    ${response}  json load  ${acct_details_resp.content}
    [Return]  ${response['cash_credits']}

