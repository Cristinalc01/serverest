*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${LOGIN_URL}      https://front.serverest.dev/login

#locators
${CAMPO_EMAIL}    css=[data-testid="email"] 
${CAMPO_SENHA}     css=[data-testid="senha"]
${LOGIN_BUTTON}   css=[data-testid="entrar"]
${LOGOUT_BUTTON}  css=[data-testid="logout"]

*** Keywords ***
Logar no Serverest
    [Arguments]    ${email}    ${password}
    Open Browser    ${LOGIN_URL}    Chrome
    Input Text    ${CAMPO_EMAIL}    ${email}
    Input Text    ${CAMPO_SENHA}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${LOGOUT_BUTTON}    timeout=10s

Deslogar do Serverest
    Click Button    ${LOGOUT_BUTTON}
    Wait Until Page Contains Element    ${LOGIN_BUTTON}    timeout=10s
