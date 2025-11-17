<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String vlogin          = request.getParameter("login");
String vsenha      = request.getParameter("senha");
String vCsenha = request.getParameter("Csenha");

String status = "";

// 1. Verificar se a nova senha = confirmar senha
if (!novaSenha.equals(confirmarSenha)) {
    status = "mismatch";
} else {

     

   String sqlCheck = "SELECT login FROM usuario WHERE login = ?";
    PreparedStatement checkStmt = conexao.prepareStatement(sqlCheck);
    checkStmt.setString(1, login);

    ResultSet rs = checkStmt.executeQuery();

    if (rs.next()) {

        // 3. Atualizar senha SEM pedir senha atual
        String sqlUpdate = "UPDATE usuario SET senha = ? WHERE login = ?";
        PreparedStatement up = conexao.prepareStatement(sqlUpdate);

        up.setString(1, novaSenha);
        up.setString(2, login);

        int linhas = up.executeUpdate();
    
    stm.execute() ;

   
    }

%>