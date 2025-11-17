<%@page import="java.sql.*"%>

<%
    // Só autoriza depois do login
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("login.html");
        return;
    }

    // Procura pelo nome do animal
    String nomeBusca = request.getParameter("nomeBusca");

    String nome_ani="", idade="", especie="", estado_saude="", sexo="";

        // Se não estiver vazio continua 
    if(nomeBusca != null){
        // Conexão
        String db = "projeto";
        String url = "jdbc:mysql://localhost:3306/" + db;
        String user = "root";
        String pass = "";

        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, user, pass);

            //Procura no banco o nome do animal
        PreparedStatement stmt = con.prepareStatement(
            "SELECT * FROM animais WHERE nome_ani = ?"
        );
        stmt.setString(1, nomeBusca);
        ResultSet rs = stmt.executeQuery();

        // Se encontrar, permite alterar 
        if(rs.next()){
            nome_ani = rs.getString("nome_ani");
            idade = rs.getString("idade");
            especie = rs.getString("especie");
            estado_saude = rs.getString("estado_saude");
            sexo = rs.getString("sexo");
        } else {
            out.print("<script>alert('Animal não encontrado!');</script>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alterar Animal</title>
</head>
<body>

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
    Idade: <input type="number" name="idade" value="<%=idade%>" required><br><br>
    Espécie: <input type="text" name="especie" value="<%=especie%>" required><br><br>
    Estado de Saúde: <input type="text" name="estado_saude" value="<%=estado_saude%>" required><br><br>
    Sexo: <input type="text" name="sexo" value="<%=sexo%>" required><br><br>

    <button type="submit">Salvar Alterações</button>
</form>

<% } %>

</body>
</html>
