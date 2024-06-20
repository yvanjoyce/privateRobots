*** Settings ***
Library      SeleniumLibrary

*** Variables ***
${url}                    https://tools.brightlocal.com/seo-tools/admin/login?redirect_url=%252Fseo-tools%252Fadmin%252Flsrc%253F&redirect_source=access_control
${browser}                chrome
#${password}                99e1b4a9
#${username}              webadmin@ollyolly.com
${password}               76230e7c
${username}               mariel.mojares@ollyolly.com

#??           Viking Lawn Care	     Jason Forostoski Home Improvements    Sopris Gates & Doors LLC	       Green Way Insulation, Inc	       Dowler Heating Cooling & Refrigeration, LLC       Diamond State Overhead Door Inc        Husky Tree Care	       Ascape Landscaping	       34 North Electrical, LLC	       Cameron Wilson Electrician	    All Surfaces Power Washing            10x Better Lawn and Landscape, Inc.	       Davila Technical Services, LLC	     Level Up Foundation Repair    DH Pools, Inc.	       Cutler Evans Tree	       Super Garage Door Guy, LLC            South Hills Home Remodeling	       Roofs 101        Our Best Home Inspections	       Kilduff Construction LLC

@{company_list}            Guy Jones, Inc.	       Penn Flooring & Restoration	       Water Works, LLC	       Willow River Well & Pump Service	       Triangle Custom Curbing, LLC	       CLK Builders, Inc.	       L&M Electric LLC	       Uno Roofing



   #     Aurora Fabrications, LLC	       Pole of Cold Air Conditioning, Inc.	       Tri City Epoxy Coatings       	       	       Assurance Factor Electric	       Dryer Vent Solution	       Acadiana Kitchen & Shutters LLC	       Barranco Roofing	       J.E. Potteiger Tree Service	       Rodriguez Roofing	                      Air Flow Systems, LLC	       Carlo Priska D. ARCH. Architect Associates	       Titan Dumpsters	       Hopewell Construction LLC	   	       Coral Pool Company LLC	       North Port Irrigation, LLC	      Arcolyte	       Gordon Dobbs Construction	       Hasi Property Restoration	       Brookpark Decorators LLC	       110% Landscape LLC	       Magic Carpet and Flooring	       Chris Electric, Inc.	       Nocturnal Nightmares Wildlife Control LLC	     	       Dreamline Roofing	       Buzzards Services, LLC	       Assassins For Hire Pest Control

 #  Environmental Mold Solutions, Inc.             Palm Systems Electric	       Bear State Home Inspection	       Alpha Roofing, LLC	       Maineiac Services Hauling & Junk Removal	             Licata Electric, Inc.	             Blake & Sons Garage Doors	       KW Electric	       AquaVets	       Orange Paving & Construction	       Affordable Roofing Inc	       C2 Custom Concrete Designs


    # deleted       Dynamic Electric        Abaco Cleaning Service	       Golden Eagle Heating, Cooling And Drain Cleaning	       APCU, LLC	       Raptor Electric and General Contractor             Sustainable Home Construction	       Custom Irrigation Services, LLC	            The Mosquito Militia & Mid-Sota Wildlife Op	       Boyd's Electric	       Anchor Door Systems of Lake Norman, Inc.	       Solid Rock Hardscapes	       Red Line Landworx LLC	       Bison Stump Grinding, LLC	       Dynamic Electric	       Junk Solutions	       NewBrite LLC	       Timberline Hardwood Floors, LLC

       # cee        deleted        Nelson Day Electrical & Engineering	       Reliable Restoration and Construction LLC	       Kitner's Lawn & Landscape LLC	       Just Junkin	       JA Electric, LLC	       The Gaines Group	       Yardmasters of America	       Discount Roofers	       Patriot Roofing	       Quick Connect Electric, Inc.


${REL_XPATH}             xpath=//div[@class='menu-container']//ul/li[3]
${CHECKBOX_ID}           id=rememberMe
${TIMEOUT}               10s
${DROPDOWN_CLASS1}       dropdown-menu
${LINK_TEXT1}            Delete


*** Test Cases ***
Deleting BL
    Open Browser               ${url}     ${browser}
    Maximize Browser Window
    Perform Login
    Click Element           xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[2]/a/span             #click loc


    FOR    ${company}    IN    @{company_list}
        Run Keyword And Ignore Error        Search Company    ${company}
        Run Keyword And Ignore Error         Delete BL    ${company}
        ${visible}=    Run Keyword And Return Status    Element Should Be Visible        xpath=//*[@id="contentWrapper"]/div/div[2]/div[2]/div[1]/div/div/div[2]/div[2]/div/div[3]/div/div/button
        Run Keyword IF           ${visible}        Click Element    xpath=//*[@id="main-nav"]/nav/section/ul[1]/li[2]/a/span       #click loc
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
    [Documentation]                Search Company
    [Arguments]    ${company}
    Wait Until Element Is Visible    xpath=//*[@id="query"]   ${TIMEOUT}  #search bar
    Input Text           xpath=//*[@id="query"]        ${company}
    Click Button         xpath=//*[@id="contentWrapper"]/div/div[2]/div[2]/div[1]/div/div/div[1]/div/div[1]/form/button
    Sleep               3s
    Log             found BL company



Go Back To Search Page
    Go Back

Check If Logged Out
    ${is_logged_out}=    Run Keyword And Return Status    Element Should Be Visible    xpath=/html/body/div[1]/div/div[1]/form/input[1]
    Run Keyword If    ${is_logged_out}    Perform Login
    [Return]    ${is_logged_out}

Go Back Twice
    Go Back
    Go Back

Delete BL
        [Documentation]       deleting
        [Arguments]    ${company}

        Log      click delete
        Click Button          xpath=//*[@id="contentWrapper"]/div/div[2]/div[2]/div[1]/div/div/div[2]/div[2]/div/div[3]/div/div/button    #click dropdown
        Click Element                  xpath=//div[contains(@class, '${DROPDOWN_CLASS1}')]/ul/li[contains(text(), '${LINK_TEXT1}')]         #click on delete
        Input Text         xpath= /html/body/div[10]/div[2]/div[4]/input               PERMANENTLY DELETE          #input PERMANENTLY DELETE
        Sleep       1.5s
        Wait Until Page Contains Element                xpath=//div[contains(@class, 's-mts flex end-center')]/button[contains(text(), 'Permanently Delete')]         #click on delete
        Click Button              xpath=//div[contains(@class, 's-mts flex end-center')]/button[contains(text(), 'Permanently Delete')]         #click on delete
        Sleep       5s
