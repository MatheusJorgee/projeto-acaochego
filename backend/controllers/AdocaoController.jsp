<%@ page import="java.sql.*" %>
<%@ include file="../config/dbConnection.jsp" %>
<%@ include file="../models/AdocaoModel.jsp" %>

<%
    // Esse controller recebe os dados do formulário de adoção.

    // Pegando os valores enviados pelo formulário HTML
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String telefone = request.getParameter("telefone");
    String animalId = request.getParameter("animal_id");

    // Chamando a função do model para salvar no banco
    boolean sucesso = salvarAdocao(conn, nome, email, telefone, animalId);

    // Se salvar certo, mando o usuário para a página de confirmação
    if(sucesso){
        response.sendRedirect("../views/confirmacaoAdocao.jsp");
    } else {
        // Senão, mostro uma mensagem de erro (temporário, depois posso melhorar)
        out.print("Erro ao cadastrar adoção.");
    }
%>