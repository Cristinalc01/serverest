*** Settings ***
Resource           ../../resources/ui/login.resource
Resource           ../../resources/ui/produtos.resource
Resource           ../../resources/api/usuarios.resource
Resource           ../../resources/api/api_setup.resource
Suite Setup       Criar Usuários e Sessões
Test Teardown    Close All Browsers

*** Variables ***

${produto}   Logitech MX Vertical


*** Test Cases ***
CT01-Colocar Produto na Lista de Compras
    [Documentation]    Testa a adição de um produto à lista de compras.
    Logar no Serverest    ${USER_EMAIL}    ${USER_PASSWORD}
    Adicionar Produto ao Carrinho    ${produto}
    Page Should Contain    Lista de Compras
    Page Should Contain    ${produto}

CT02-Limpar Lista de Compras
    [Documentation]    Testa a limpeza da lista de compras.
    Logar no Serverest    ${USER_EMAIL}    ${USER_PASSWORD}
    Adicionar Produto ao Carrinho    ${produto}
    Limpar Lista de Compras
    Page Should Not Contain    ${produto}
    Page Should Contain    Seu carrinho está vazio
