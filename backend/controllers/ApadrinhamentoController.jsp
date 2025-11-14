<%@ page import="java.sql.*" %>
<%@ include file="../config/dbConnection.jsp" %>
<%@ include file="../models/ApadrinhamentoModel.jsp" %>

<%
    // Esse controller recebe os dados do formulário de apadrinhamento.

    String nome = request.getParameter("nome");
    String valor = request.getParameter("valor");
    String animalId = request.getParameter("animal_id");

    // Enviando os dados para o model
    boolean sucesso = salvarApadrinhamento(conn, nome, valor, animalId);

    // Redirecionando dependendo do resultado
    if(sucesso){
        response.sendRedirect("../views/confirmacaoApadrinhamento.jsp");
    } else {
        out.print("Erro ao cadastrar apadrinhamento.");
    }
%>