# 🐾 Projeto Acãochego

Sistema web para gerenciamento de adoção de animais desenvolvido em JSP/Java.

## 📋 Pré-requisitos

Antes de começar, você precisa ter instalado em sua máquina:

- **XAMPP** (versão 8.0 ou superior) - [Download](https://www.apachefriends.org/pt_br/download.html)
- **MySQL** (incluído no XAMPP)
- **Java JDK** 8 ou superior - [Download](https://www.oracle.com/java/technologies/downloads/)
- Navegador web moderno (Chrome, Firefox, Edge)

## 🚀 Instalação e Configuração

### 1️⃣ Instalar XAMPP

1. Baixe e instale o XAMPP
2. Durante a instalação, certifique-se de marcar:
   - ✅ Apache
   - ✅ MySQL
   - ✅ Tomcat

### 2️⃣ Configurar o Banco de Dados

1. Abra o **XAMPP Control Panel**
2. Inicie o **MySQL** clicando em "Start"
3. Clique em "Admin" do MySQL (abrirá o phpMyAdmin no navegador)
4. No phpMyAdmin:
   - Clique em "Importar" no menu superior
   - Clique em "Escolher arquivo"
   - Navegue até `c:\xampp\tomcat\webapps\projeto-acaochego\docs\database_completo.sql`
   - Clique em "Executar" no final da página
   - ✅ O banco de dados `projeto2` será criado com todas as tabelas e dados

### 3️⃣ Instalar Biblioteca JavaMail

Para que o sistema envie e-mails, você precisa instalar a biblioteca JavaMail:

1. Baixe os seguintes arquivos:
   - [javax.mail.jar](https://mvnrepository.com/artifact/com.sun.mail/javax.mail/1.6.2) 
   - [activation.jar](https://mvnrepository.com/artifact/javax.activation/activation/1.1.1)

2. Copie os arquivos `.jar` para a pasta:
   ```
   c:\xampp\tomcat\lib\
   ```

### 4️⃣ Implantar o Projeto

1. Certifique-se de que a pasta do projeto está em:
   ```
   c:\xampp\tomcat\webapps\projeto-acaochego\
   ```

2. Se você baixou o projeto em outro local, mova toda a pasta para o caminho acima

### 5️⃣ Iniciar o Servidor Tomcat

1. Abra o **XAMPP Control Panel**
2. Inicie o **Tomcat** clicando em "Start"
3. Aguarde até que o status fique verde

## 🌐 Acessando o Site

Após iniciar o MySQL e Tomcat, abra seu navegador e acesse:

```
http://localhost:8080/projeto-acaochego/frontend/index.html
```

### 📍 Páginas Disponíveis

- **Página Inicial**: `http://localhost:8080/projeto-acaochego/frontend/index.html`
- **Adoção**: `http://localhost:8080/projeto-acaochego/frontend/pages/adocao.html`
- **Contato**: `http://localhost:8080/projeto-acaochego/frontend/pages/contato.html`
- **Informações do Animal**: `http://localhost:8080/projeto-acaochego/frontend/pages/info-animal.html`

### 🔐 Acesso Administrativo

Para acessar a área de cadastro de animais:

```
http://localhost:8080/projeto-acaochego/formularios/login/login.html
```

**Credenciais padrão:**
- **Usuário**: `admin`
- **Senha**: `admin123`

⚠️ **IMPORTANTE**: Altere a senha padrão após o primeiro acesso!

## 📧 Configuração de E-mail

O sistema está configurado para enviar e-mails através do Gmail. As credenciais atuais são:

- **E-mail**: testeacaochego@gmail.com
- **Senha de App**: goxi cxse ggbe zjwj

Para usar seu próprio e-mail:

1. Abra o arquivo: `backend\controllers\ContatoController.jsp`
2. Localize as linhas 51-52:
   ```java
   props.put("mail.smtp.user", "testeacaochego@gmail.com");
   String senha = "goxi cxse ggbe zjwj";
   ```
3. Substitua pelo seu e-mail e senha de app do Gmail
4. Para gerar uma senha de app do Gmail:
   - Acesse [Configurações de Segurança do Google](https://myaccount.google.com/security)
   - Ative a verificação em duas etapas
   - Vá em "Senhas de app" e gere uma nova senha

## 🛠️ Solução de Problemas

### Erro: "HTTP Status 404 – Not Found"
- ✅ Verifique se o Tomcat está rodando no XAMPP
- ✅ Confirme se a URL está correta: `http://localhost:8080/projeto-acaochego/...`
- ✅ Certifique-se de que a pasta está em `c:\xampp\tomcat\webapps\`

### Erro: "Cannot connect to database"
- ✅ Verifique se o MySQL está rodando no XAMPP
- ✅ Confirme se o banco `projeto2` foi criado
- ✅ Execute o script `database_completo.sql` novamente

### E-mails não estão sendo enviados
- ✅ Verifique se os arquivos `.jar` do JavaMail estão em `c:\xampp\tomcat\lib\`
- ✅ Reinicie o Tomcat após adicionar os arquivos
- ✅ Confirme se as credenciais de e-mail estão corretas

### Tomcat não inicia
- ✅ Verifique se a porta 8080 não está em uso por outro programa
- ✅ Verifique se o Java JDK está instalado corretamente
- ✅ Reinicie o computador e tente novamente

## 📁 Estrutura do Projeto

```
projeto-acaochego/
├── backend/              # Controllers e lógica de negócio
│   ├── controllers/      # Controladores JSP
│   └── config/          # Configuração do banco de dados
├── frontend/            # Interface do usuário
│   ├── assets/         # CSS, JS e imagens
│   ├── pages/          # Páginas HTML
│   └── index.html      # Página principal
├── formularios/        # Formulários de cadastro e login
│   ├── Cadas_ani/      # Cadastro de animais
│   ├── forms/          # Formulários públicos
│   └── login/          # Sistema de login
├── docs/               # Documentação e scripts SQL
│   └── database_completo.sql
└── README.md           # Este arquivo
```

## 🐕 Animais Cadastrados

O sistema vem com 12 cães pré-cadastrados:
- Nanda, Carminha, Cora, Bono, Pituca, Roni, Tony, Chocolate, Bruna, Caramelo, Mel e Brown

Todos localizados em São Paulo-SP e Guarulhos-SP.

## 📞 Suporte

Se encontrar problemas, verifique:
1. Se todos os serviços do XAMPP estão rodando (MySQL + Tomcat)
2. Se a porta 8080 está disponível
3. Se os arquivos JavaMail estão na pasta correta
4. Se o banco de dados foi importado corretamente

---

**Desenvolvido com ❤️ para o Projeto Acãochego**
