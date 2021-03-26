*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    String

Resource    ../Resources/DBuserPage.robot

Suite Setup    Connect To Database    pymysql    ${DBName}  ${DBUser}  ${DBPass}  ${DBHost}  ${DBPort}
Suite Teardown    Disconnect From Database

Test Setup    Open Browser    browser=chrome    options=add_argument("--ignore-certificate-errors")
Test Teardown    Close Browser


*** Variables ***
# Database vars
${DBName}  bitnami_opencart
${DBUser}  bn_opencart
${DBPass}
${DBHost}   localhost
${DBPort}  3306
@{OPENCART_ADMIN} =  user  bitnami
${BASE_URL}  localhost



*** Test Cases ***

New user registration
    [Documentation]  Change product name in catalog with ui and validate changes in database. Also change name back.
    [Tags]  DB  ChangeProduct

    Go To  http://${BASE_URL}/admin/
    Maximize Browser Window
    Login With    ${OPENCART_ADMIN}
    Open Catalog Users
    ${NEW_USER_FOR_TEST} =    String.Generate Random String  4  [LETTERS]
    Check Username Not In Database  ${NEW_USER_FOR_TEST}
    Add New User    ${NEW_USER_FOR_TEST}
    Check Username In Database   ${NEW_USER_FOR_TEST}
