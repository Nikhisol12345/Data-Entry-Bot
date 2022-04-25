# +
*** Settings ***
Documentation   Do the data entry process by extracting the details from the excel file
Library         RPA.Browser



Library         RPA.HTTP
Library         RPA.Excel.Files
# -


***keywords***
Open the rpa challege website
    Open Available Browser  http://rpachallenge.com/
    Maximize Browser Window

***keywords***
Download the excel report
    Download  http://rpachallenge.com/assets/downloadFiles/challenge.xlsx  ${CURDIR}${/}challenge.xlsx  overwrite=True

***keywords***
Fill data for one person
    [Arguments]  ${data}
    Input Text    //input[@ng-reflect-name="labelFirstName"]  ${data}[First Name]
    Input Text    //input[@ng-reflect-name="labelLastName"]  ${data}[Last Name]
    Input Text    //input[@ng-reflect-name="labelCompanyName"]  ${data}[Company Name]
    Input Text    //input[@ng-reflect-name="labelRole"]  ${data}[Role in Company]
    Input Text    //input[@ng-reflect-name="labelAddress"]  ${data}[Address]
    Input Text    //input[@ng-reflect-name="labelEmail"]  ${data}[Email]
    Input Text    //input[@ng-reflect-name="labelPhone"]  ${data}[Phone Number]
    Click Button  //input[@type="submit"]


***keywords***
 Do the data entry operation by reading the excel file
     Open Workbook  ${CURDIR}${/}challenge.xlsx
     ${table}=  Read Worksheet As Table  Sheet1  header=True
     Close Workbook
     Click Button  //button[@class="waves-effect col s12 m12 l12 btn-large uiColorButton"]
     FOR  ${DATA}  IN  @{table}
     Fill data for one person  ${data}
     END


***keywords***
Take the screenshot of result
    Screenshot  //div[@class="message2"]  ${CURDIR}${/}result.png

***keywords***
Close the rpa callenge website
    Close Browser


*** Tasks ***
Data entry Process
    Open the rpa challege website
    Download the excel report
    Do the data entry operation by reading the excel file
    Take the screenshot of result
    Close the rpa callenge website
