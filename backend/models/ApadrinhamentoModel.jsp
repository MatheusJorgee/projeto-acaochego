<%@ page import="java.sql.*" %>

<%!  
    // Função para salvar o apadrinhamento na tabela "acao".

    public boolean salvarApadrinhamento(Connection conn, String nome, String email, String cel, String animalId){
        try{
            String sql = "INSERT INTO acao (nome, email, cel, id_ani, tipo) VALUES (?, ?, ?, ?, 'apadrinhamento')";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, cel);
            stmt.setString(4, animalId);

            stmt.executeUpdate();
            return true;

        } catch(Exception e){
            return false;
        }
    }
%>