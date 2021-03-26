*** Settings ***
Library    SeleniumLibrary

Resource    ../Resources/AdminPage.robot

Documentation    Тесты для страницы администратора

Test Setup    Open Browser    browser=${BROWSER}     options=add_argument("--ignore-certificate-errors")
Test Teardown    Close Browser


*** Variables ***
${BROWSER}    chrome
${BASE_URL}  localhost


*** Test Cases ***
Check Login
    Go To  http://${BASE_URL}/admin/
    Admin Page open and login    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard

Change product
    Go To  http://${BASE_URL}/admin/
    Admin Page open and login    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to page    Products
    Change product

Delete random product
    Go To  http://${BASE_URL}/admin/
    Admin Page open and login    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to page    Products
    Delete product

Add recurring profiles
    Go To  http://${BASE_URL}/admin/
    Admin Page open and login    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to profiles    Recurring Profiles
    Add new profile    ${NAME_SELECTOR}    ${NAME}

Add information
    Go To  http://${BASE_URL}/admin/
    Admin Page open and login    ${LOGIN_SELECTOR}     ${PASSW_SELECTOR}    ${BUTTON_SELECTOR}    Dashboard
    Go to information    Information
    Add new information    ${INFO_TITLE}    ${META}    ${DEFAULT_VAL}