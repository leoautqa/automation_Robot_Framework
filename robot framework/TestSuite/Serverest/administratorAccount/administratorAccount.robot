*** Settings ***
Resource        ../../../Resources/Main.robot
Resource        ../../../Resources/Comum.robot
Resource        ../../../Resources/PageObjects/administratorAccount/administratorAccount.robot
Suite Setup  Initiate browser
Suite Teardown  Terminate browser
Test Setup  Be logged in as "admin"
Test Teardown  Return to home

*** Test Case ***
#HOME tab----------------------------------------------------------------------------------
SCENARIO 01: Tab home
    [Tags]    ONE
    Given     Be at "Home" tab
    Then      Page must load correctly

#Cadastrar Usuários tab----------------------------------------------------------------------
SCENARIO 02: Create an account with out data
    [Tags]    TWO
    Given     Be at "Cadastrar Usuários" tab
    When      Do the registration
    Then      Message "alert register" on Register Users

SCENARIO 03: Create a regular account
    [Tags]    THREE
    Given     Be at "Cadastrar Usuários" tab
    When      Complete "Regular" registration
    And       Do the registration
    Then      "Regular" registration must be on the list

SCENARIO 04: Create an account that already exists
    [Tags]    FOUR
    Given     Be at "Cadastrar Usuários" tab
    When      Complete registration already exists
    And       Do the registration
    Then      Message "stating that this account already exists" on Register Users

SCENARIO 05: Create an administrator account
    [Tags]    FIVE
    Given     Be at "Cadastrar Usuários" tab
    When      Complete "Administrator" registration 
    And       Do the registration
    Then      "Administrator" registration must be on the list

#Listar Usuários tab----------------------------------------------------------------------
SCENARIO 06: Edit an account
    [Tags]    SIX
    Given     Be at "Listar Usuários" tab
    And       Find the account 
    When      "Edit" account
    Then      Account must be "edited"

SCENARIO 07: Delete an account
    [Tags]    SEVEN
    Given     Be at "Listar Usuários" tab
    And       Find the account 
    When      "Delete" account
    Then      Account must be "deleted"

#Cadastrar Produtos tab----------------------------------------------------------------------
SCENARIO 08: Create a product with no data
    [Tags]    EIGHT
    Given     Be at "Cadastrar Produtos" tab
    When      Click button register
    Then      Alert message should appear

SCENARIO 09: Register a product with a zero price
    [Tags]    NINE
    Given     Be at "Cadastrar Produtos" tab
    When      Fill product information with "zero" "price"
    And       Click button register
    Then      Message "price" must be "positive" should be visible

SCENARIO 10: Register a product with a negative quantity
    [Tags]    TEN
    Given     Be at "Cadastrar Produtos" tab
    When      Fill product information with "negative" "quantity"
    And       Click button register
    Then      Message "quantity" must be "more or equal than zero" should be visible

SCENARIO 11: Register a product
    [Tags]    ELEVEN
    Given     Be at "Cadastrar Produtos" tab
    When      Fill product "information"
    And       Click button register
    Then      Product must be on the list

SCENARIO 12: Register a product with no quantity
    [Tags]    TWELVE
    Given     Be at "Cadastrar Produtos" tab
    When      Fill product "no quantity"
    And       Click button register
    Then      Product must be on the list

SCENARIO 13: Register a product with no picture
    [Tags]    THIRTEEN
    Given     Be at "Cadastrar Produtos" tab
    When      Fill product "no picture"
    And       Click button register
    Then      Product must be on the list

SCENARIO 14: Register a product that already exists
    [Tags]    FOURTEEN
    Given     Be at "Cadastrar Produtos" tab
    When      Fill product "no quantity"
    And       Click button register
    Then      Message that the product already exists should appear

#Listar Produtos tab----------------------------------------------------------------------
SCENARIO 15: Edit a product
    [Tags]    FIFTEEN
    Given     Be at "Listar Produtos" tab
    When      Find the product "No picture"
    And       "Edit" the product "No picture"
    Then      Product must be "edited"

SCENARIO 16: Delete a product
    [Tags]    SISTEEN
    Given     Be at "Listar Produtos" tab
    When      Find the product "No picture"
    And       "Delete" the product "No picture"
    Then      Product must be "deleted"