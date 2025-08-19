*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary


*** Keywords ***
Registrar Usuário
    [Documentation]    Registra um novo usuário no sistema.
    [Arguments]    ${name}    ${email}    ${password}    ${admin}=false
    ${body}=    Create Dictionary    nome=${name}    email=${email}    password=${password}    administrador=${admin}
    ${resp}=    POST On Session    api    /usuarios    json=${body}    expected_status=anything
    RETURN    ${resp}

Logar Usuário
    [Documentation]    Realiza o login de um usuário e retorna o token de autenticação.
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${resp}=    POST On Session    api    /login    json=${body}    expected_status=anything
    RETURN    ${resp}

Atualizar Usuário
    [Documentation]    Atualiza os detalhes de um usuário existente.
    [Arguments]    ${token}    ${user_id}    ${name}    ${email}    ${password}    ${admin}
    ${body}=    Create Dictionary
    ${name}    Set To Dictionary    ${body}    nome=${name}
    ${email}    Set To Dictionary    ${body}    email=${email}
    ${password}    Set To Dictionary    ${body}    password=${password}
    ${admin}    Set To Dictionary    ${body}    administrador=${admin}
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}=    PUT On Session    api    /usuarios/${user_id}    headers=${headers}    json=${body}    expected_status=200
    RETURN    ${resp}

