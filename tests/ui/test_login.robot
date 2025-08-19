*** Settings ***
Resource           ../../resources/ui/login.resource

*** Variables ***

${VALID_USER}     brandofdnmedina@example.com
${VALID_PASS}     fasdfasfdas
${INVALID_USER}   usuario_invalido@test.com
${INVALID_PASS}   senha_invalida

*** Test Cases ***
CT01-Logar com Credenciais Válidas

    [Documentation]    Testa o login com credenciais válidas
    Logar no Serverest    ${VALID_USER}    ${VALID_PASS}

CT02-Logar com Credenciais Inválidas
    [Documentation]    Testa o login com credenciais inválidas
    Logar no Serverest    ${INVALID_USER}    ${INVALID_PASS}
