<%@page import="java.sql.*"%>

<%
String nome_antigo = request.getParameter("nome_antigo");
String nome = request.getParameter("nome_ani");
String idade = request.getParameter("idade");
String especie = request.getParameter("especie");
String estado = request.getParameter("estado_saude");
String sexo = request.getParameter("sexo");

String url = "jdbc:mysql://localhost:3306/projeto";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "root", "");

String sql = "UPDATE animais SET nome_ani=?, idade=?, especie=?, estado_saude=?, sexo=? WHERE nome_ani=?";

// Prepara e permite executar um comando SQL
PreparedStatement stmt = con.prepareStatement(sql);

stmt.setString(1, nome);
stmt.setInt(2, Integer.parseInt(idade));
stmt.setString(3, especie);
stmt.setString(4, estado);
stmt.setString(5, sexo);
stmt.setString(6, nome_antigo);

stmt.executeUpdate();

out.print("<script>alert('Animal alterado com sucesso!'); window.location.href='menu_animais.jsp';</script>");
%>
