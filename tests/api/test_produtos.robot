*** Settings ***
Resource    ../../resources/api/produtos.resource
Resource    ../../resources/api/api_setup.resource
Library     FakerLibrary
Suite Setup     Create Users And Sessions

*** Test Cases ***
CT01 - Criar produto com sucesso
    ${produto}=    FakerLibrary.Word
    ${preco}=      FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=       Registrar Produto    ${ADMIN_TOKEN}    ${produto}    ${preco}    ${descricao}    ${quantidade}
    Should Be Equal As Integers    ${resp.status_code}    201


CT02 - Criar produto sem token (falha)
    ${produto}=    FakerLibrary.Word
    ${preco}=      FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=       Registrar Produto    ""    ${produto}    ${preco}    ${descricao}    ${quantidade}
    Should Be Equal As Integers    ${resp.status_code}    401
    Should Contain    ${resp.json()["message"]}    Token de acesso ausente 

CT03 - Consultar produto existente
    ${PRODUCT_ID}=    Criar Produto Para Testes
    ${resp}=    Obter Produto Por Id    ${PRODUCT_ID}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Be Equal    ${resp.json()["_id"]}    ${PRODUCT_ID}

CT04 - Consultar produto inexistente (falha)
    ${resp}=    Obter Produto Por Id    0000000000000000
    Should Be Equal As Integers    ${resp.status_code}    400
    Should Contain    ${resp.json()["message"]}    Produto não encontrado

CT05 - Atualizar produto
    ${PRODUCT_ID}=    Criar Produto Para Testes
    ${novo_nome}=      FakerLibrary.Word
    ${novo_preco}=     FakerLibrary.Random Int
    ${novo_desc}=      FakerLibrary.Sentence
    ${novo_quantidade}=     FakerLibrary.Random Int
    ${resp}=           Atualizar Produto    ${ADMIN_TOKEN}    ${PRODUCT_ID}    name=${novo_nome}    price=${novo_preco}    desc=${novo_desc}    quantity=${novo_quantidade}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Registro alterado com sucesso


CT06 - Deletar produto existente
    #Cria o produto
    ${nome}=    FakerLibrary.Word
    ${preco}=      FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=       Registrar Produto    ${ADMIN_TOKEN}    ${nome}    ${preco}    ${descricao}    ${quantidade}
    ${id}=        Set Variable    ${resp.json()["_id"]}
    # Deleta o produto
    ${resp}=    Deletar Produto    ${ADMIN_TOKEN}    ${id}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Registro excluído com sucesso

CT07 - Deletar produto inexistente (falha)
    ${resp}=    Deletar Produto    ${ADMIN_TOKEN}    0000000000000000
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.json()["message"]}    Nenhum registro excluído


*** Keywords ***
Criar Produto Para Testes
    ${nome}=    FakerLibrary.Word
    ${preco}=   FakerLibrary.Random Int
    ${descricao}=  FakerLibrary.Sentence
    ${quantidade}=     FakerLibrary.Random Int
    ${resp}=    Registrar Produto    ${ADMIN_TOKEN}    ${nome}    ${preco}    ${descricao}    ${quantidade}
    ${id}=      Set Variable    ${resp.json()["_id"]}
    RETURN   ${id}