*** Settings ***
Library     FakerLibrary    locale=en_US
Library     OperatingSystem
Library     String
Library     Screenshot
Library     BuiltIn
Library     DateTime
Resource    ../../Main.robot
Resource    ../../Comum.robot
Resource    ../../Locators/regularAccount/regularAccount.robot
Resource    ../../../Resources/PageObjects/administratorAccount/administratorAccount.robot

*** Keywords ***
#"Comum"------------------------------------------------------------------------------------------------------------------------------------------------
On the "${nameTab}" tab
    Click    xpath=//a[contains(.,'${nameTab}')]

Click "${button}"
    Click    xpath=//button[contains(.,'${button}')]

Message "${msg}" must be visible
    Wait Until Element Is Visible    xpath=//p[contains(.,'${msg}')]

#Home tab------------------------------------------------------------------------------------------------------------------------------------------------
Search for a product that doesn't exist
    Input    ${home.inputSear}   not exist

Search
    Click    ${home.btSear}

Show no results
    Sleep    1
    Element Should Be Visible    ${home.msNoProdu}

Search for a product
    Input    ${home.inputSear}    No picture
    Search
    ${status}    Run Keyword And Return Status    Show no results
    IF    $status == $True
        Click "Logout"
        Be logged in as "admin"
        Be at "Cadastrar Produtos" tab
        Fill product "no picture"
        Click button register
        Product must be on the list
        Click "Logout"
        Be logged in as "regular"
        Be at "Home" tab
        Input    ${home.inputSear}    No picture
        Search        
    END

Detail the product
    Click    ${home.detail}

Product's details must be visible
    Wait Until Element Is Visible    ${home.msDetail}

Product must be on the Shopping cart
    Log    Unfortunately this page is not done