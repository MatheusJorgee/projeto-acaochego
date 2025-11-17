<%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Conexão com o banco
    String database = "projeto";
    String endereco = "jdbc:mysql://localhost:3306/" + database;
    String usuario_db = "root";
    String senha_db = "";

    Class.forName("com.mysql.jdbc.Driver");
    Connection conexao = DriverManager.getConnection(endereco, usuario_db, senha_db);

    // Se o formulário for enviado, salva
    if (request.getMethod().equalsIgnoreCase("POST")) {

        String vidAnimal = request.getParameter("id_animal");
        String vnome_ap  = request.getParameter("cxnome_p");
        String vemail_p    = request.getParameter("cxemail_p");
        String vcel_p     = request.getParameter("cxcel_p");

        String sqlInsert = "INSERT INTO apadrinhar (id_animal, nome_ap, email_p, cel_p) VALUES (?, ?, ?, ?)";
        PreparedStatement stm = conexao.prepareStatement(sqlInsert);
        stm.setInt(1, Integer.parseInt(vidAnimal));
        stm.setString(2, vnome_ap);
        stm.setString(3, vemail_p);
        stm.setString(4, vcel_p);
        stm.execute();

        stm.close();

        out.print("<script>alert('Apadrinhar cadastrada com sucesso!'); window.location='apadrinhar.jsp';</script>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Adoção</title>

<style>
/* --- CSS  --- */

body {
    font-family: Arial, sans-serif;
    background-color: #f0f4f8;
    margin: 0;
    padding: 0;
}

.formulario {
    padding: 20px;
}

h2 {
    font-size: 45px;
    color: #4C0E62;
    text-align: center;
    margin-bottom: 15px;
}

.grupo-cx {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 45px;
    padding: 30px;
    margin-left: 250px;
    max-width: 1100px;
}

.caixa {
    flex: 1 1 40%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.caixa input,
.caixa select {
    width: 100%;
    padding: 12px 20px;
    border: 2px solid #4C0E62;
    border-radius: 25px;
    background-color: #fff;
    font-size: 16px;
    color: #333;
}

.botao {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin: 30px auto;
}

.btn {
    background-color: #4C0E62;
    color: #fff;
    border: none;
    border-radius: 25px;
    padding: 12px 35px;
    font-size: 16px;
    cursor: pointer;
}
.btn:hover {
    background-color: #5aa0ff;
}

</style>
</head>
<body>

<div class="corpo">
<div class="formulario">

<form method="POST" action="apadrinhar.jsp">

    <h2>Apadrinhar</h2>

    <div class="grupo-cx">

        <!-- SELECT DOS ANIMAIS  -->
        <div class="caixa">
            <select name="id_animal" required>
                <option value="">Selecione o animal</option>

                <%
                    // Busca animais cadastrados
                    String sql = "SELECT id, nome_ani FROM animais ORDER BY nome_ani";
                    PreparedStatement st = conexao.prepareStatement(sql);
                    ResultSet rs = st.executeQuery();

                    while (rs.next()) {
                %>

                    <option value="<%= rs.getInt("id") %>">
                        <%= rs.getString("nome_ani") %>
                    </option>

                <% } %>
            </select>
        </div>

        <div class="caixa">
            <input id="nome" type="text" name="cxnome_p" placeholder="Nome" required>
        </div>

        <div class="caixa">
            <input id="email" type="text" name="cxemail_p" placeholder="E-mail" required>
        </div>

        <div class="caixa">
            <input id="cel" type="text" name="cxcel_p" placeholder="Celular" required>
        </div>

    </div>

    <div class="botao">
        <input type="submit" value="Enviar" class="btn">
        <input type="reset" value="Apagar" class="btn">
    </div>

</form>

</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"></script>

<script>
    $('#cel').mask('(00)00000-0000');
</script>

</body>
</html>
