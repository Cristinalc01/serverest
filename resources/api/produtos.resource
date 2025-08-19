*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary


*** Keywords ***

Registrar Produto
    #
    [Documentation]    Registra um novo produto no sistema.
    [Arguments]    ${token}    ${name}    ${price}    ${desc}    ${quantity}
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    nome=${name}    preco=${price}    descricao=${desc}    quantidade=${quantity}
    ${resp}=    POST On Session    api    /produtos    headers=${headers}    json=${body}    expected_status=anything
    RETURN    ${resp}

Obter Produto Por Id
    [Documentation]    Obtém os detalhes de um produto pelo seu ID.
    [Arguments]    ${id}
    ${resp}=    GET On Session    api    /produtos/${id}    expected_status=anything
    RETURN    ${resp}

Atualizar Produto
    [Documentation]    Atualiza os detalhes de um produto existente.
    [Arguments]    ${token}    ${product_id}    ${name}=None    ${price}=None    ${desc}=None    ${quantity}=None
    ${body}=    Create Dictionary
    Run Keyword If    '${name}' != 'None'    Set To Dictionary    ${body}    nome=${name}
    Run Keyword If    '${price}' != 'None'    Set To Dictionary    ${body}    preco=${price}
    Run Keyword If    '${desc}' != 'None'    Set To Dictionary    ${body}    descricao=${desc}
    Run Keyword If    '${quantity}' != 'None'    Set To Dictionary    ${body}    quantidade=${quantity}
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}=    PUT On Session    api    /produtos/${product_id}    headers=${headers}    json=${body}    expected_status=200
    RETURN    ${resp}

Deletar Produto
    [Documentation]    Deleta um produto existente pelo seu ID.
    [Arguments]    ${token}    ${id}
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resp}=    DELETE On Session    api    /produtos/${id}    headers=${headers}    expected_status=anything
    RETURN    ${resp}
    