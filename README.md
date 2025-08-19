# automation-serverest

Este projeto utiliza **Robot Framework** para automação de testes na API Serverest.

## Índice

- [Estrutura do Projeto](#estrutura-do-projeto)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Executando os Testes](#executando-os-testes)
- [Estrutura dos Testes](#estrutura-dos-testes)
- [Exemplo de Caso de Teste](#exemplo-de-caso-de-teste)
- [Relatórios](#relatórios)
- [Contribuição](#contribuição)
- [Referências](#referências)

## Estrutura do Projeto

```
automation-serverest/
├── tests/                # Casos de teste em Robot Framework
│   ├── api/              # Testes relacionados à API
│   ├── ui/               # Testes relacionados à interface web
├── resources/            # Arquivos de recursos e keywords customizadas
│   ├── api/              # Keywords para API
│   ├── ui/               # Keywords para UI
├── README.md             # Documentação do projeto
├── requirements.txt      # Dependências do projeto
```

## Pré-requisitos

- Python 3.7+
- Robot Framework
- Requests Library (`robotframework-requests`)
- FakerLibrary (`robotframework-faker`)
- SeleniumLibrary (`robotframework-seleniumlibrary`)

## Instalação

Clone o repositório e instale as dependências:

```bash
git clone https://github.com/Cristinalc01/serverest.git
cd serverest
pip install -r requirements.txt
```

## Executando os Testes

Para rodar todos os testes:

```bash
robot tests/
```

Para rodar um teste específico:

```bash
robot tests/api/test_usuarios.robot
```

## Estrutura dos Testes

- Testes organizados por módulos (`api`, `ui`).
- Keywords customizadas em `resources/`.
- Variáveis globais e de ambiente podem ser adicionadas em arquivos de variáveis.

## Exemplo de Caso de Teste

```robot
*** Test Cases ***
CT01 - Criar usuário com sucesso
    ${nome}=    FakerLibrary.First Name
    ${email}=   FakerLibrary.Email
    ${password}=   FakerLibrary.Password
    ${resp}=    Registrar Usuário   ${nome}    ${email}    ${password}
    Should Be Equal As Integers    ${resp.status_code}    201
    Dictionary Should Contain Key    ${resp.json()}    _id
```

## Relatórios

Após a execução, são gerados automaticamente:

- `report.html` — Relatório geral dos testes
- `log.html` — Log detalhado da execução
- `output.xml` — Saída em XML para integração

## Contribuição

1. Fork este repositório
2. Crie uma branch (`git checkout -b feature/nova-feature`)
3. Commit suas alterações
4. Envie um Pull Request

## Referências

- [Robot Framework Documentation](https://robotframework.org/)
- [Serverest API](https://serverest.dev/)
