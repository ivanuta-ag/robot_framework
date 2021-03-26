*** Settings ***
Library    SeleniumLibrary
Library    String
Library    DatabaseLibrary
#
*** Variables ***
${LOGIN_FORM}  css=form
${USERNAME_INPUT}  css=#input-username
${PASSWORD_INPUT}  css=#input-password
${MENU_SYSTEM}  css=#menu-system
${USER_ITEMS}  xpath=(//*[@id = "collapse7"]/li/a)[2]
${USER_ITEMS_2}  css=#collapse7-1 > li > a
${ADD_NEW}    css=.fa.fa-plus
${INPUT_USERNAME}    css=#input-username
${INPUT_FIRSTNAME}    css=#input-firstname
${INPUT_LASTNAME}    css=#input-lastname
${INPUT_EMAIL}    css=#input-email
${INPUT_PASSWORD}    css=#input-password
${INPUT_CONFIRM}    css=#input-confirm
${SAVE}    css=.fa.fa-save
${OC_USER}    oc_user

*** Keywords ***
Login With
    [Arguments]    ${user_data}
    Wait Until Element Is Visible  ${LOGIN_FORM}
    Input Text  ${USERNAME_INPUT}  ${user_data}[0]
    Input Text  ${PASSWORD_INPUT}  ${user_data}[1]
    Submit Form  ${LOGIN_FORM}
    Wait Until Page Contains Element    xpath=//h1[contains(text(), 'Dashboard')]

Open Catalog Users
    Click Element  ${MENU_SYSTEM}
    ${user_items} =  Get Webelements  ${USER_ITEMS}
    BuiltIn.Wait Until Keyword Succeeds  3 sec  1 sec  Click Element  ${user_items}
    Click Element   ${USER_ITEMS}
    Click Element   ${USER_ITEMS_2}
    Wait Until Page Contains Element  xpath=//h1[text()='Users']


Add New User
    [Arguments]    ${name}
    Click Element  ${ADD_NEW}
    Input Text    ${INPUT_USERNAME}   ${name}
    Input Text    ${INPUT_FIRSTNAME}    ${name}
    Input Text    ${INPUT_LASTNAME}    ${name}
    Input Text    ${INPUT_EMAIL}    ${name}@mail.ru
    Input Text    ${INPUT_PASSWORD}    1111
    Input Text    ${INPUT_CONFIRM}    1111
    Click Element  ${SAVE}


Check Username In Database
    [Arguments]    ${value}
    Check If Exists In Database  select username from bitnami_opencart.${OC_USER} where username = '${value}'


Check Username Not In Database
    [Arguments]    ${value}
    Check If Not Exists In Database  select username from bitnami_opencart.${OC_USER} where username = '${value}'

