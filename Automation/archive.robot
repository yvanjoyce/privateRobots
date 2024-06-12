*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
${password}               76230e7c
${username}               mariel.mojares@ollyolly.com

#@{company_list}             Eastern Electrical Corp.    Plumb Pro Mechanical    Richard K. Moore Professional Painting    K&M Gutter Maintenance, LLC    AMG Heating & Air Conditioning    Cohen Family Law Firm, LLC    Panda HVAC Inc.    Coastline Tree Services    Elite Mold Testing & Assessment    D & K Tree Service
#@{company_list}                        Botello Builders LLC     David Wade Attorney at Law
@{company_list}         S.W.E.A.T.    Affordable Tub Refinishing    Fortis Insurance Agency    Key Realtors Management    Dependable Garage Doors    Castle Exteriors LLC    Greywater LLC    Bulldog Construction Service    Enduring Landscapes    Codi M. Dada Law Offices    Premier Landscape and Turf    M & M Air Conditioning    Smith Homes & Remodeling Service    Grumpy's HVAC    LVH Maintenance and Beautification        All Pro Gutter

${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}              7s
${DROPDOWN_CLASS1}       dropdown-content
${LINK_TEXT1}            Report History
${DROPDOWN_CLASS}        dropdown-content
${LINK_TEXT}             Download CSV

*** Test Cases ***
Download Reports for All Companies
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    FOR    ${company}    IN    @{company_list}
        Search Company    ${company}
        Run Keyword And Ignore Error    Process Report Views
        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/a
        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/ul/li[2]/a/span[2]
    END
    Close Window

*** Keywords ***
Perform Login
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[1]    ${username}
    Input Text                xpath=/html/body/div[1]/div/div[1]/form/input[2]    ${password}
    Click Button              xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Page Contains Element    xpath=//*[@id="query"]    ${TIMEOUT}

Search Company
    [Arguments]    ${company}
    Wait Until Element Is Visible    xpath=//*[@id="query"]    ${TIMEOUT}
    Input Text           xpath=//*[@id="query"]        ${company}
    Click Button         xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
    Sleep               1.5
    Log             found BL company
    Log      click report history
    Click Button          xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    ${TIMEOUT}     #wait on dropdown
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]                      #click on dropdown

Process Report Views
    ${success}=    Set Variable    ${TRUE}
    FOR    ${index}    IN RANGE    1    7
        Log         viewing ${index} view
        Click Button         xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/form/button
    END
    Run Keyword If    ${success}    Go Back Twice

Go Back To Search Page
    Go Back

Check If Logged Out
    ${is_logged_out}=    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/div[1]/div/div[1]/form/input[1]
    Run Keyword If    ${is_logged_out}    Perform Login
    [Return]    ${is_logged_out}

Go Back Twice
    Go Back
    Go Back