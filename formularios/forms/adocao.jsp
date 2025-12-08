 <%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Conexão com o banco
    String database = "projeto2";
    String endereco = "jdbc:mysql://localhost:3306/" + database;
    String usuario_db = "root";
    String senha_db = "";

    Class.forName("com.mysql.jdbc.Driver");
    Connection conexao = DriverManager.getConnection(endereco, usuario_db, senha_db);

    // Se o formulário for enviado, salva
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String vidAni = request.getParameter("id_ani");
        String vtipo      = request.getParameter("cxopc");
        String vnome  = request.getParameter("cxnome");
        String vemail    = request.getParameter("cxemail");
        String vcel      = request.getParameter("cxcel");

        String sqlInsert = "INSERT INTO acao (id_ani,tipo, nome, email, cel) VALUES (?,?, ?, ?, ?)";


    // Cria um objeto para preparar e executar instruções SQL
        PreparedStatement stm = conexao.prepareStatement(sqlInsert);
        stm.setInt(1, Integer.parseInt(vidAni));
        stm.setString(2, vtipo);
        stm.setString(3, vnome);
        stm.setString(4, vemail);
        stm.setString(5, vcel);
        stm.execute();

        stm.close();

        // Redireciona para outra pagina
        out.print("<script>alert('Adoção cadastrada com sucesso!'); window.location='adocao.jsp';</script>");
        return;

    }

%>



<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/index.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/fonts.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/estilo.css" />
     <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/estilo2.css" />
     <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/adocao.css" />


<title>Adoção</title>

<style>


</style>

<body style="background-image: url('<%= request.getContextPath() %>/frontend/assets/img/background_patas.png');"></body>
         <header>
    <div class="top-bar">
      <div class="container">
        <p><img src="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png" alt="Logo Acãochego" class="logo" /></p>

        <div class="name-slogan">
          <p class="name">ACÃOCHEGO</p>
          <p class="slogan">
            ASSOCIAÇÃO PROTETORA DE ANIMAIS ABANDONADOS - ACÃOCHEGO
          </p>
        </div>

        <div class="right-column-stack">
          <div class="social">
            <a href="#"><i class="fa-brands fa-instagram"></i></a>
            <a href="#"><i class="fa-brands fa-facebook"></i></a>
            <a href="#"><i class="fa-brands fa-whatsapp"></i></a>
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



<div class="formulario">

<form method="POST" action="adocao.jsp">
    <h2>ADOÇÃO</h2>
    <div class="grupo-cx">
        <!-- SELECT DOS ANIMAIS -->
      <div class="caixa">

        <%
    String idAnimalURL = request.getParameter("animal");
%>
          <select name="id_ani" required>
    <option value="">Selecione o animal</option>

    <%
        String sql = "SELECT id_ani, nome_ani FROM animais ORDER BY nome_ani";
        PreparedStatement st = conexao.prepareStatement(sql);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id_ani");
            String nome = rs.getString("nome_ani");

            // Verifica se o ID da URL é igual ao do banco
            boolean selecionado = (idAnimalURL != null && idAnimalURL.equals(String.valueOf(id)));
    %>

        <option value="<%= id %>" <%= selecionado ? "selected" : "" %>>
            <%= nome %>
        </option>

    <% } %>
</select>


      </div>
        <div class="caixa">
                <select name="cxopc" class="opcoes">
                    <option value="adocao"> Adoção</option>
                    <option value="apadrinhamento">Apadrinhar</option>
                     <option value="lar">Lar Temporário</option>
                </select>
                </div>

        <div class="caixa">
            <input id="nome" type="text" name="cxnome" placeholder="Nome" required>
        </div>

        <div class="caixa">
            <input id="email" type="text" name="cxemail" placeholder="E-mail" required>
        </div>

        <div class="caixa">
            <input id="cel" type="text" name="cxcel" placeholder="Celular" required>
        </div>
    </div>



     <!-- Termo de uso e concordância -->
    <div class="termos">
        <p>Ao cadastrar os dados, você concorda com os nossos <a href="termos.html" target="_blank">Termos de Uso e Política de Privacidade</a>.</p>
        <p>Estamos em conformidade com a <strong>Lei Geral de Proteção de Dados (LGPD)</strong>.</p>
    </div>

    <div class="botao">
        <input type="submit" value="Enviar" class="btn">
        <input type="reset" value="Apagar" class="btn">
    </div>
</form>
</div>

<footer>
    <!--Começo ul 1-->
    <div class="footer-container">
        <ul>
            <img src="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png" alt="Logo Acãochego" class="logo" />
            <div class="sociais-footer">
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
                <a href="#"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
        </ul>

        <!--Fim ul 1-->

        <!--Começo ul 2-->
        <ul>
            <h3>Link</h3>
            <li><a href="index.html">Início</a></li>
            <li><a href="pages/sobre-nos.html">A Acãochego</a></li>
            <li><a href="pages/form-adocao.html">Quero Adotar</a></li>
            <li><a href="pages/apadrinhamento.html">Quero Apadrinhar</a></li>
            <li><a href="pages/">Preciso de Ajuda</a></li>
            <li><a href="#">Matérias</a></li>
            <li><a href="#">Finais Felizes</a></li>
            <li><a href="#">Tributo</a></li>
        </ul>
        <!--Fim ul 2-->

        <!--Começo ul 3-->
        <ul>
            <h3>Nos contate</h3>
            <li>
                <p>(+55) 11 99999-9999</p>
            </li>
            <li>
                <p>emailempresa@acaochego.com.br</p>
            </li>
            <li>Brasil</li>
        </ul>
        <!--Fim ul 3-->
    </div>
</footer>
</div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"></script>
<script>
    $('#cel').mask('(00)00000-0000');
</script>

</body>
</html>