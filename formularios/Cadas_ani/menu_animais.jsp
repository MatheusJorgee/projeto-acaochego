<%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verifica login
    if( session.getAttribute("usuario") == null ) {
        response.sendRedirect(request.getContextPath() + "/formularios/login/login.html");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/index.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/fonts.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/forms.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/menu.css" />

  
    <title>Gerenciar Animais</title>

    <style>
            /*Botões da Página MENU*/
        a {
            
            background: #5aa0ff;
            padding: 15px 30px;
            text-decoration: none;
            color: #fff;
            font-size: 18px;
            border-radius: 10px;
            transition: .3s;
            margin-top: 50px;
           
        }

        a:hover {
            background: #5aa0ff;
            transform: scale(1.07);
        }

    </style>

<header>
        <div class="top-bar">
            <div class="container">
                 <img class="logo link"  src="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png" alt="Logo Acãochego">

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
  
 


<h1>Gerenciamento de Animais</h1>



<div class="btn-container">
    <a href="cadas_ani.jsp">Cadastrar Animal</a>
    <a href="alterar_ani.jsp">Alterar Animal</a>
    <a href="excluir_ani.jsp">Excluir Animal</a>
</div>

<script src="https://kit.fontawesome.com/45bbe533ad.js" crossorigin="anonymous"></script>
<script src="<%= request.getContextPath() %>/frontend/assets/js/main.js"></script>
</body>
</html>
