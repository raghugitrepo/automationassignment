*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Variables  ../config.py

*** Variables ***
${BASE_URL}  ${URL}
${API_VERSION}  /v1/Account/${AUTH_ID}/

*** Keywords ***
Create plivo session
    ${auth_list}  create list  ${AUTH_ID}  ${AUTH_TOKEN}
    create session  plivo  https://${BASE_URL}  auth=${auth_list}  verify=False

