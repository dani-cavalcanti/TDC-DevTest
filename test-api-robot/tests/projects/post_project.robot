*** Settings ***
Documentation     Caso de Teste da Collection: projectControler - Cadastra um novo projeto
Resource          ../../resources/services.robot

*** Test Cases ***
Create Project
    ${payload}=         Get Json    projects/unique.json

    Delete Project      ${payload['code']}

    ${resp}=            Post Create Project     ${payload}

    Status Should Be    201     ${resp}

