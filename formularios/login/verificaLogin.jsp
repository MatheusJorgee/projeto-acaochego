<%@page import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String vlogin = request.getParameter("login");
    String vsenha = request.getParameter("senha");

    // CONFIG BD
    String database = "projeto2";
    String endereco = "jdbc:mysql://localhost:3306/" + database ;
    String usuario  = "root";
    String senha    = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection(endereco, usuario, senha);

        String sql = "SELECT * FROM login WHERE login=? AND senha=?";
        PreparedStatement stm = conexao.prepareStatement(sql);

        stm.setString(1, vlogin);
        stm.setString(2, vsenha);

        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            // Login OK
            session.setAttribute("usuario", vlogin);
            response.sendRedirect(request.getContextPath() + "/formularios/Cadas_ani/menu_animais.jsp");
        } else {
            out.print("<script>alert('Login ou senha incorretos!'); window.location='login.html';</script>");
        }

        conexao.close();

    } catch (Exception e) {
        out.print("Erro: " + e.getMessage());
    }
%>
