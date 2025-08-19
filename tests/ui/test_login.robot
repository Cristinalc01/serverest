*** Settings ***
Resource           ../../resources/ui/login.resource
Resource           ../../resources/api/usuarios.resource
Resource           ../../resources/api/api_setup.resource
Suite Setup       Criar Usuários e Sessões
Test Teardown    Close All Browsers

*** Variables ***

${INVALID_USER}   usuario_invalido@test.com
${INVALID_PASS}   senha_invalida

*** Test Cases ***
CT01-Logar com Credenciais Válidas
    [Documentation]    Testa o login com credenciais válidas
    Logar no Serverest    ${USER_EMAIL}    ${USER_PASSWORD}

CT02-Logar com Credenciais Inválidas
    [Documentation]    Testa login com credenciais inválidas e valida mensagem de erro.
    Logar no Serverest    ${INVALID_USER}    ${INVALID_PASS}    False
CT03-Deslogar
    [Documentation]    Testa o logout do usuário.
    Logar no Serverest    ${INVALID_USER}    ${INVALID_PASS}    False
    Deslogar do Serverest