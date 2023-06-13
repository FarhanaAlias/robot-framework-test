*** Settings ***
Documentation       Testing for login, create and delete api token

Library             SeleniumLibrary


*** Variables ***
${login_btn}            //button[@name="login"]
${deposit_btn}          //*[text()="Deposit"]//parent::button
${header_setting}       //*[@class="trading-hub-header__setting"]
${profile_tab}          //*[@id="dt_Profile_link"]
${close_acc_tab}        //*[@id="dc_close-your-account_link"]
${close_acc_term}       //*[@class="closing-account"]
${close_acc_btn}        //*[@class="dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account"]
${close_acc_reason}     //*[@class="closing-account-reasons"]
${checkbox}             //*[@class="dc-checkbox__input"]
${continue_btn}         //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
${not_interested}       //*[@name="not-interested"]//parent::label
${transactions}         //*[@name="difficult-transactions"]//parent::label
${service}              //*[@name="unsatisfactory-service"]//parent::label
${trading_platform}     //*[@name="other_trading_platforms"]
${improve}              //*[@name="do_to_improve"]
${close_warning}        //*[@class="account-closure-warning-modal"]
${close_acc_btn_2}      (//*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"])[2]
${acc_close_ctdown}     //*[@class="dc-text account-closed"]
${start_trade_btn}      //*[@id="btnGrant"]


*** Test Cases ***
Login
    Open Browser    https://app.deriv.com    chrome
    Set Window Size    1280    1024
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    dummy
    Input Password    txtPass    dummy
    Click Element    ${login_btn}
    Wait Until Page Contains Element    ${header_setting}    10

Closing Account
    # Navigate to setting page
    Click Element    ${header_setting}
    Wait Until Page Contains Element    ${profile_tab}    10
    Click Element    ${close_acc_tab}
    Wait Until Page Contains Element    ${close_acc_term}    10
    Click Element    ${close_acc_btn}
    Wait Until Page Contains Element    ${close_acc_reason}    10

    # Checkbox input 0
    Checkbox Should Not Be Selected    ${checkbox}
    Element Should Be Disabled    ${continue_btn}

    # Checkbox input 4
    Click Element    ${not_interested}
    Click Element    ${transactions}
    Click Element    ${service}
    Checkbox Should Not Be Selected    ${checkbox}

    # Checkbox input 3 + reason box    
    Input Text    ${improve}    Because trading platform have different fee structures, including commissions, spread and subscription charges
    Page Should Contain    Remaining characters: 0
    Element Should Be Enabled    ${continue_btn}
    Click Element    ${continue_btn}
    Wait Until Page Contains Element    ${close_warning}    10
    Click Element    ${close_acc_btn_2}
    Wait Until Page Does Not Contain    ${acc_close_ctdown}    20

Login After Deactivate
    Wait Until Page Contains Element    dt_login_button    20
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    dummy
    Input Password    txtPass    dummy
    Click Element    ${login_btn}
    Page Should Contain    Want to start trading on Deriv again?
    Click Element    ${start_trade_btn}
    Wait Until Page Contains Element    ${deposit_btn}    10
