<%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Se o usuário não estiver logado, volta para login
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.html");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    // Se o formulário foi enviado
    if (request.getMethod().equalsIgnoreCase("POST")) {

        String vnome_ani   = request.getParameter("nome_ani");
        String vidade      = request.getParameter("idade");
        String vespecie    = request.getParameter("especie");
        String vestado     = request.getParameter("estado_saude");
        String vsexo       = request.getParameter("sexo");

        // Validação básica
        if (vnome_ani == null || vidade == null || vespecie == null || vestado == null || vsexo == null ||
            vnome_ani.isEmpty() || vidade.isEmpty() || vespecie.isEmpty() || vestado.isEmpty() || vsexo.isEmpty()) {

            out.print("<script>alert('Algum campo está vazio! Preencha tudo.'); history.back();</script>");
            return;
        }

        // Conexão com banco
        try {
            Class.forName("com.mysql.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/projeto";
            Connection conexao = DriverManager.getConnection(url, "root", "");

            String sql = "INSERT INTO animais (nome_ani, idade, especie, estado_saude, sexo) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement stm = conexao.prepareStatement(sql);
            stm.setString(1, vnome_ani);
            stm.setInt(2, Integer.parseInt(vidade));
            stm.setString(3, vespecie);
            stm.setString(4, vestado);
            stm.setString(5, vsexo);

            stm.execute();
            stm.close();
            conexao.close();

            out.print("<script>alert('Animal cadastrado com sucesso!'); window.location='cadas_ani.jsp';</script>");
            return;

        } catch (Exception e) {
            out.print("Erro ao salvar no banco: " + e.getMessage());
        }
    }
%>

<!-- FORMULÁRIO  -->
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Animal</title>
</head>
<body>

<h2>Cadastro de Novo Animal</h2>

<form method="POST" action="cadas_ani.jsp">

    <div class="caixa">
        <label>Nome do Animal</label>
        <input type="text" name="nome_ani" required>
    </div>

    <div class="caixa">
        <label>Idade</label>
        <input type="number" name="idade" required>
    </div>

    <div class="caixa">
        <label>Espécie</label>
        <input type="text" name="especie" required>
    </div>

    <div class="caixa">
        <label>Estado de Saúde</label>
        <input type="text" name="estado_saude" required>
    </div>

    <div class="caixa">
        <label>Sexo</label>
        <input type="text" name="sexo" required>
    </div>

    <button type="submit">Cadastrar</button>
    

</form>


</body>
</html>
