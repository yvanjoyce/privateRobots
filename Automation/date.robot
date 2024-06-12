*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
${password}               76230e7c
${username}               mariel.mojares@ollyolly.com
${DROPDOWN_CLASS1}       dropdown-content
${LINK_TEXT1}            Report History

# download CSV
${DROPDOWN_CLASS}        dropdown-content
${LINK_TEXT}             Download CSV
${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}               2s

${TIMEOUT}               2s

#michael        @{companies}            East Tennessee Turf LLC    Forest Mechanical        Stick Horse Construction    The Duke of Plumbing      Cape Cod Mold Removal    Ben Franklin Services
@{companies}           JRC Home Remodeling LLC    Fixed Right Home Services LLC    4 Life Electric LLC    R.J Turner Well and Pump LLC    Caruke Electrical, Inc.    Cornerstone Construction Services, LLC (KS)    Concrete Makeover    Integrity Cabinets and Countertops    MWD Heating and Air Conditioning LLC    MR. Precision Grading & Excavating LLC    Matts Wildlife Solutions    Rick Wilbert DC    John Davis Siding


*** Test Cases ***
Check Report from BL
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    FOR    ${company}    IN    @{companies}
        Log    Processing company: ${company}
        Process Company    ${company}

    END

*** Keywords ***
Perform Login
    Input Text           xpath=/html/body/div[1]/div/div[1]/form/input[1]        ${username}
    Input Text           xpath=/html/body/div[1]/div/div[1]/form/input[2]        ${password}
    Click Button         xpath=/html/body/div[1]/div/div[1]/form/div[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="query"]           7s

Process Company
    [Arguments]    ${company}
    Wait Until Element Is Visible         xpath=//*[@id="query"]             7s
    Clear Element Text    xpath=//*[@id="query"]
    Input Text           xpath=//*[@id="query"]        ${company}
    Log      click search button
    Click Button     xpath=//*[@id="js-lsrc-home-content"]/header/nav/div[1]/form/button
    Sleep               2
    Click Element       //*[@id="js-lsrc-home-content"]/ul/li/div[2]/span[1]

    Log      click report history
    Click Button          xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    2s     #wait on dropdown
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]                      #click on dropdown
    Sleep       1.5s
    Capture Page Screenshot
     Sleep       1.5s
      Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/a
     Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/ul/li[2]/a/span[2]
    Log    Completed processing for: ${company}