<%
    // Verifica login
    if( session.getAttribute("usuario") == null ) {
        response.sendRedirect("login.html");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Animais</title>

    <style>
        body {
            background: #f5f5f5;
            font-family: Arial;
            text-align: center;
            padding-top: 50px;
        }

        h1 {
            color: #4C0E62;
            margin-bottom: 40px;
        }

        .container {
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        a {
            background: #4C0E62;
            padding: 15px 30px;
            text-decoration: none;
            color: #fff;
            font-size: 18px;
            border-radius: 10px;
            transition: .3s;
        }

        a:hover {
            background: #5aa0ff;
            transform: scale(1.07);
        }
    </style>
</head>

<body>

<h1>Gerenciamento de Animais</h1>

<div class="container">
    <a href="cadas_ani.jsp">Cadastrar Animal</a>
    <a href="alterar_ani.jsp">Alterar Animal</a>
    <a href="excluir_ani.jsp">Excluir Animal</a>
</div>

</body>
</html>
