<%@page import="java.sql.*, java.util.logging.Logger, java.sql.Statement"%>
<%
    String nome_antigo = request.getParameter("nome_antigo");
    String vnome_ani   = request.getParameter("nome_ani");
    String vdata_nas   = request.getParameter("data_nas");
    String vraca       = request.getParameter("raca");
    String vporte      = request.getParameter("porte");
    String vsexo       = request.getParameter("sexo");
    String vcidade     = request.getParameter("cidade");
    String vestado     = request.getParameter("estado");
    
    Connection con = null;
    int idCidade = 0;

    try {
        String url = "jdbc:mysql://localhost:3306/projeto2?serverTimezone=UTC";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, "root", "");

        String sqlSelectCidade = "SELECT id_cidade FROM cidade WHERE cidade = ? AND uf = ?";
        PreparedStatement stmSelectCidade = con.prepareStatement(sqlSelectCidade);
        stmSelectCidade.setString(1, vcidade);
        stmSelectCidade.setString(2, vestado);
        ResultSet rsSelectCidade = stmSelectCidade.executeQuery();

        if (rsSelectCidade.next()) {
            idCidade = rsSelectCidade.getInt("id_cidade");
        } else {
            String sqlInsertCidade = "INSERT INTO cidade (cidade, uf) VALUES (?, ?)";
            PreparedStatement stmInsertCidade = con.prepareStatement(sqlInsertCidade, Statement.RETURN_GENERATED_KEYS);
            stmInsertCidade.setString(1, vcidade);
            stmInsertCidade.setString(2, vestado);
            stmInsertCidade.executeUpdate();

            ResultSet rsKeys = stmInsertCidade.getGeneratedKeys();
            if (rsKeys.next()) {
                idCidade = rsKeys.getInt(1);
            }
            rsKeys.close();
            stmInsertCidade.close();
        }
        rsSelectCidade.close();
        stmSelectCidade.close();

        String sql = "UPDATE animais SET nome_ani=?, data_nas=?, raca=?, porte=?, sexo=?, id_cidade=? WHERE nome_ani=?";

        PreparedStatement stmt = con.prepareStatement(sql);

        stmt.setString(1, vnome_ani);
        stmt.setString(2, vdata_nas); 
        stmt.setString(3, vraca); 
        stmt.setString(4, vporte); 
        stmt.setString(5, vsexo);
        stmt.setInt(6, idCidade);
        stmt.setString(7, nome_antigo);

        int linhasAfetadas = stmt.executeUpdate();
        stmt.close();

        if (linhasAfetadas > 0) {
            out.print("<script>alert('Animal alterado com sucesso!'); window.location.href='menu_animais.jsp';</script>");
        } else {
            out.print("<script>alert('Erro: Animal com nome antigo não encontrado. Nenhuma alteração realizada.'); window.location.href='menu_animais.jsp';</script>");
        }

    } catch (Exception e) {
        out.print("<script>alert('Erro ao salvar as alterações no banco de dados: " + e.getMessage() + "'); history.back();</script>");
        e.printStackTrace();
    } finally {
        if (con != null) {
            try { con.close(); } catch (SQLException ignore) {}
        }
    }
%>

