

<%@page import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String vlogin  = request.getParameter("login");
    String vsenha  = request.getParameter("senha");
    String vCsenha = request.getParameter("confirmar_senha");

    // Verifica se senhas conferem
    if (!vsenha.equals(vCsenha)) {
        out.print("<script>alert('As senhas não coincidem!'); history.back();</script>");
        return;
    }

    // CONFIG BANCO
    String database = "projeto";
    String endereco = "jdbc:mysql://localhost:3306/" + database + "?useSSL=false&serverTimezone=UTC";
    String usuario  = "root";
    String senha    = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(endereco, usuario, senha);

        // Verifica se login já existe
        String sqlCheck = "SELECT id FROM login WHERE login = ?";
        PreparedStatement check = conexao.prepareStatement(sqlCheck);
        check.setString(1, vlogin);
        ResultSet rs = check.executeQuery();

        if (rs.next()) {
            out.print("<script>alert('Esse usuário já existe!'); history.back();</script>");
            return;
        }

        // INSERIR NOVO USUÁRIO
        String sqlInsert = "INSERT INTO login (login, senha) VALUES (?, ?)";
        PreparedStatement stm = conexao.prepareStatement(sqlInsert);
        stm.setString(1, vlogin);
        stm.setString(2, vsenha);

        stm.execute();

        stm.close();
        conexao.close();

        out.print("<script>alert('Cadastro realizado com sucesso!'); window.location='login.html';</script>");

    } catch (Exception e) {
        out.print("Erro: " + e.getMessage());
    }
%>