<%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Só autoriza depois do login
    if(session.getAttribute("usuario") == null){
        response.sendRedirect(request.getContextPath() + "/formularios/login/login.html");
        return;
    }

    // Procura pelo nome do animal
    String nomeBusca = request.getParameter("nomeBusca");

    String nome_ani="", data_nas="", raca="", porte="", sexo="", cidade="", estado="";
    
    // Se não estiver vazio continua 
    if(nomeBusca != null){
        // Conexão
        String db = "projeto2";
        String url = "jdbc:mysql://localhost:3306/" + db;
        String user = "root";
        String pass = "";

        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);

            //  Usar JOIN para obter Cidade e UF 
            // Procura no banco o nome do animal, juntando com a tabela 'cidade'
            PreparedStatement stmt = con.prepareStatement(
                "SELECT a.*, c.cidade, c.uf FROM animais a " +
                "JOIN cidade c ON a.id_cidade = c.id_cidade " +
                "WHERE a.nome_ani = ?"
            );
            stmt.setString(1, nomeBusca);
            ResultSet rs = stmt.executeQuery();

            // Se encontrar, permite alterar 
            if(rs.next()){
                nome_ani = rs.getString("nome_ani");
                data_nas = rs.getString("data_nas");
                raca = rs.getString("raca");
                porte = rs.getString("porte");
                sexo = rs.getString("sexo");
                
                //  Atribui valores de Cidade e UF
                cidade = rs.getString("cidade");
                estado = rs.getString("uf");     
                
            } else {
                out.print("<script>alert('Animal não encontrado!');</script>");
            }
            rs.close();
            stmt.close();

        } catch (Exception e) {
            out.print("Erro de Banco de Dados: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException ignore) {}
            }
        }
    }
%>

<!DOCTYPE html>
<html>
</html>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 
      <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/index.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/fonts.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/forms.css" />

  
    <title>Alterar Animais</title>

    <style>
         
            .input-nas{
                width: 600px; /* mesmo tamanho da imagem */
                padding: 15px 25px;
                border: 2px solid #5893f3;
                border-radius: 30px;
                font-size: 18px;
            }

    </style>

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
  
  

<h2>Alterar Animal</h2>

<form method="POST">
    <input type="text" name="nomeBusca" placeholder="Digite o nome do animal" required>
    <button type="submit">Buscar</button>
</form>

<% if(nome_ani != "") { %>

<hr>

<form method="POST" action="alterar_ani_salvar.jsp">

    <input type="hidden" name="nome_antigo" value="<%=nome_ani%>">

    Nome: <input type="text" name="nome_ani" value="<%=nome_ani%>" required><br><br>
    Data de Nascimento: <input class="input-nas" type="date" name="data_nas" value="<%=data_nas%>" required><br><br>
    Raça: <input type="text" name="raca" value="<%=raca%>" required><br><br>
    Porte: <input type="text" name="porte" value="<%=porte%>" required><br><br>
    Sexo: <input type="text" name="sexo" value="<%=sexo%>" required><br><br>
    Cidade: <input type="text" name="cidade" value="<%=cidade%>" required><br><br>
    Estado: <input type="text" name="estado" value="<%=estado%>" required><br><br>

    <button type="submit">Salvar Alterações</button>
</form>

<% } %>

</body>
</html>
