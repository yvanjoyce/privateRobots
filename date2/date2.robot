*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
#${password}               99e1b4a9
#${username}              webadmin@ollyolly.com
##
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


@{companies}           Guy Jones, Inc.	       Penn Flooring & Restoration	       Water Works, LLC	       Willow River Well & Pump Service	       Triangle Custom Curbing, LLC	       CLK Builders, Inc.	       L&M Electric LLC	       Uno Roofing
#  cloyd   del already         TruPro Patios, LLC	       Monterey Bay Roofing, Inc.	       Sids Heating and Air LLC	       Kosmos Home And Land LLC	       DAC Restoration	       A2Z Cleanup and Restoration G.C, LLC	       MK Radon Specialists	       The Remodel Nest	       Above Par Vacations	       MK Maintenance	       Legacy Windows and Doors LLC	       	       Towne & Country Real Estate & Appraisers, LLC	       1 Source Construction	       E & J Construction of Mid-Michigan        Cleaning with a Meaning LLC	  Hughes Lawn Care	       Blake Appraisal Service	       Charlotte Home Appraisal	       Maintech Service	       Legacy Pest and Wildlife	       Caliber Tree Experts LLC	       CoreFit 24/7	       Zaim Roofing, LLC	       3rd Hand Cleaning & Painting	       Maui ReBuilders, LLC	       Micron Construction Services	       Unaltered Designs	       B&R Roofing Services LLC	       MOV Lawn Care LLC

*** Test Cases ***
Check Report from BL
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    FOR    ${company}    IN    @{companies}
        Log    Processing company: ${company}
        Process Company    ${company}
        Capture Page Screenshot
        Sleep      1s
        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/a
        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[3]/ul/li[2]/a/span[2]

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
    Wait Until Element Is Visible     xpath= //*[@id="js-lsrc-home-content"]/ul/li/div[2]/span[1]           7s
    Click Element      xpath= //*[@id="js-lsrc-home-content"]/ul/li/div[2]/span[1]

    Log      click report history
    Click Button          xpath=//*[@id="js-lsrc-home-content"]/ul/li[1]/div[7]/div/div/button
    Wait Until Element Is Visible    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]    2s     #wait on dropdown
    Click Element    xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li/a[contains(text(), '${LINK_TEXT1}')]                      #click on dropdown
    Sleep       1s
