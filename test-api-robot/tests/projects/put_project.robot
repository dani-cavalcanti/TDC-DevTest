*** Settings ***
Documentation     Caso de Teste da Collection: projectControler - Atualiza um projeto cadastrado pelo seu code
Resource          ../../resources/services.robot

*** Test Cases ***

Update a Project

    ${payload}=                 Get Json                projects/unique.json
    ${update}=                  Get Json                projects/update.json

    Delete Project              ${payload['code']}
    ${resp}=                    Post Create Project     ${payload}

    ${projectcode}=             Convert To String        ${resp.json()['project']['code']}

    Set To Dictionary           ${update}              [tasks]        ${payload}

    ${resp}=                    Put Project             ${payload}          ${projectcode}

    Status Should Be            200                     ${resp}







