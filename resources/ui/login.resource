*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${LOGIN_URL}      https://front.serverest.dev/login

# Locators
${CAMPO_EMAIL}     css=[data-testid="email"] 
${CAMPO_SENHA}     css=[data-testid="senha"]
${LOGIN_BUTTON}    css=[data-testid="entrar"]
${LOGOUT_BUTTON}   css=[data-testid="logout"]
${ERRO_LOGIN}      Usuário ou senha inválidos

*** Keywords ***
Logar no Serverest
    [Documentation]    Faz login no Serverest. Espera sucesso se ${espera_sucesso} for True, caso contrário valida erro.
    [Arguments]    ${email}    ${password}    ${espera_sucesso}=True
    Open Browser    ${LOGIN_URL}    Chrome
    Input Text      ${CAMPO_EMAIL}    ${email}
    Input Text      ${CAMPO_SENHA}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Run Keyword If    ${espera_sucesso}    
    ...    Wait Until Page Contains Element    ${LOGOUT_BUTTON}    timeout=10s
    ...    ELSE    
    ...    Wait Until Page Contains    ${ERRO_LOGIN}    timeout=10s

Deslogar do Serverest
    [Documentation]    Faz logout do Serverest.
    Click Button    ${LOGOUT_BUTTON}
    Wait Until Page Contains Element    ${LOGIN_BUTTON}    timeout=10s
