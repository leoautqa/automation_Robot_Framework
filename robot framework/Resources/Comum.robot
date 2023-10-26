*** Settings ***
Resource    Main.robot
Resource    Variables.robot
Resource    Locators/login.robot
Resource    PageObjects/login.robot

*** Keywords ***
Initiate browser
    [Arguments]    ${logado}=${False}
    ${DOWNLOAD_DIR}    Set Variable    ${CURDIR}${/}downloads
    ${status}  Run Keyword And Return Status    Directory Should Exist    ${DOWNLOAD_DIR}
    IF  not ${status}  Create Directory    ${DOWNLOAD_DIR}
    Set Global Variable    ${DOWNLOAD_DIR}
    ${prefs}    Create Dictionary    download.default_directory=${DOWNLOAD_DIR}    safebrowsing.enabled=false
    ${options}    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys

    Call Method    ${options}    add_argument    --disable-web-security
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-logging
    Call Method    ${options}    add_argument    --enable-automation
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-infobars
    Call Method    ${options}    add_argument    --disable-browser-side-navigation
    Call Method    ${options}    add_argument    --safebrowsing-disable-download-protection
    Call Method    ${options}    add_argument    --ignore-certificate-errors
    Call Method    ${options}    add_argument    --acceptSslCerts
    Call Method    ${options}    add_argument    --start-maximized
    Call Method    ${options}    add_argument    --aggressive-cache-discard
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${options}    add_argument    --headless

    ${name}    Evaluate    platform.system()    platform
    IF    $name.lower() == 'linux'
        Call Method    ${options}    add_argument    --window-size\=1920,1080
    END
    Call Method    ${options}    add_argument    --window-size\=1920,1080

    Open Browser    ${URL}    Chrome    options=${options}
    Set Selenium Timeout    ${TIMEOUT}

Terminate browser
    Capture Page Screenshot
    Close All Browsers

Search Loading
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='status']    10
    IF    ${status}
        Wait Until Element Is Not Visible    xpath=//div[@role='status']
    END

Wait Until Text Loading In Element
    [Arguments]    ${locator}    ${isText}=True    ${Attribute}=None    ${times}=10    ${time}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${time}
    FOR    ${i}    IN RANGE    0    ${times}
        IF    ${isText} == False and $Attribute is not None
            ${tx}    Get Element Attribute    ${locator}    ${attribute}
        ELSE
            ${tx}    Get Text    ${locator}
        END

        IF    len($tx) > 0            BREAK

        Sleep    1
    END
    Should Not Be Empty    ${tx}
    RETURN    ${tx}

Click
    [Arguments]    ${locator}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    IF    ${status}
        Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
        Click Element    ${locator}
    ELSE
        ${progress}    Run Keyword And Return Status    Wait Until Element Contains    ${locator}    ${TIMEOUT}
        IF    ${progress}
            Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
            Click Element    ${locator}
        END
    END

Click And Wait
    [Arguments]    ${locator}    ${locator2}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    IF    ${status}
        FOR    ${index}    IN RANGE    0    10
            Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
            Click Element    ${locator}
            ${status}    Run Keyword and Return Status    Wait Until Element Is Visible    ${locator2}    10
            IF    ${status}                BREAK
        END
    ELSE
        ${progress}    Run Keyword And Return Status    Wait Until Element Contains    ${locator}    ${TIMEOUT}
        IF    ${progress}
            FOR    ${index}    IN RANGE    0    10
                Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
                Click Element    ${locator}
                ${status}    Run Keyword and Return Status    Wait Until Element Is Visible    ${locator2}    10
                IF    ${status}                    BREAK
            END
        END
    END

Input
    [Arguments]    ${locator}    ${text}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    IF    ${status}
        Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
        Input Text    ${locator}    ${text}
    ELSE
        ${progress}    Run Keyword And Return Status    Wait Until Element Contains    ${locator}    ${TIMEOUT}
        IF    ${progress}
            Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
            Input Text    ${locator}    ${text}
        END
    END

Loading
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOADING}    5
    IF    ${status}    Wait Until Element Is Not Visible    ${LOADING}    120

Being On Screen
    Sleep    1
    Element Should Be Visible    ${login.h1Login}

Restart site
    Go To    ${URL}

Be logged in as "${account}"
    ${statusOne}  Run Keyword And Return Status    Being On Screen
    IF    $account == "admin" and $statusOne == $True
        Input    ${login.inputEmail}    ${adminUser}
        Input    ${login.inputPassword}    ${adminPass}
        Click    ${login.butEnter}
        Sleep    1
        ${statusTwo}  Run Keyword And Return Status    Element Should Be Visible    ${login.messageInvalid}
        IF    ${statusTwo}
            Run Keyword    Register an new account
            Input    ${login.userName}    ${adminName}
            Input    ${login.userEmail}    ${adminUser}
            Input    ${login.userPassword}    ${adminPass}
            Click    ${login.checkbox}
            Send registration   
        END
    END
    IF    $account == "regular" and $statusOne == $True
        Input    ${login.inputEmail}    ${regularUser}
        Input    ${login.inputPassword}    ${regularPass}
        Click    ${login.butEnter}
        Sleep    1
        ${statusTwo}  Run Keyword And Return Status    Element Should Be Visible    ${login.messageInvalid}
        IF    ${statusTwo}
            Run Keyword    Register an new account
            Input    ${login.userName}    ${regularName}
            Input    ${login.userEmail}    ${regularUser}
            Input    ${login.userPassword}    ${regularPass}
            Send registration   
        END
    END

Return to home
    Click    xpath=//a[contains(@data-testid,'home')]