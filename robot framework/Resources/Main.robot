*** Settings ***
Library  SeleniumLibrary
Library  FakerLibrary  locale=PT_BR
Library  DebugLibrary
Library  String
Library  Collections
Library  DateTime
Library  OperatingSystem
Library  Pdf2TextLibrary
Library  RequestsLibrary
Library  ./libs/utilities.py

Resource  ./Comum.robot
Resource  ./Variables.robot
Resource  ./BDDpt-BR.robot

# Home Page
Resource  Comum.robot

*** Variables ***
${LOCATORS_DIR}   ${CURDIR}/Locators
${RESOURCES_DIR}  ${CURDIR}/PageObjects
${DATA_DIR}       ${CURDIR}/data