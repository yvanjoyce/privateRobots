*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
${password}                99e1b4a9
${username}              webadmin@ollyolly.com
#${password}               76230e7c
#${username}               mariel.mojares@ollyolly.com
@{company_list}            Rose Tree Service & Vegetation Management                Plumb Crazy LLC                Patriot Tree LLC                Richard Donnally Associates                M & D Roofing and Renovations                BrookRidge Radon            Paradise Pressure Cleaning                Professional Painting & Pressure Washing




${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}               10s
${DROPDOWN_CLASS1}       dropdown-menu
${LINK_TEXT1}            Delete


*** Test Cases ***
Download Reports for All Companies
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    Click Element           xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[2]/a/span             #click loc
    FOR    ${company}    IN    @{company_list}
        Run Keyword And Ignore Error        Search Company    ${company}
         ${visible}=    Run Keyword And Return Status    Element Should Be Visible        xpath=//*[@id="contentWrapper"]/div/div[2]/div[2]/div[1]/div/div/div[2]/div[2]/div/div[3]/div/div/button
         Run Keyword unless          ${visible}        docu
         Run Keyword unless          ${visible}        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[2]/a/span       #click loc

        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[2]/a/span       #click loc

    END
    Close Window

*** Keywords ***
Perform Login
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[1]    ${username}
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[2]    ${password}
    Click Button              xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Page Contains Element    xpath=//*[@id="query"]    ${TIMEOUT}

Search Company
     [Documentation]        searching
    [Arguments]    ${company}
    Wait Until Element Is Visible    xpath=//*[@id="query"]   ${TIMEOUT}  #search bar
    Input Text           xpath=//*[@id="query"]        ${company}
    Click Button         xpath=//*[@id="contentWrapper"]/div/div[2]/div[2]/div[1]/div/div/div[1]/div/div[1]/form/button
    Sleep               3s
    Log             found BL company



delete this BL
    Log      click delete
    Click Button          xpath=//*[@id="contentWrapper"]/div/div[2]/div[2]/div[1]/div/div/div[2]/div[2]/div/div[3]/div/div/button    #click dropdown
    Click Element                  xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li[contains(text(), '${LINK_TEXT1}')]         #click on delete
    Input Text         xpath= /html/body/div[10]/div[2]/div[4]/input               PERMANENTLY DELETE          #input PERMANENTLY DELETE
    Sleep       1.5s
    Wait Until Page Contains Element                xpath=//div[contains(@class, 's-mts flex end-center')]/button[contains(text(), 'Permanently Delete')]         #click on delete
    Click Button              xpath=//div[contains(@class, 's-mts flex end-center')]/button[contains(text(), 'Permanently Delete')]         #click on delete
    Sleep       5s


docu
     [Documentation]       not found
     log           cannot be found > not deleted

Go Back To Search Page
    Go Back

Check If Logged Out
    ${is_logged_out}=    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/div[1]/div/div[1]/form/input[1]
    Run Keyword If    ${is_logged_out}    Perform Login
    [Return]    ${is_logged_out}

Go Back Twice
    Go Back
    Go Back

