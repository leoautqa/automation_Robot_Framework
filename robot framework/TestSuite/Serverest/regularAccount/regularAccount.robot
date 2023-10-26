*** Settings ***
Resource        ../../../Resources/Main.robot
Resource        ../../../Resources/Comum.robot
Resource        ../../../Resources/PageObjects/regularAccount/regularAccount.robot
Suite Setup  Initiate browser
Suite Teardown  Terminate browser
Test Setup  Be logged in as "regular"
Test Teardown  Return to home

*** Test Case ***
#HOME tab----------------------------------------------------------------------------------
SCENARIO 01: Tab home
    [Tags]    ONE
    Given     On the "Home" tab
    When      Search for a product that doesn't exist
    And       Search
    Then      Show no results

SCENARIO 02: Detail product
    [Tags]    TWO
    Given     On the "Home" tab
    When      Search for a product
    And       Detail the product
    Then      Product's details must be visible

SCENARIO 03: Clear shopping list
    [Tags]    THREE
    Given     On the "Home" tab
    When      Search for a product
    And       Click "Adicionar a lista"
    When      Click "Limpar Lista"
    Then      Message "Seu carrinho está vazio" must be visible

SCENARIO 04: Shopping cart
    [Tags]    FOUR
    Given     On the "Home" tab
    When      Search for a product
    And       Click "Adicionar a lista"
    When      Click "Adicionar no carrinho"
    Then      Product must be on the Shopping cart