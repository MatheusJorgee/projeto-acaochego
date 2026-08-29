# Projeto Acãochego

Sistema web para gerenciamento de adoção de animais, desenvolvido como projeto acadêmico do curso de Ciência da Computação.

O site apresenta os animais disponíveis, recebe pedidos de adoção e apadrinhamento por formulário, e conta com uma área administrativa para cadastro e manutenção dos animais.

## Funcionalidades

- **Catálogo de animais** disponíveis para adoção, com página de informações individual
- **Formulário de adoção** com registro no banco e página de confirmação
- **Apadrinhamento** de animais, com fluxo próprio de confirmação
- **Formulário de contato** com envio de e-mail via SMTP
- **Área administrativa** com login, para cadastrar, alterar e excluir animais
- **Criação de conta e redefinição de senha** para os usuários administrativos

## Tecnologias

| Camada | Tecnologia |
| --- | --- |
| Back-end | Java com JSP |
| Servidor | Apache Tomcat (via XAMPP) |
| Banco de dados | MySQL |
| Driver | MySQL Connector/J 5.1.49 |
| Tags | JSTL 1.2 |
| E-mail | JavaMail (SMTP do Gmail) |
| Front-end | HTML, CSS e JavaScript |
| Tipografia | Montserrat, Nunito e Poppins |

## Estrutura

```
projeto-acaochego/
├── frontend/
│   ├── index.html                # Página inicial
│   ├── pages/                    # Adoção, contato e informações do animal
│   └── assets/                   # CSS, JavaScript, fontes e imagens
├── backend/
│   ├── config/dbConnection.jsp   # Conexão com o MySQL
│   ├── controllers/              # Adoção, apadrinhamento e contato
│   ├── models/                   # Acesso a dados
│   └── views/                    # Páginas de confirmação
├── formularios/
│   ├── login/                    # Login, criação de conta e redefinição
│   ├── forms/                    # Formulário de adoção e termos
│   └── Cadas_ani/                # CRUD de animais (área administrativa)
├── docs/database_completo.sql    # Script de criação do banco
└── WEB-INF/                      # Bibliotecas e configuração da aplicação
```

## Banco de dados

O script `docs/database_completo.sql` cria o banco `projeto2` com cinco tabelas: `animais`, `cidade`, `acao` (registro das adoções), `contatos` (mensagens do formulário) e `login` (usuários administrativos). O script já popula o banco com as cidades, os usuários de acesso e doze animais de exemplo.

## Como executar

**Pré-requisitos:** XAMPP 8.0 ou superior, com Apache, MySQL e Tomcat, e Java JDK 8 ou superior.

1. **Importe o banco.** No XAMPP Control Panel, inicie o MySQL e abra o phpMyAdmin. Em Importar, selecione `docs/database_completo.sql` e execute — o banco `projeto2` será criado com as tabelas e os dados iniciais.

2. **Instale as bibliotecas do JavaMail.** Baixe [javax.mail.jar](https://mvnrepository.com/artifact/com.sun.mail/javax.mail/1.6.2) e [activation.jar](https://mvnrepository.com/artifact/javax.activation/activation/1.1.1) e copie os dois para `c:\xampp\tomcat\lib\`.

3. **Posicione o projeto** em `c:\xampp\tomcat\webapps\projeto-acaochego\`.

4. **Configure o envio de e-mail.** Em `backend/controllers/ContatoController.jsp`, por volta da linha 47, preencha as constantes `emailRemetente` e `senhaApp` com seu endereço e uma senha de app do Gmail. Sem isso, o formulário de contato não envia.

5. **Inicie o Tomcat** no XAMPP e acesse:

```
http://localhost:8080/projeto-acaochego/frontend/index.html
```

A área administrativa fica em `formularios/login/login.html`. As credenciais de teste (`admin` / `admin123`) vêm no script do banco.

### Problemas comuns

| Sintoma | Verificar |
| --- | --- |
| HTTP 404 | Tomcat rodando e projeto em `c:\xampp\tomcat\webapps\` |
| Erro de conexão com o banco | MySQL rodando e banco `projeto2` importado |
| E-mails não enviam | Os dois `.jar` em `c:\xampp\tomcat\lib\` e Tomcat reiniciado |
| Tomcat não inicia | Porta 8080 livre e JDK instalado |

## Contexto e aprendizados

Este foi o primeiro projeto do curso, construído enquanto HTML, CSS, JavaScript e JSP ainda estavam sendo aprendidos. O projeto está encerrado e não recebe mais alterações — o código permanece como foi entregue.

### Credencial exposta

Uma versão anterior deste README, e o próprio `ContatoController.jsp`, traziam a senha de app de uma conta Gmail escrita diretamente no código. A credencial ficou visível no repositório público até ser identificada em uma revisão posterior.

A conta havia sido criada apenas para testes do projeto, sem uso pessoal, e **já foi excluída** — a credencial não tem mais validade.

O registro fica aqui de propósito, porque a lição vale mais anotada do que apagada: credencial não entra em código versionado nem em documentação. Remover do arquivo também não resolve, já que o histórico do Git preserva o conteúdo — a única medida efetiva é revogar a credencial. O caminho correto seria lê-la de variável de ambiente ou de um arquivo de configuração fora do versionamento.

O login administrativo é caso diferente: `admin` / `admin123` são dados de teste para popular o ambiente local, que roda apenas em `localhost`.

### O que seria feito diferente

Separar configuração de código, parametrizar as consultas ao banco, concentrar o acesso a dados fora das páginas JSP e padronizar a estrutura de pastas, hoje dividida entre `backend`, `frontend` e `formularios` sem um critério único.

## Equipe

Projeto desenvolvido em grupo:

- [Matheus Jorge](https://github.com/MatheusJorgee)
- [Adrielly Thuner](https://github.com/AdriellyThuner)
- [Kimberly Ledio](https://github.com/kimberlyledio)

---
