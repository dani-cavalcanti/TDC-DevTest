*** Settings ***
Documentation     Caso de Teste da Collection: authControler - Lista todos os usuários cadastrados
Resource          ../../resources/services.robot

*** Test Cases ***

Get Users List

    ${list}=            Get Json        users/list.json

    FOR         ${item}     IN      @{list['users']}
        
        Post Register   ${item}
    END

    ${resp}=                Get Users     
    Status Should Be        200             ${resp}
