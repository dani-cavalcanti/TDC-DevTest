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

Get Show User 
    
    ${origin}=          Get Json    users/unique.json
    
    Delete User         ${origin['cpf']}
    ${resp}=            Post Register                    ${origin}
    ${user_cpf}=        Set Variable                     ${resp.json()['user']['cpf']}


    ${resp}=            Get User CPF        ${user_cpf}
    
    Status Should Be        200                                    ${resp}
   
