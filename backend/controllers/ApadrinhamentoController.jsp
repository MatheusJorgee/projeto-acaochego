<%@ page import="java.sql.*" %>
<%@ include file="../config/dbConnection.jsp" %>
<%@ include file="../models/ApadrinhamentoModel.jsp" %>

<%
    // Esse controller recebe os dados do formulário de apadrinhamento.

    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String cel = request.getParameter("cel");
    String animalId = request.getParameter("id_ani");

    // Enviando os dados para o model
    boolean sucesso = salvarApadrinhamento(conn, nome, email, cel, animalId);

    // Redirecionando dependendo do resultado
    if(sucesso){
        response.sendRedirect("../views/confirmacaoApadrinhamento.jsp");
    } else {
        out.print("Erro ao cadastrar apadrinhamento.");
    }
%>