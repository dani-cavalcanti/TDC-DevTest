*** Settings ***
Documentation     Caso de testes da Collection: authControler - Autentica um usuário cadastrado
Resource          ../../resources/services.robot


*** Test Cases ***
Authenticate User
    ${resp}=            Post Authenticate       malena@rocketqa.com        12$abr
    Status Should Be    200             ${resp}

