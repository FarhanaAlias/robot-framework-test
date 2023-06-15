*** Settings ***
Documentation       Testing for login, create and delete api token

Library             SeleniumLibrary


*** Variables ***
${login_btn}        //button[@name="login"]
${deposit_btn}      //*[text()="Deposit"]//parent::button
${header_setting}   //*[@class="trading-hub-header__setting"]
${profile_tab}      //*[@id="dt_Profile_link"]
${api_token_tab}    //*[@id="/account/api-token"]
${api_token_page}   //*[@class="da-api-token__wrapper"]
${token_name}       //*[@class="dc-input__field"]
${create_btn}       //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
${token_table}      //*[@class="da-api-token__table-cell-row"]
${copy_icon}        //*[@data-testid="dt_copy_token_icon"]
${warning}          //*[@class="dc-modal"]
${okay_btn}         //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
${delete_icon}      //*[@data-testid="dt_token_delete_icon"]
${token_copied}     //*[@class="dc-clipboard__popover dc-popover__bubble"]
${token_table_hdr}  //*[@class="da-api-token__table-header"]
${read}             //*[@name="read"]//parent::label
${trade}            //*[@name="trade"]//parent::label
${payments}         //*[@name="payments"]//parent::label
${trading_info}     //*[@name="trading_information"]//parent::label
${admin}            //*[@name="admin"]//parent::label

*** Test Cases ***
login
    Open Browser    https://app.deriv.com    chrome
    Set Window Size    1280    1024
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
   Input Text    txtEmail    dummy
    Input Password    txtPass    dummy
    Click Element    ${login_btn}
    Wait Until Page Contains Element    ${header_setting}    10

create api token
    # Navigate to setting page
    Click Element    ${header_setting}
    Wait Until Page Contains Element    ${profile_tab}    10
    Click Element    ${api_token_tab} 
    Wait Until Page Contains Element    ${api_token_page}    10

    # Checkbox input = 0 & no input name
    Click Element    ${token_name} 
    Press Keys    ${token_name}     CTRL+a+BACKSPACE
    Element Should Be Disabled    ${create_btn}

    # Checkbox input = 1 & no input name
    Click Element    ${read}
    Click Element    ${token_name} 
    Press Keys       ${token_name}     CTRL+a+BACKSPACE
    Element Should Be Disabled    ${create_btn}

    # Checkbox input = 5 & has input name
    Click Element    ${trade}
    Click Element    ${payments}
    Click Element    ${trading_info}
    Click Element    ${admin}
    Click Element    ${token_name}
    Input Text       ${token_name}    TokenTest
    Element Should Be Enabled    ${create_btn}
    Click Element    ${create_btn}
    Wait Until Page Contains Element   ${token_table}    10

    # Copying API Token
    Click Element    ${copy_icon}
    Wait Until Page Contains Element    ${warning}    10
    Click Element    ${okay_btn}
    Wait Until Page Contains Element    ${token_copied}    10

Delete API Token
    Wait Until Page Contains Element    ${token_table}    10
    Click Element    ${delete_icon}
    Wait Until Page Contains Element    ${warning}    10
    Click Element    ${okay_btn}
    Wait Until Page Contains Element    ${token_table_hdr}    10
    Page Should Not Contain    "TokenTest"
