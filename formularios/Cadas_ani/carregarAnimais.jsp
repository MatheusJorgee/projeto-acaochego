<%@page language="java" import="java.sql.*" %>

<%
String database = "projeto2";
String endereco = "jdbc:mysql://localhost:3306/" + database;
String usuario  = "root";
String senha    = "";

Class.forName("com.mysql.jdbc.Driver");
Connection conexao = DriverManager.getConnection(endereco, usuario, senha);

String sql = "SELECT id_ani, nome_ani FROM animais ORDER BY nome_ani";
PreparedStatement stm = conexao.prepareStatement(sql);
ResultSet rs = stm.executeQuery();

out.println("<option value=''>Selecione o animal</option>");

while (rs.next()) {
    out.println("<option value='" + rs.getString("nome_ani") + "'>" +
                     rs.getString("nome_ani") +
                "</option>");
}

rs.close();
//Fecha o comando SQL
stm.close();
//Fecha a conexão com o banco
conexao.close();
%>