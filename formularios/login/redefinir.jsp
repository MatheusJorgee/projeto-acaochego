<%@page import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String vlogin = request.getParameter("login");
    String vsenha = request.getParameter("senha");
    String vCsenha = request.getParameter("confirmar_senha");

    String status = "";

    if (request.getMethod().equalsIgnoreCase("POST") && vlogin != null && vsenha != null && vCsenha != null) {
        
        if (!vsenha.equals(vCsenha)) {
            status = "mismatch";
        } else {
            
            String database = "projeto2";
            String endereco = "jdbc:mysql://localhost:3306/" + database;
            String usuario = "root";
            String senha = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection(endereco, usuario, senha);

                String sqlCheck = "SELECT id_login FROM login WHERE login = ?";
                PreparedStatement checkStmt = conexao.prepareStatement(sqlCheck);
                checkStmt.setString(1, vlogin);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    String sqlUpdate = "UPDATE login SET senha = ? WHERE login = ?";
                    PreparedStatement upStmt = conexao.prepareStatement(sqlUpdate);
                    upStmt.setString(1, vsenha);
                    upStmt.setString(2, vlogin);
                    int linhas = upStmt.executeUpdate();

                    if (linhas > 0) {
                        status = "success";
                        // Redireciona para login após 2 segundos
                        response.setHeader("Refresh", "2; URL=login.html");
                    } else {
                        status = "error";
                    }

                    upStmt.close();
                } else {
                    status = "notfound";
                }

                checkStmt.close();
                conexao.close();

            } catch (Exception e) {
                status = "error";
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/fonts.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/forms.css" />
    <script src="https://kit.fontawesome.com/dcf460ffec.js" crossorigin="anonymous"></script>
    <title>Redefinir Senha - Acãochego</title>
    
    <style>
        .message {
            max-width: 500px;
            margin: 20px auto;
            padding: 15px 20px;
            border-radius: 15px;
            font-family: 'Montserrat Regular', sans-serif;
            font-size: 1rem;
            text-align: center;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 3px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 3px solid #f5c6cb;
        }
        .message a {
            color: #5893f3;
            font-weight: 600;
            text-decoration: none;
        }
    </style>
</head>

<header>
    <div class="top-bar">
        <div class="container">
            <img class="logo link" src="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png" alt="Logo Acãochego">

            <script>
                document.querySelector('.logo.link').addEventListener('click', () => {
                    window.location.href = "<%= request.getContextPath() %>/frontend/index.html";
                });
            </script>

            <div class="name-slogan">
                <p class="name">ACÃOCHEGO</p>
                <p class="slogan">
                    ASSOCIAÇÃO PROTETORA DE ANIMAIS ABANDONADOS - ACÃOCHEGO
                </p>
            </div>
        </div>
    </div>
    <div class="line"></div>
</header>

<body style="background-image: url('<%= request.getContextPath() %>/frontend/assets/img/background_patas.png');">

    <h2 style="margin: 40px auto 20px;">Redefinir Senha</h2>

    <% if (status.equals("success")) { %>
        <div class="message success">
            Senha redefinida com sucesso! Redirecionando para o login...
        </div>
    <% } else { %>
        
        <% if (status.equals("mismatch")) { %>
            <div class="message error">
                As senhas não coincidem!
            </div>
        <% } else if (status.equals("notfound")) { %>
            <div class="message error">
                Usuário não encontrado!
            </div>
        <% } else if (status.equals("error")) { %>
            <div class="message error">
                Erro ao redefinir senha. Tente novamente.
            </div>
        <% } %>

        <form action="redefinir.jsp" method="POST" style="padding-bottom: 20px;">
            <div class="grupo-cx-login">
                <div class="caixa">
                    <label for="login">Usuário</label>
                    <input type="text" id="login" name="login" required>
                </div>

                <div class="caixa">
                    <label for="senha">Nova Senha</label>
                    <input type="password" id="senha" name="senha" required>
                </div>

                <div class="caixa">
                    <label for="confirmar_senha">Confirmar Senha</label>
                    <input type="password" id="confirmar_senha" name="confirmar_senha" required>
                </div>
            </div>

            <div class="btn-container2">
                <button type="submit">Redefinir</button>
            </div>
        </form>

        <div style="text-align: center; margin: 30px 0; font-family: 'Montserrat Regular', sans-serif;">
            <p style="margin-bottom: 10px;"><a href="login.html" style="color: #5893f3; text-decoration: none; font-weight: 600;">Voltar ao login</a></p>
            <p style="margin-bottom: 0;"><a href="Crialogin.html" style="color: #5893f3; text-decoration: none; font-weight: 600;">Não tem uma conta? Registre-se</a></p>
        </div>
    <% } %>

    <script src="<%= request.getContextPath() %>/frontend/assets/js/main.js"></script>
</body>
</html>