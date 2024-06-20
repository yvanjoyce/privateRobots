*** Settings ***
Library      SeleniumLibrary
Library      OperatingSystem

*** Variables ***
${url}                   https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}               chrome
${password}              76230e7c
${username}              mariel.mojares@ollyolly.com
${DROPDOWN_CLASS1}       dropdown-content
${LINK_TEXT1}            Report History
${DROPDOWN_CLASS}        dropdown-content
${LINK_TEXT}             Download CSV
${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}               7s

#@{company_list}          Tomco Construction      Providential Roofing and Construction      RG's Electrical Services      Waste Masters         Creative Pools and Hardscape       Exterior Home Solutions of Fayetteville        J.E. Mountain Insulation LLC    County Termite & Pest Control      Security Solar    Restoration Plus    Eastern Electrical     Plumb Pro Mechanical    Richard K. Moore Professional Painting    K&M Gutter Maintenance     AMG Heating & Air Conditioning    Cohen Family Law Firm    Panda HVAC      Coastline Tree      Elite Mold Testing & Assessment    D & K Tree Service
@{company_list}             Lux Electric and Property Management    Burbrink Appraisal Services    Pacific Coast Purification    Pro Advantage Concrete Solutions    Kobe Construction    Mennis Heating and Cooling    Advanced Septic Care    Black Ink Electric    Mamayek Heating & Cooling    Rye Moving & Packing    A & H Exteriors Inc    D & D Excavating LLC      Botello Builders LLC    Boise Creek Construction    David Wade Attorney at Law    Amante Creations
*** Test Cases ***
Download Reports for All Companies
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    FOR    ${company}    IN    @{company_list}
        Search Company    ${company}
        Run Keyword And Ignore Error    Get Date
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

Get Date
    FOR    ${index}    IN RANGE    1    7
        ${text}    Get Text    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[1]/span[1]
        Log    ${text}
        Append To File    dates.txt    ${text}
        Run Keyword Unless    ${is_logged_out}    Click Element    xpath=//*[@id="contentWrapper"]/div[3]/div[2]/table/tbody/tr[${index}]/td[4]/div/a[2]
        ${visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id="campaignHistoryActions-${index_minus_1}"]/li/form/button
        Run Keyword Unless    ${visible}    Go Back Twice
        Click Button     xpath=//*[@id="campaignHistoryActions-${index_minus_1}"]/li/form/button
    END
