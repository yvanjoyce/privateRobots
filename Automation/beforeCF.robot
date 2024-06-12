*** Settings ***
Library           SeleniumLibrary

*** Variables ***
@{urls}    https://www.plantationroomcompany.com/    https://www.calhounheatingandairconditioningky.com/    https://www.daveshomeremodeling.com/    https://www.herbclarktreeservicenj.com/    https://www.insideoutkitchensbaths.com/    https://www.carrgoservices.com/    https://www.guldanplumbing.com/    https://www.steelhorserc.com/    https://www.bcs-customfab.com/    https://www.americanblindsshutteroutlet.com/    https://www.a1abilityelectrictx.com/    https://www.eaplumbingservices.com/    https://www.statelineroofingcompany.com/    https://www.erwinbuildersfl.com/    https://www.martinezrgs.com/    https://www.newageroofschicago.com/    https://www.furnaceexchange.com/    https://www.bgamericanplumbing.com/    https://www.billpurchaseconstructionllc.com/    https://www.lamberthvac.com/    https://www.buckleysbesttreecare.com/    https://www.jrtreeworksllc.com/    https://www.30electric.net/

*** Test Cases ***
Capture Screenshots of URLs
    FOR    ${url}    IN    @{urls}
        Log    ${url}
         Open Browser    ${url}    chrome
        Maximize Browser Window
        Scroll To Element    xpath=//div[@class='your-div-class']
        Capture Page Screenshot
        Close Browser
    END
*** Keywords ***
Scroll To Element
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}
