*** Settings ***
Documentation     Caso de Teste da Collection: projectControler - Lista todos os projetos cadastrados
Resource          ../../resources/services.robot

*** Test Cases ***
Get Project List
    ${list}=            Get Json        projects/list.json

    FOR         ${item}     IN      @{list['data']}
        Post Create Project  ${item}
    END
    
    
    ${resp}=                Get Projects        
    Status Should Be        200         ${resp}
