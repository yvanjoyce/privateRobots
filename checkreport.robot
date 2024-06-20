#*** Settings ***
#Library      SeleniumLibrary
#
#
#
#*** Variables ***
#${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
#${browser}                  chrome
#${password}          76230e7c
#${username}         mariel.mojares@ollyolly.com
######################
#${company}            The Law Offices of Precious Felder, LLC
###################
#${REL_XPATH}          xpath=//div[@class='menu-container']//ul/li[3]
#${CHECKBOX_ID}          id=rememberMe
#${TIMEOUT}                 7s
#
#${DROPDOWN_CLASS1}    dropdown-content
#${LINK_TEXT1}         Report History
#
#
##download CSV
#${DROPDOWN_CLASS}    dropdown-content
#${LINK_TEXT}         Download CSV
#
#
#
#*** Test Cases ***
#download report from BL
#           Open Browser               ${url}     ${browser}
#           Maximize Browser Window
#           input text                   xpath=/html/body/div[1]/div/div[1]/form/input[1]     ${username}
#           input text                    xpath=/html/body/div[1]/div/div[1]/form/input[2]         ${password}
#           click button                 xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
#           Wait Until Element Is Visible         xpath=//*[@id="query"]             7s
#           input text           xpath=//*[@id="query"]        ${company}
#           log      click search button
#           click button     xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
#            Sleep               4
#            log             found BL company
#           log      click report history
#           click button          xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    10s     #wait on dropdown
#           Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]                      #click on dropdown
#           Check If Logged Out
#
#
#
#
#            log         viewing 1st view
##           #click on onview on next report
#           Click Element     xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[1]/td[4]/div/a[1]
#
#           log          click action buttton 1st
##           #click action
#           click button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
#           click element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]            #click download
#           Go Back
#            Check If Logged Out
#           #archive         1st report
#           click element             xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[1]/td[4]/div/a[2]
#           click button             xpath=//*[@id="campaignHistoryActions-0"]/li/form/button                            #archive
#
#            log         viewing 2nd view
##           #click on onview on next report
#           Click Element     xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[2]/td[4]/div/a[1]
#
#           log          click action buttton 2nd
##           #click action
#           click button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
#           click element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]            #click download
#           Go Back
#           Check If Logged Out
#           Run Keyword If    ${is_logged_out}    Perform Login
#
#           #2nd archive
#                 click element         xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[2]/td[4]/div/a[2]
#                  click button         xpath=//*[@id="campaignHistoryActions-1"]/li/form/button
#
#            log         viewing 3rd view
##           #view 3rd
#           click element          xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[3]/td[4]/div/a[1]
#           #click action
#            click button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
#           Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
#           Go Back
#           Check If Logged Out
#           Run Keyword If    ${is_logged_out}    Perform Login
#
#           log      3rd archive
#            #3rd archive
#        click element         xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[3]/td[4]/div/a[2]
#         click button         xpath=//*[@id="campaignHistoryActions-2"]/li/form/button
#
#
#            log         viewing 4th view
##           #view 4th
#           click element          xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[4]/td[4]/div/a[1]
#           #click action
#           click button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
#           Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
#           Go Back
#            Check If Logged Out
#           Run Keyword If    ${is_logged_out}    Perform Login
#
#
#           log      4th archive
#            #3rd archive
#            click element         xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[4]/td[4]/div/a[2]
#             click button         xpath=//*[@id="campaignHistoryActions-3"]/li/form/button
#
#           log         viewing 5th view
##           #view 5th
#           click element          xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[5]/td[4]/div/a[1]
#           #click action
#            Wait Until Element Is Visible         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button     ${TIMEOUT}
#           click button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
#           Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
#           Go Back
#           Check If Logged Out
#           Run Keyword If    ${is_logged_out}    Perform Login
#
#
#            log      5th archive
#            #3rd archive
#                   click element         xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[5]/td[4]/div/a[2]
#                   click button         xpath=//*[@id="campaignHistoryActions-4"]/li/form/button
#
#
#           log         viewing 6th view
##           #view 5th
#           click element          xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[6]/td[4]/div/a[1]
#           #click action
#           click button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
#           Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
#           Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
#           Go Back
#           Sleep           2
#           CLose window
#
#
#
#*** Keywords ***
#Log Element HTML
#    [Arguments]    ${xpath}
#    ${element}=    Get WebElement    ${xpath}
#    ${outer_html}=    Execute JavaScript    return arguments[0].outerHTML;    ${element}
#    Log    ${outer_html}
#Check If Logged Out
#    ${is_logged_out}=    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/div[1]/div/div[1]/form/input[1]
#    Run Keyword If    ${is_logged_out}    Perform Login
#
#Perform Login
#    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[1]    ${username}
#    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[2]    ${password}
#    Click Button              xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
#    Wait Until Element Is Visible    xpath=//*[@id="query"]    ${TIMEOUT}

*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
${password}               76230e7c
${username}               mariel.mojares@ollyolly.com
#####################
${company}            30Electric LLC
##################
${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}               7s

${DROPDOWN_CLASS1}       dropdown-content
${LINK_TEXT1}            Report History

# download CSV
${DROPDOWN_CLASS}        dropdown-content
${LINK_TEXT}             Download CSV

*** Test Cases ***
Download Report from BL
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    Wait Until Element Is Visible         xpath=//*[@id="query"]             ${TIMEOUT}
    Input Text           xpath=//*[@id="query"]        ${company}
    Log      click search button
    Click Button     xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
    Sleep               4
    Log             found BL company
    Log      click report history
    Click Button          xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    10s     #wait on dropdown
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]                      #click on dropdown

   Process Report View  1
    Process Report View  2
    Process Report View  3
    Process Report View  4
    Process Report View  5
    Process Report View  6
    Close Window

*** Keywords ***
Perform Login
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[1]    ${username}
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[2]    ${password}
    Click Button              xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="query"]    ${TIMEOUT}

Check If Logged Out
    ${is_logged_out}=    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/div[1]/div/div[1]/form/input[1]
    Run Keyword If    ${is_logged_out}    Perform Login
    [Return]    ${is_logged_out}

Process Report View
    [Arguments]    ${index}
    Log         viewing ${index} view
    Click Element     xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[1]
    Log          click action button ${index}
    Click Button         xpath=//*[@id="contentWrapper"]/div[4]/div/header/div[2]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]    10s
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS}')]/ul/li/a[contains(text(), '${LINK_TEXT}')]
    Go Back
    ${is_logged_out}=    Check If Logged Out
    ${index_minus_1}=    Evaluate    ${index} - 1
    Run Keyword Unless    ${is_logged_out}    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[2]
    Run Keyword Unless    ${is_logged_out}    Click Button     xpath=//*[@id="campaignHistoryActions-${index_minus_1}"]/li/form/button
