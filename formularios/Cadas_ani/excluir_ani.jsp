<%@page import="java.sql.*"%>

<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("login.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Excluir Animal</title>
</head>
<body>

<h2>Excluir Animal</h2>

<form method="POST">
    <input type="text" name="nome" placeholder="Digite o nome do animal" required>
    <button type="submit">Excluir</button>
</form>

<%
    String nome = request.getParameter("nome");

    if(nome != null){

        String url = "jdbc:mysql://localhost:3306/projeto";
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
