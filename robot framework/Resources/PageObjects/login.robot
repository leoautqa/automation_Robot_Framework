*** Settings ***
Library     FakerLibrary    locale=en_US
Library     OperatingSystem
Library     String
Library     Screenshot
Library     BuiltIn
Library     DateTime
Resource    ../Main.robot
Resource    ../Comum.robot
Resource    ../Locators/login.robot

*** Keywords ***
Website loaded
    Loading
    Wait Until Element Is Visible    ${login.h1Login}
    Wait Until Element Is Visible    ${login.inputEmail}
    Wait Until Element Is Visible    ${login.inputPassword}
    Wait Until Element Is Visible    ${login.butEnter}

Submit login
    Click    ${login.butEnter}

Mandatory email and password messages
    Wait Until Element Is Visible    ${login.mandatoryEmail}
    Wait Until Element Is Visible    ${login.mandatoryPassword}

Report invalid data
    Input    ${login.inputEmail}    invalid@test.com
    Input    ${login.inputPassword}    invalid

Invalid email and password message
    Wait Until Element Is Visible    ${login.messageInvalid}

Register an new account
    Click    ${login.register}

Send registration
    Click    ${login.btRegistration}

Mandatory message
    Wait Until Element Is Visible    ${login.mandatoryName}
    Wait Until Element Is Visible    ${login.mandatoryEmail}
    Wait Until Element Is Visible    ${login.mandatoryPassword}

Fill in valid data
    ${name}    FakerLibrary.Name
    Set Global Variable    ${globalname}    ${name}
    Input    ${login.userName}    ${globalname}
    ${email}    FakerLibrary.Email
    Set Global Variable    ${globalEmail}    ${email}
    Input    ${login.userEmail}    ${globalEmail}
    ${password}    FakerLibrary.Password
    Set Global Variable    ${globalPassword}    ${password}
    Input    ${login.userPassword}    ${globalPassword}

Successful registration message
    Wait Until Element Is Visible    ${login.successfulMessage}

Fill in data that already exists
    Input    ${login.userName}    ${globalname}
    Input    ${login.userEmail}    ${globalEmail}
    Input    ${login.userPassword}    ${globalPassword}

Message this account already exists
    Wait Until Element Is Visible    ${login.MessageAlreadyExists}

Fill in an administrator account
    ${name}    FakerLibrary.Name
    Input    ${login.userName}    ${name}
    ${email}    FakerLibrary.Email
    Input    ${login.userEmail}    ${email}
    ${password}    FakerLibrary.Password
    Input    ${login.userPassword}    ${password}
    Click    ${login.checkbox}

# Fill in first name
#     ${number}    Evaluate   random.randint(1, 2)
#     Set Global Variable    ${random_number}    ${number}
#     IF    ${random_number} == 1
#         ${firstName}    FakerLibrary.First Name Female
#     ELSE
#         ${firstName}    FakerLibrary.First Name Male
#     END
#     Input    ${autDemSit.firstName}    ${firstName}

# Fill in last name
#     ${lastName}    FakerLibrary.lastName
#     Input    ${autDemSit.lastName}    ${lastName}

# Fill in full name
#     Fill in first name
#     Fill in last name

# Fill in address
#     ${address}    FakerLibrary.Address
#     Input    ${autDemSit.address}    ${address}

# Fill in email
#     ${email}    FakerLibrary.Email
#     Input    ${autDemSit.email}    ${email}

# Fill in phone
#     ${phone} =    Evaluate    random.randint(1000000000, 9999999999)
#     Input    ${autDemSit.phone}    ${phone}

# Select a gender
#     IF    ${random_number} == 1
#         Click    ${autDemSit.female} 
#     ELSE
#         Click    ${autDemSit.male} 
#     END    

# Select a hobbie
#     ${random_number}    Evaluate   random.randint(1, 3)
#     IF    ${random_number} == 1
#         Click    ${autDemSit.cricket} 
#     ELSE
#         IF    ${random_number} == 2
#             Click    ${autDemSit.movies} 
#         ELSE
#             Click    ${autDemSit.hockey} 
#         END
#     END    

# Scroll Page
#     Scroll Element Into View    ${autDemSit.baseboard}

# Select a languages 
#     Click    ${autDemSit.languages}
#     Click    ${autDemSit.english}
#     Click    ${autDemSit.out}

# Upload a file
#     Choose File    ${autDemSit.file}     ${DATA_DIR}/robot.png
#     Capture Page Screenshot

# Select skills
#     Select From List By Value    ${autDemSit.selSkill}    Python

# Select country
#     Select From List By Value    ${autDemSit.selCountry}    United States of America

# Birth "Majority age"
    
#     ${values_year} =    Get List Items    ${autDemSit.year}
#     ${lowest_Year} =    Set Variable    ${values_year}[1]
    
#     ${biggest_Year} =    Evaluate    datetime.datetime.now().year - 18
#     ${random_Year} =    Evaluate    random.randint(${lowest_Year}, ${biggest_Year})

#     Select From List By Value    ${autDemSit.year}    ${random_Year}

#     ${current_Month} =    Evaluate    datetime.datetime.now().month
#     ${random_Month} =    Evaluate    random.randint(1, ${current_Month})

#     ${string_Month} =    Evaluate    calendar.month_name[${random_Month}]
    
#     Select From List By Value    ${autDemSit.month}     ${string_Month}

#     ${current_Day} =    Evaluate    datetime.datetime.now().day
#     ${random_Day} =    Evaluate    random.randint(1, ${current_Day})

#     Select From List By Value    ${autDemSit.day}    ${random_Day}
    
# Birth "Under age"
#     ${values_year} =    Get List Items    ${autDemSit.year}
#     ${biggest_Year} =    Set Variable    ${values_year}[-1]

#     ${lowest_Year} =    Evaluate    datetime.datetime.now().year - 18
#     ${random_Year} =    Evaluate    random.randint(${lowest_Year}, ${biggest_Year})

#     Select From List By Value    ${autDemSit.year}    ${random_Year}

#     ${random_Month} =    Evaluate    random.randint(1, 12)

#     ${string_Month} =    Evaluate    calendar.month_name[${random_Month}]
    
#     Select From List By Value    ${autDemSit.month}     ${string_Month}

#     ${current_Day} =    Evaluate    datetime.datetime.now().day - 1
#     ${random_Day} =    Evaluate    random.randint(1, ${current_Day})

#     Select From List By Value    ${autDemSit.day}    ${random_Day}

# Create password
#     ${password}    FakerLibrary.Password
#     Input    ${autDemSit.passwordOne}    ${password}
#     Input    ${autDemSit.passwordTwo}    ${password}

# Submit
#     Scroll Element Into View    ${autDemSit.submit}
#     Sleep    1
#     Click    ${autDemSit.out}
#     Press Keys    None    END
#     Sleep    1
#     Click    ${autDemSit.submit}

# Refreash
#     Scroll Element Into View    ${autDemSit.refreash}
#     Sleep    1
#     Click    ${autDemSit.out}
#     Press Keys    None    END
#     Sleep    1
#     Click Button    ${autDemSit.refreash}

# Fill the form - as "${typeOfBirth}"
#     Fill in full name
#     Fill in address
#     Fill in email
#     Fill in phone
#     Select a gender
#     Select a hobbie
#     Select a languages
#     Upload a file
#     Select skills
#     Select country
#     Run Keyword    Birth "${typeOfBirth}"
#     Scroll Page
#     Create password
    
# Success submit
#     Log    This scenario will fail because there's a bug on page web, specifically box Country*

# Complete non-mandatory fields
#     Fill in address
#     Select a hobbie
#     Select a languages
#     Upload a file
#     Select skills
#     Birth "Majority age"
#     Create password

# Message balom will appear
#     Sleep    2
#     Page Should Contain    Preencha este campo.

# All fields must be Empty
#     Element Should Be Visible    ${autDemSit.firstName}