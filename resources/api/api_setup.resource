*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary
Library    Collections
Resource    ./usuarios.resource

*** Variables ***
${BASE_API}    https://serverest.dev

*** Keywords ***
Criar Usuários e Sessões
    [Documentation]    Cria usuários comuns e admin para testes, inicializando sessões e armazenando tokens e dados em variáveis de suíte.
    Create Session    api    ${BASE_API}
    # Usuário comum
    ${user_firstname}=    FakerLibrary.First Name
    ${user_email}=    FakerLibrary.Email
    ${user_password}=    FakerLibrary.Password
    ${user}=          Registrar Usuário    ${user_firstname}    ${user_email}    ${user_password}
    ${user_id}=           Set Variable    ${user.json()["_id"]}
    ${user_token}=         Logar Usuário       ${user_email}    ${user_password}
    ${user_token}=    Set Variable    ${user_token.json()["authorization"]}
    Set Suite Variable    ${USER_TOKEN}    ${user_token} 
    Set Suite Variable    ${USER_ID}    ${user_id}
    Set Suite Variable    ${USER_EMAIL}    ${user_email}
    Set Suite Variable    ${USER_PASSWORD}    ${user_password}
    # Usuário admin
    ${admin_firstname}=    FakerLibrary.First Name
    ${admin_email}=    FakerLibrary.Email
    ${admin_password}=    FakerLibrary.Password
    ${admin}=          Registrar Usuário    ${admin_firstname}    ${admin_email}    ${admin_password}    true
    ${admin_token}=         Logar Usuário       ${admin_email}    ${admin_password}
    ${admin_token}=    Set Variable    ${admin_token.json()["authorization"]}
    Set Suite Variable    ${ADMIN_TOKEN}    ${admin_token}  
