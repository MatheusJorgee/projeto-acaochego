/*
%@ page import="java.sql.*" %>

<%
    // Arquivo responsável por conectar o meu sistema ao banco MySQL.
    // Assim não preciso repetir esse código em todas as páginas.
    
    // Dados do banco (colocar a senha e a URL host certa depois)
    String url = "jdbc:mysql://localhost:3306/acaochego?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String password = "1234"; 

    Connection conn = null;

    try {
        // Carregando o driver do MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Abrindo conexão com o banco usando as configs acima
        conn = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        // Caso dê erro, ele mostra qual foi (bom pra debugar)
        out.println("Erro ao conectar ao banco: " + e.getMessage());
    }
%>
*/