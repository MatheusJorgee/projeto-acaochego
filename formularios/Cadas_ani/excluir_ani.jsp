<%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect(request.getContextPath() + "/formularios/login/login.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/index.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/fonts.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/forms.css" />
    <title>Excluir Animal</title>
<style>
    .link { cursor: pointer; }
</style>
</head>

<header>
        <div class="top-bar">
            <div class="container">
                
              <img class="logo link"  src="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png" alt="Logo Acãochego">
            <script>
            document.querySelector('.logo.link').addEventListener('click', () => {
                window.location.href = "<%= request.getContextPath() %>/formularios/Cadas_ani/menu_animais.jsp";
            });
            </script>



                <div class="name-slogan">
                    <p class="name">ACÃOCHEGO</p>
                    <p class="slogan">
                        ASSOCIAÇÃO PROTETORA DE ANIMAIS ABANDONADOS - ACÃOCHEGO
                    </p>
                </div>

               

                    <button class="menu-toggle" aria-label="Abrir menu">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                </div>
            </div>
        </div>

        <nav class="menu">
            <ul>
                <li><a href="index.html">Início</a></li>
                <li><a href="pages/sobre-nos.html">A Acãochego</a></li>
                <li><a href="adocao.html">Quero Adotar</a></li>
                <li><a href="pages/apadrinhamento.html">Quero Apadrinhar</a></li>
                <li><a href="pages/">Preciso de Ajuda</a></li>
                <li><a href="#">Matérias</a></li>
                <li><a href="#">Finais Felizes</a></li>
                <li><a href="#">Tributo</a></li>
            </ul>
        </nav>
        <div class="line"></div>
    </header>

<body style="background-image: url('<%= request.getContextPath() %>/frontend/assets/img/background_patas.png');">
  
  



<h2>Excluir Animal</h2>

<form method="POST">
    <input type="text" name="nome" placeholder="Digite o nome do animal" required>
    <button type="submit">Excluir</button>
</form>

<%
    String nome = request.getParameter("nome");

    if(nome != null){

        String url = "jdbc:mysql://localhost:3306/projeto2";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");

        PreparedStatement stmt = con.prepareStatement("DELETE FROM animais WHERE nome_ani=?");
        stmt.setString(1, nome);

        int linhas = stmt.executeUpdate();

        if(linhas > 0){
            out.print("<script>alert('Animal excluído com sucesso!');</script>");
        } else {
            out.print("<script>alert('Animal não encontrado!');</script>");
        }
    }
%>

</body>
</html>
