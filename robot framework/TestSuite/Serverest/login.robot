*** Settings ***
Resource        ../../Resources/Main.robot
Resource        ../../Resources/Comum.robot
Resource        ../../Resources/PageObjects/login.robot
Suite Setup  Initiate browser
Suite Teardown  Terminate browser
Test Setup  Being On Screen
Test Teardown  Restart site

*** Test Case ***
SCENARIO 01: Login with out E-mail and password
    [Tags]    ONE
    Given     Website loaded
    When      Submit login
    Then      Mandatory email and password messages

SCENARIO 02: Login with invalid E-mail and password
    [Tags]    TWO
    Given     Website loaded
    When      Report invalid data
    And       Submit login
    Then      Invalid email and password message

SCENARIO 03: Create an account with out data
    [Tags]    THREE
    Given     Website loaded
    When      Register an new account
    And       Send registration
    Then      Mandatory message

SCENARIO 04: Create an account
    [Tags]    FOUR
    Given     Website loaded
    When      Register an new account
    And       Fill in valid data
    When      Send registration
    Then      Successful registration message

#This scenario depends on the previous one
SCENARIO 05: Create an account that already exists
    [Tags]    FIVE
    Given     Website loaded
    When      Register an new account
    And       Fill in data that already exists
    When      Send registration
    Then      Message this account already exists

SCENARIO 06: Create an administrator account
    [Tags]    SIX
    Given     Website loaded
    When      Register an new account
    And       Fill in an administrator account
    When      Send registration
    Then      Successful registration message