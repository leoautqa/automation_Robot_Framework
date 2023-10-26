*** Settings ***
Library     FakerLibrary    locale=en_US
Library     OperatingSystem
Library     String
Library     Screenshot
Library     BuiltIn
Library     DateTime
Resource    ../../Main.robot
Resource    ../../Comum.robot
Resource    ../../Locators/administratorAccount/administratorAccount.robot

*** Keywords ***
#"Comum"------------------------------------------------------------------------------------------------------------------------------------------------
Be at "${nameTab}" tab
    Click    xpath=//a[contains(.,'${nameTab}')]

#HOME ---------------------------------------------------------------------------------------------------------------------------------------------------
Page must load correctly
    Wait Until Element Is Visible    ${home.hCadUse}
    Wait Until Element Is Visible    ${home.hLisUse}
    Wait Until Element Is Visible    ${home.hCadProd}
    Wait Until Element Is Visible    ${home.hLisProd}
    Wait Until Element Is Visible    ${home.hRel}

#Cadastrar Usuários -------------------------------------------------------------------------------------------------------------------------------------
Do the registration
    Click    ${cadUsu.btCad}

Message "${note}" on Register Users
    IF    $note == "alert register"
        Wait Until Element Is Visible    ${cadUsu.msgNameMan}
        Wait Until Element Is Visible    ${cadUsu.msgEmailMan}
        Wait Until Element Is Visible    ${cadUsu.msgPassMan}
    ELSE
        Wait Until Element Is Visible    ${cadUsu.msAlrExi}
    END

Complete "${type}" registration
    ${name}    FakerLibrary.Name
    Set Global Variable    ${globalname}    ${name}
    Input    ${cadUsu.inpName}    ${globalname}
    ${email}    FakerLibrary.Email
    Set Global Variable    ${globalEmail}    ${email}
    Input    ${cadUsu.inpEmail}    ${globalEmail}
    ${password}    FakerLibrary.Password
    Set Global Variable    ${globalPassword}    ${password}
    Input    ${cadUsu.inpPass}    ${globalPassword}
    IF    $type == "Administrator"
        Click    ${cadUsu.cheBoxAdm}
    END

"${line}" registration must be on the list
    Wait Until Element Is Visible    ${lisUsu.hUmLisUsu}
    Sleep    1
    IF    $line == "Regular"
        Scroll Element Into View    xpath=//tr[td[contains(., '${globalname}')] and td[contains(., 'false')]]/td
    ELSE
        Scroll Element Into View    xpath=//tr[td[contains(., '${globalname}')] and td[contains(., 'true')]]/td
    END

Complete registration already exists
    Input    ${cadUsu.inpName}    ${globalname}
    Input    ${cadUsu.inpEmail}    ${globalEmail}
    Input    ${cadUsu.inpPass}    ${globalPassword}

#Listar Usuários -------------------------------------------------------------------------------------------------------------------------------------
Find the account
    Sleep    1
    Scroll Element Into View    xpath=//tr[td[text() = '${globalname}']]

"${action}" account
    IF    $action == "Edit"
        Click    xpath=//tr[td[contains(., '${globalname}')] and td[contains(., 'true')]]//button[contains(@class, 'btn-info')]
    ELSE
        Click    xpath=//tr[td[contains(., '${globalname}')] and td[contains(., 'true')]]//button[contains(@class, 'btn btn-danger')]
        Sleep    3
    END
    

Account must be "${button}"
    IF    $button == "edited"
        Log    Unfortunately nothing happens when you click the edit button
    ELSE
        ${status}    Run Keyword And Return Status    Scroll Element Into View    xpath=//tr[td[text() = '${globalname}']]
        IF    $status == $False
            Log    Account deleted successfully
        END
    END

Click button register
    Click    ${cadProd.btCad}

#Cadastrar Produtos tab -------------------------------------------------------------------------------------------------------------------------------------
Alert message should appear
    Wait Until Element Is Visible    ${cadProd.msNoName}
    Wait Until Element Is Visible    ${cadProd.msNoPrice}
    Wait Until Element Is Visible    ${cadProd.msNoDesc}
    Wait Until Element Is Visible    ${cadProd.msNoQuant}

Fill product information with "${option}" "${category}"
    IF    $category == "price"
        Input    ${cadProd.nameProd}    Negative price
        ${price}    Set Variable    0
    ELSE
        ${price}    Set Variable    1
        Input    ${cadProd.nameProd}    Negative quantity
    END
    Input    ${cadProd.priceProd}    ${price}
    Input    ${cadProd.descProd}    ${category}
    IF    $category == "quantity"
        ${quantity}    Set Variable    -1
    ELSE
        ${quantity}    Set Variable    1
    END
    Input    ${cadProd.quantProd}    ${quantity} 

Message "${alert}" must be "${msgspan}" should be visible
    IF    $alert == "price"
        Wait Until Element Is Visible    ${cadProd.msPrice}
    ELSE
        Wait Until Element Is Visible    ${cadProd.msQuant}
    END

Fill product "${info}"
    Set Global Variable    ${globalInfo}    ${info}
    IF    $info == "information"
        Set Global Variable    ${prodNameInf}    Leozirton
        Set Global Variable    ${prodName}    ${prodNameInf}
        ${price}    Set Variable    1000000000000000
        ${quantity}    Set Variable    1
        Choose File    ${cadProd.choFil}     ${DATA_DIR}/robot.png
    ELSE IF    $info == "no quantity"
            Set Global Variable    ${prodNameNoQnt}    Don't buy this product
            Set Global Variable    ${prodName}    ${prodNameNoQnt}
            ${price}    Set Variable    1
            ${quantity}    Set Variable    0
            Choose File    ${cadProd.choFil}     ${DATA_DIR}/Selenium.png
    ELSE
        Set Global Variable    ${prodNameNoPic}    No picture
        Set Global Variable    ${prodName}    ${prodNameNoPic}
        ${price}    Set Variable    1
        ${quantity}    Set Variable    1
    END
    Input    ${cadProd.nameProd}    ${prodName}
    Input    ${cadProd.priceProd}    ${price}
    Input    ${cadProd.descProd}    Test Leo
    Input    ${cadProd.quantProd}    ${quantity}

Product must be on the list
    ${status}    Run Keyword And Return Status    Message that the product already exists should appear
    IF    $status == $True
        Be at "Listar Produtos" tab
        Sleep    1
        Scroll Element Into View    xpath=//tr[td[contains(text(), "${prodName}")]]
        Click    xpath=//td[text() = "${prodName}"]/following-sibling::td/div/button[@class = 'btn btn-danger']
        Sleep    1
        Be at "Cadastrar Produtos" tab
        Fill product "${globalInfo}"
        Click button register
    END
    Wait Until Element Is Visible    ${lisProd.titLis}
    Sleep    1
    Scroll Element Into View    xpath=//tr[td[contains(text(), "${prodName}")]]

Message that the product already exists should appear
    Sleep    1
    Element Should Be Visible    ${lisProd.msProdExis}

#Listar Produtos tab -------------------------------------------------------------------------------------------------------------------------------------
Find the product "${typeProd}"
    Sleep    1
    ${status}    Run Keyword And Return Status    Scroll Element Into View    xpath=//tr[td[contains(., "${typeProd}")]]
    IF    $status == $False
        Be at "Cadastrar Produtos" tab
        Fill product "${typeProd}"
        Click button register
    ELSE
        Scroll Element Into View    xpath=//tr[td[contains(., "${typeProd}")]]
    END

"${listAction}" the product "${typeProdList}"
    IF    $listAction == "Edit"
        Click    xpath=//td[text() = "${typeProdList}"]/following-sibling::td/div/button[@class = 'btn btn-info']
    ELSE
        Click    xpath=//td[text() = "${typeProdList}"]/following-sibling::td/div/button[@class = 'btn btn-danger']
    END

Product must be "${listMsg}"
    IF    $listMsg == "edited"
        Log    Unfortunately nothing happens when you click the edit button
    ELSE
        ${status}    Run Keyword And Return Status    Scroll Element Into View    xpath=//tr[td[contains(text(), "${prodNameNoPic}")]]
        IF    $status == $False
            Log    Account deleted successfully
        END
    END
