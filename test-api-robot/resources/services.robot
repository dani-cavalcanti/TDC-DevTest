***Settings***
Documentation       Camada de serviços do projeto de automação

Library             RequestsLibrary
Library             Collections
Resource            helpers.robot

***Variables***
${base_url_api}      http://localhost:1302

***Keywords***
## Helpers
Conectar API
    Create Session          rocketqa-api        ${base_url_api}

Get Session Token
      ${resp}=      Post Authenticate           malena@rocketqa.com        12$abr

      ${token}      Convert To String           Bearer ${resp.json()['token']}

      [Return]      ${token}


## POST /register
Post Register
    [Arguments]     ${payload}

    Conectar API
   
    &{headers}=             Create Dictionary       Content-type=application/json 
    
    ${resp}=                POST On Session     rocketqa-api        /auth/register       
    ...                     json=${payload}         headers=${headers}

    [Return]       ${resp}  


## POST /authenticate
Post Authenticate
    [Arguments]     ${email}        ${password}

    Conectar API

    &{headers}=             Create Dictionary       Content-type=application/json
    &{payload}=             Create Dictionary       email=${email}      password=${password}    

    ${resp}=            POST On Session         rocketqa-api        /auth/authenticate      
    ...                 json=${payload}         headers=${headers}

    [Return]        ${resp}


##GET/ user
Get Users
    Conectar API  

    &{headers}=             Create Dictionary       Content-type=application/json

    ${resp}=                GET On Session          rocketqa-api        /auth/users         headers=${headers}

    [Return]        ${resp}

Get User CPF
    [Arguments]             ${cpf}

    Conectar API

    &{headers}=             Create Dictionary       Content-type=application/json

    ${resp}=                GET On Session          rocketqa-api        /auth/users/${cpf}         headers=${headers}

    [Return]        ${resp}

##DELETE /user
Delete User
    [Arguments]     ${cpf}

    Conectar API

    &{headers}=            Create Dictionary       Content-Type=application/json       

    DELETE On Session      rocketqa-api        /auth/users/${cpf}         headers=${headers}



### Projects ###

## POST /projects
Post Create Project
    [Arguments]     ${payload}

    Conectar API

    ${token}=               Get Session Token
    &{headers}=             Create Dictionary       Content-type=application/json       Authorization=${token}

    ${resp}=                POST On Session     rocketqa-api        /projects      json=${payload}         headers=${headers}

    [Return]       ${resp} 

## GET /projects
Get Projects
    Conectar API

    ${token}=               Get Session Token
    &{headers}=             Create Dictionary       Content-type=application/json       Authorization=${token}

    ${resp}=                GET On Session     rocketqa-api        /projects      headers=${headers}

    [Return]       ${resp}

Get Unique Project
    [Arguments]     ${code}

    Conectar API

    ${token}=               Get Session Token
    &{headers}=             Create Dictionary       Content-type=application/json       Authorization=${token}
    
    ${resp}=                GET On Session          rocketqa-api        /projects/${code}         headers=${headers}


## PUT /projects
Put Project
    [Arguments]         ${payload}          ${code}

    Conectar API

    ${token}=               Get Session Token
    &{headers}=             Create Dictionary       Content-type=application/json       Authorization=${token}     

    ${resp}=                PUT On Session      rocketqa-api        /projects/${code}       json=${payload}         headers=${headers}


## DELETE /projects
Delete Project
    [Arguments]     ${code}

    ${token}=         Get Session Token
    &{headers}=       Create Dictionary       Content-Type=application/json     Authorization=${token}  

    DELETE On Session      rocketqa-api        /projects/${code}         headers=${headers}