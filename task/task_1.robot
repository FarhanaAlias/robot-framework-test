*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary


*** Variables ***
${login_btn}        //button[@name="login"]
${deposit_btn}      //*[text()="Deposit"]//parent::button
${dropdown}         //*[@id="dropdown-display"]
${dropdown_open}    //*[@class="dc-dropdown__list dc-dropdown__list--enter-done"]
${real}             //*[@id="real"]
${demo}             //*[@id="demo"]
${demo_text}        //*[@class="dc-text demo-account-card__title"]



*** Test Cases ***
virtual
    Open Browser    https://app.deriv.com    chrome
    Set Window Size    1280    1024
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    dummy
    Input Password    txtPass    dummy
    Click Element    ${login_btn}
    Wait Until Page Contains Element    ${dropdown}    10
    Click Element    ${dropdown}
    Wait Until Page Contains Element    ${dropdown_open}    10
    Wait Until Page Contains Element    ${demo}    10
    Click Element    ${demo}
    Wait Until Page Contains Element    ${demo_text}     10




 
