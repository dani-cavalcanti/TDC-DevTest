*** Settings ***
Documentation     Caso de Teste da Collection: projectControler - Lista um projeto cadastrado pelo seu code
Resource          ../../resources/services.robot

*** Test Cases ***
Get Show Project 
    
    ${origin}=          Get Json    projects/unique.json
    
    Delete Project              ${origin['code']}
    ${resp}=                    Post Create Project     ${origin}

    ${projectcode}=             Convert To String        ${resp.json()['project']['code']}


    ${resp}=                Get Unique Project      ${projectcode}
    
    Status Should Be        200                             ${resp}
   
