*** Settings ***
Library           SeleniumLibrary

*** Variables ***

# Locators
${CAMPO_PESQUISAR}     css=[data-testid="pesquisar"] 
${BOTAO_PESQUISAR}    css=[data-testid="botaoPesquisar"]
${BOTAO_ADICIONAR_LISTA}    css=[data-testid="adicionarNaLista"]
${BOTAO_LIMPAR_LISTA}    css=[data-testid="limparLista"]

*** Keywords ***
Pesquisar Produto
    [Documentation]    Pesquisa um produto pelo nome.
    [Arguments]    ${produto}
    Input Text    ${CAMPO_PESQUISAR}    ${produto}
    Click Button    ${BOTAO_PESQUISAR}

Adicionar Produto ao Carrinho
    [Documentation]    Adiciona um produto ao carrinho.
    [Arguments]    ${produto}
    Pesquisar Produto    ${produto}
    Wait Until Page Contains Element    ${BOTAO_ADICIONAR_LISTA}    timeout=10
    Click Button    ${BOTAO_ADICIONAR_LISTA}

Limpar Lista de Compras
    [Documentation]    Limpa a lista de compras.
    Wait Until Page Contains Element    ${BOTAO_LIMPAR_LISTA}    timeout=10
    Click Button    ${BOTAO_LIMPAR_LISTA}