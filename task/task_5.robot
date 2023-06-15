*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary


*** Variables ***
${deposit_btn}          //*[text()="Deposit"]//parent::button
${dropdown}             //*[@id="dropdown-display"]
${demo_dropdown}        //*[@class="dc-dropdown__list dc-dropdown__list--enter-done"]
${demo}                 //*[@id="demo"]
${demo_text}            //*[@class="dc-text demo-account-card__title"]
${trader_btn}           //*[text()="Deriv Trader"]//following::button[1]
${chart_loader}         //*[@class="chart-container__loader"]
${dropdown_chart}       //*[@class="ic-icon cq-symbol-dropdown"]
${contract_dropdwn}     //*[@id="dt_contract_dropdown"]
${market_type}          //*[@class="sc-mcd__filter__item sc-mcd__filter__item--selected"]
${multiplier}           //*[@id="dt_contract_multiplier_item"]
${takeprofit}           //*[@class="dc-checkbox take_profit-checkbox__input"]
${takeprofit_cb}        //*[@id="dc_take_profit-checkbox_input"]
${stoploss}             //*[@class="dc-checkbox stop_loss-checkbox__input"]
${stoploss_cb}          //*[@id="dc_stop_loss-checkbox_input"]
${cancel}               //label[@for="dt_cancellation-checkbox_input"]
${cancel_cb}            //*[@id="dt_cancellation-checkbox_input"]
${up_btn}               //*[@id="dt_purchase_multup_button"]
${down_btn}             //*[@id="dt_purchase_multdown_button"]
${fee}                  //*[@class="trade-container__price-info-currency"]
${payout_input}         //*[@id="dt_amount_input"]
${payout_container}     //*[@class="trade-params--mobile__payout-container"]

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
    Click Element    //button[@name="login"]
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
    Wait Until Page Contains Element    ${market_type}     10
    Click Element    ${market_type}
    Click Element    //*[@class="sc-mcd__item sc-mcd__item--R_50 "]
    Wait Until Page Contains Element    ${contract_dropdwn}    10
    Click Element    ${contract_dropdwn}
    Wait Until Page Contains Element    ${multiplier}    10
    Click Element    ${multiplier}
    Wait Until Page Contains Element    //*[@value="multiplier"]    10

    # a. Only stake is allowed. Should not have payout option
    Page Should Contain    "Stake"
    Page Should Not Contain    "Payout"

    # b. Only deal cancellation or take profit/stop loss is allowed
    Click Element    ${takeprofit}
    Checkbox Should Be Selected    ${takeprofit_cb}
    Checkbox Should Not Be Selected    ${stoploss_cb}
    Checkbox Should Not Be Selected    ${cancel_cb}

    Click Element    ${stoploss}
    Checkbox Should Be Selected    ${stoploss_cb}
    Checkbox Should Not Be Selected    ${cancel_cb}

    Click Element    ${cancel}
    Checkbox Should Be Selected    ${cancel_cb}
    Checkbox Should Not Be Selected    ${takeprofit_cb}
    Checkbox Should Not Be Selected    ${stoploss_cb}

    # c. Multiplier value selection should have x20, x40, x60, x100, x200
    Click Element    //*[@class="dc-dropdown__container"]
    Page Should Contain    "x20"
    Page Should Contain    "x40"
    Page Should Contain    "x60"
    Page Should Contain    "x100"
    Page Should Contain    "x200"

    # d. Deal cancellation fee should correlate with the stake value (e.g. deal cancellation fee is more expensive when the stake is higher)
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    1
    Wait Until Element Is Visible    ${fee}    20
    ${cancel_fee}    Get Text    ${fee}
    ${cancel_fee}    Set Variable    ${cancel_fee[:-4]}
    Log To Console    ${cancel_fee}
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    2
    Wait Until Element Is Visible    ${fee}    20
    ${updated_fee}    Get Text    ${fee}
    ${updated_fee}    Set Variable    ${updated_fee[:-4]}
    Log To Console    ${updated_fee}
    Should Be True    ${updated_fee} > ${cancel_fee}

    # e. Maximum stake is 2000 USD
    Click Element    ${payout_input}
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    2001
    Wait Until Page Contains Element    ${payout_container}    20
    Element Should Be Disabled    ${up_btn}
    Element Should Be Disabled    ${down_btn}
    Wait Until Page Contains Element    ${payout_container}    20
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    2000
    Wait Until Page Contains Element    ${payout_container}    20
    Element Should Be Enabled    ${up_btn}
    Element Should Be Enabled    ${down_btn}

    # f. Minimum stake is 1 USD
    Click Element    ${payout_input}
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    0
    Wait Until Page Contains Element    ${payout_container}    20
    Element Should Be Disabled    ${up_btn}
    Element Should Be Disabled    ${down_btn}
    Wait Until Page Contains Element    ${payout_container}    20
    Press Keys    ${payout_input}    CTRL+a+BACKSPACE
    Input Text    ${payout_input}    1
    Wait Until Page Contains Element    ${payout_container}    20
    Element Should Be Enabled    ${up_btn}
    Element Should Be Enabled    ${down_btn}
    Wait Until Page Contains Element    ${payout_container}    20

    # g. Single click on plus (+) button of take profit field should increase the take profit value by 1 USD
    Click Element    ${takeprofit}
    Click Element    //*[@id="dc_take_profit_input_add"]
    Wait Until Page Contains Element    //*[@value="1"]    10

    # h. Single click on minus (-) button of take profit field should decrease the take profit value by 1 USD
    Click Element    //*[@id="dc_take_profit_input_sub"]
    Wait Until Page Contains Element    //*[@value="0"]    10

    # i. Deal cancellation duration only has these options: 5, 10, 15, 30 and 60 min
    Click Element    ${cancel}
    Click Element    //span[@class="dc-text dc-dropdown__display-text" and @name="cancellation_duration"]
    Page Should Contain    "5 minutes"
    Page Should Contain    "10 minutes"
    Page Should Contain    "15 minutes"
    Page Should Contain    "30 minutes"
    Page Should Contain    "60 minutes"
