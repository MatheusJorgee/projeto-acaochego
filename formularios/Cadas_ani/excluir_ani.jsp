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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/menu.css" />
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
            </div>
        </div>
        <div class="line"></div>
    </header>

<body style="background-image: url('<%= request.getContextPath() %>/frontend/assets/img/background_patas.png');">
  
  



<h2>Excluir Animal</h2>

<form method="POST">
    <div class="grupo-cx">
        <div class="caixa">
            <label for="nome">Nome do Animal</label>
            <input type="text" id="nome" name="nome" required>
        </div>
    </div>

    <div class="btn-container2">
        <button type="submit">Excluir</button>
    </div>
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

<script src="https://kit.fontawesome.com/45bbe533ad.js" crossorigin="anonymous"></script>
<script src="<%= request.getContextPath() %>/frontend/assets/js/main.js"></script>
</body>
</html>
