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
${market_type}          //*[@class="sc-mcd__filter__item sc-mcd__filter__item--selected"]
${dur_days}             //*[@id="d"]
${input_field}          //*[@class="dc-input__field"]
${contract_dropdwn}     //*[@id="dt_contract_dropdown"]
${high_low}             //*[@id="dt_contract_high_low_item"]
${barrier_input}        //*[@id="dt_barrier_1_input"]
${dur_tab}              //*[@id="dc_duration_toggle_item"]
${dur_input}            //*[@class="dc-input__container"]
${payout_btn}           //*[@id="dc_payout_toggle_item"]
${payout_input}         //*[@id="dt_amount_input"]
${purchaseput_btn}      //*[@id="dt_purchase_put_button"]
${contract_card}        //*[@class="data-list__row--wrapper"]


*** Test Cases ***
virtual
    Open Browser    https://app.deriv.com    chrome
    Set Window Size    1280    1024
    Set Selenium Speed    0.5 seconds
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
    Wait Until Page Contains Element    ${market_type}
    Click Element    ${market_type}
    Click Element    //*[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]
    Wait Until Page Contains Element    ${contract_dropdwn}    10
    Click Element    ${contract_dropdwn}
    Wait Until Page Contains Element    ${high_low}    10
    Click Element    ${high_low}
    Wait Until Page Contains Element    //*[@value="high_low"]    10
    Click Element    ${dur_tab}
    Press Keys    ${dur_input}    CTRL+a+BACKSPACE
    Input Text    ${input_field}    2
    Wait Until Page Contains Element    ${barrier_input}    10
    Click Element    ${payout_btn}
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    15.50
    Click Element    ${purchaseput_btn}
    Wait Until Page Contains Element    ${dropdown_chart}    10
    Wait Until Page Contains Element    ${contract_card}    10
