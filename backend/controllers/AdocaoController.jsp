<%@ page import="java.sql.*" %>
<%@ include file="../config/dbConnection.jsp" %>
<%@ include file="../models/AdocaoModel.jsp" %>

<%
    // Esse controller recebe os dados do formulário de adoção.

    // Pegando os valores enviados pelo formulário HTML
    String nome = request.getParameter("nome");
    String email = request.getParameter("email");
    String cel = request.getParameter("cel");
    String animalId = request.getParameter("id_ani");

    // Chamando a função do model para salvar no banco
    boolean sucesso = salvarAdocao(conn, nome, email, cel, animalId);

    // Se salvar certo, mando o usuário para a página de confirmação
    if(sucesso){
        response.sendRedirect("../views/confirmacaoAdocao.jsp");
    } else {
        // Senão, mostro uma mensagem de erro (temporário, depois posso melhorar)
        out.print("Erro ao cadastrar adoção.");
    }
%>