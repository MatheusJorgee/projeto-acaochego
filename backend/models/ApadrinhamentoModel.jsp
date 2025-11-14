<%@ page import="java.sql.*" %>

<%!  
    // Função para salvar o apadrinhamento na tabela "apadrinhamentos".

    public boolean salvarApadrinhamento(Connection conn, String nome, String valor, String animalId){
        try{
            String sql = "INSERT INTO apadrinhamentos (nome, valor, animal_id) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, nome);
            stmt.setString(2, valor);
            stmt.setString(3, animalId);

            stmt.executeUpdate();
            return true;

        } catch(Exception e){
            return false;
        }
    }
%>