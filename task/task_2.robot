*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary


*** Variables ***
${login_btn}            //button[@name="login"]
${dropdown}             //*[@id="dropdown-display"]
${demo_dropdown}        //*[@class="dc-dropdown__list dc-dropdown__list--enter-done"]
${demo}                 //*[@id="demo"]
${demo_text}            //*[@class="dc-text demo-account-card__title"]
${trader_btn}           //*[text()="Deriv Trader"]//following::button[1]
${chart_loader}         //*[@class="chart-container__loader"]
${dropdown_chart}       //*[@class="ic-icon cq-symbol-dropdown"]
${rise_fall}            //*[@value="rise_fall"]
${purchaseup_btn}       //*[@id="dt_purchase_call_button"]
${contract_card}        //*[@class="dc-contract-card dc-contract-card--green"]


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
    Wait Until Page Contains Element    ${demo_dropdown}    10
    Wait Until Page Contains Element    ${demo}    10
    Click Element    ${demo}
    Wait Until Page Contains Element    ${demo_text}    10
    Wait Until Page Contains Element    ${trader_btn}    10
    Click Element    ${trader_btn}
    Wait Until Page Does Not Contain Element    ${chart_loader}    40
    Wait Until Page Contains Element    ${dropdown_chart}    30
    Click Element    ${dropdown_chart}
    Wait Until Page Contains Element    ${rise_fall}    10
    Wait Until Page Contains Element    //*[@data-value="5"]    10
    Wait Until Page Contains Element    //*[@value="10"]    10
    Click Element    ${purchaseup_btn}
    Wait Until Page Contains Element    ${dropdown_chart}    10
    Wait Until Page Contains Element    ${contract_card}    10
