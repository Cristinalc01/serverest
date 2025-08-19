*** Settings ***
Resource    ../../resources/api/usuarios.resource
Resource    ../../resources/api/api_setup.resource
Library     FakerLibrary
Suite Setup     Criar Usuários e Sessões


*** Test Cases ***

CT01 - Criar usuário com sucesso
    ${nome}=    FakerLibrary.First Name
    ${email}=   FakerLibrary.Email
    ${password}=   FakerLibrary.Password
    ${resp}=    Registrar Usuário   ${nome}    ${email}    ${password}
    Should Be Equal As Integers    ${resp.status_code}    201
    Dictionary Should Contain Key    ${resp.json()}    _id

CT02 - Criar usuário já existente (falha)
    ${nome}=    FakerLibrary.First Name
    ${email}=   FakerLibrary.Email
    ${password}=    FakerLibrary.Password
    # Cria o usuário pela primeira vez
    ${resp}=    Registrar Usuário    ${nome}    ${email}    ${password}
    Should Be Equal As Integers    ${resp.status_code}    201
    # Tenta criar novamente com os mesmos dados
    ${resp2}=   Registrar Usuário    ${nome}    ${email}    ${password}
    Should Be Equal As Integers    ${resp2.status_code}    400
    Should Contain    ${resp2.json()["message"]}    Este email já está sendo usado


CT03 - Login com sucesso
    ${resp}=    Logar Usuário   ${USER_EMAIL}    ${USER_PASSWORD}
    Should Be Equal As Integers    ${resp.status_code}    200
    ${token}=    Set Variable    ${resp.json()["authorization"]}
    Set Suite Variable    ${TOKEN}    ${token}

CT04 - Login inválido (falha)
    ${resp}=    Logar Usuário   fake@teste.com    0000
    Should Be Equal As Integers    ${resp.status_code}    401
    Should Contain    ${resp.json()["message"]}    Email e/ou senha inválidos

CT05 - Atualizar usuário
    ${user_id}=    Set Variable    ${USER_ID}
    ${novo_nome}=    FakerLibrary.First Name
    ${novo_email}=   FakerLibrary.Email
    ${resp}=    Atualizar Usuário    ${USER_TOKEN}    ${user_id}    ${novo_nome}    ${novo_email}    ${USER_PASSWORD}    false
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Registro alterado com sucesso


