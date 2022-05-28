*** Settings ***
Documentation      Caso de Teste da Collection: authControler - Cadastra um novo usuário
Resource          ../../resources/services.robot


*** Test Cases ***
Register User
   ${payload}=          Get Json   users/unique.json

   Delete User          ${payload['cpf']} 

   ${resp}=             Post Register    ${payload}
   
   Status Should Be     201      ${resp}



