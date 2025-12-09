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
    <title>Redefinir Senha - Acãochego</title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #ededed;
            background-image: url('background-pattern.png');
            background-size: cover;
        }
        .wrapper {
            width: 420px;
            background: white;
            border-radius: 20px;
            padding: 30px 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, .1);
            text-align: center;
        }
        .wrapper h1 {
            font-size: 23px;
            color: #333;
            font-family: Arial, sans-serif;
            margin-bottom: 20px;
        }
        .input-box {
            width: 100%;
            height: 50px;
            background-color: transparent;
            margin: 20px 0;
            position: relative;
        }
        .input-box input {
            width: 100%;
            height: 100%;
            background: #f2f2f2;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 16px;
            color: #333;
            padding: 15px 20px;
            outline: none;
        }
        .btn {
            width: 100%;
            height: 45px;
            background-color: #4C0E62;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            color: white;
            font-weight: 600;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #6a1183;
        }
        .register-link {
            font-size: 14px;
            color: #333;
            text-decoration: none;
            margin-top: 20px;
        }
        .register-link:hover {
            text-decoration: underline;
        }
        .message {
            margin: 15px 0;
            padding: 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <h1>REDEFINIR SENHA</h1>

        <% if (status.equals("success")) { %>
            <div class="message success">
                Senha redefinida com sucesso! <a href="login.html">Voltar ao login</a>
            </div>
        <% } else if (status.equals("mismatch")) { %>
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

        <form action="redefinir.jsp" method="POST">
            <div class="input-box">
                <input type="text" placeholder="Usuário" id="login" name="login" required>
            </div>
            <div class="input-box">
                <input type="password" placeholder="Nova Senha" id="senha" name="senha" required>
            </div>
            <div class="input-box">
                <input type="password" placeholder="Confirmar Senha" id="confirmar_senha" name="confirmar_senha" required>
            </div>
            <button type="submit" class="btn">Redefinir</button>
        </form>

        <p class="register-link"><a href="login.html">Voltar ao login</a></p>
        <p class="register-link"><a href="Crialogin.html">Não tem uma conta? Registre-se</a></p>
    </div>
</body>
</html>