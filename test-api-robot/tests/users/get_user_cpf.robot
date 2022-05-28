*** Settings ***
Documentation     Caso de Teste da Collection: authControler - Lista um usuário cadastrado buscando pelo seu CPF
Resource          ../../resources/services.robot

*** Test Cases ***
Get Show User 
    
    ${origin}=          Get Json    users/unique.json
    
    Delete User         ${origin['cpf']}
    ${resp}=            Post Register                    ${origin}
    ${user_cpf}=        Set Variable                     ${resp.json()['user']['cpf']}


    ${resp}=            Get User CPF        ${user_cpf}
    
    Status Should Be        200                                    ${resp}
   