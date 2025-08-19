*** Settings ***
Resource    ../../resources/api/produtos.resource
Resource    ../../resources/api/api_setup.resource
Library     FakerLibrary
Suite Setup     Criar Usuários e Sessões

*** Test Cases ***
CT01 - Criar produto com sucesso
    [Documentation]    Valida que um produto pode ser criado com todos os campos válidos e retorna status 201.
    ${produto}=    FakerLibrary.Word
    ${preco}=      FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=       Registrar Produto    ${ADMIN_TOKEN}    ${produto}    ${preco}    ${descricao}    ${quantidade}
    Should Be Equal As Integers    ${resp.status_code}    201


CT02 - Criar produto sem token (falha)
    [Documentation]    Verifica que tentar criar um produto sem token retorna status 401 e mensagem de token ausente.
    ${produto}=    FakerLibrary.Word
    ${preco}=      FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=       Registrar Produto    ""    ${produto}    ${preco}    ${descricao}    ${quantidade}
    Should Be Equal As Integers    ${resp.status_code}    401
    Should Contain    ${resp.json()["message"]}    Token de acesso ausente 

CT03 - Consultar produto existente
    [Documentation]    Valida que é possível consultar um produto existente e retorna status 200.
    ${PRODUCT_ID}=    Criar Produto Para Testes
    ${resp}=    Obter Produto Por Id    ${PRODUCT_ID}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Be Equal    ${resp.json()["_id"]}    ${PRODUCT_ID}

CT04 - Consultar produto inexistente (falha)
    [Documentation]    Valida que consultar um produto inexistente retorna status 400 e mensagem de produto não encontrado.
    ${resp}=    Obter Produto Por Id    0000000000000000
    Should Be Equal As Integers    ${resp.status_code}    400
    Should Contain    ${resp.json()["message"]}    Produto não encontrado

CT05 - Atualizar produto
    [Documentation]    Testa a atualização de um produto existente e valida mensagem de sucesso e status 200.
    ${PRODUCT_ID}=    Criar Produto Para Testes
    ${novo_nome}=      FakerLibrary.Word
    ${novo_preco}=     FakerLibrary.Random Int
    ${novo_desc}=      FakerLibrary.Sentence
    ${novo_quantidade}=     FakerLibrary.Random Int
    ${resp}=           Atualizar Produto    ${ADMIN_TOKEN}    ${PRODUCT_ID}    name=${novo_nome}    price=${novo_preco}    desc=${novo_desc}    quantity=${novo_quantidade}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Registro alterado com sucesso


CT06 - Deletar produto existente
    [Documentation]    Garante que um produto existente pode ser deletado e retorna status 200 com mensagem de confirmação.
    ${PRODUCT_ID}=    Criar Produto Para Testes
    # Deleta o produto
    ${resp}=    Deletar Produto    ${ADMIN_TOKEN}    ${PRODUCT_ID}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Registro excluído com sucesso

CT07 - Deletar produto inexistente (falha)
    [Documentation]    Valida que tentar deletar um produto inexistente retorna status 200 e mensagem de nenhum registro excluído.
    ${resp}=    Deletar Produto    ${ADMIN_TOKEN}    0000000000000000
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Nenhum registro excluído


*** Keywords ***
Criar Produto Para Testes
    [Documentation]    Cria um produto para testes e retorna seu ID.
    ${nome}=    FakerLibrary.Word
    ${preco}=   FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=    Registrar Produto    ${ADMIN_TOKEN}    ${nome}    ${preco}    ${descricao}    ${quantidade}
    ${id}=      Set Variable    ${resp.json()["_id"]}
    RETURN   ${id}