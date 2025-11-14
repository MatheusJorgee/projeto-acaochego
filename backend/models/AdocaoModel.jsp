<%@ page import="java.sql.*" %>

<%!  
    // Aqui ficam as funções que realmente conversam com o banco.
    // Essa função salva o pedido de adoção dentro da tabela "adocoes".

    public boolean salvarAdocao(Connection conn, String nome, String email, String telefone, String animalId){
        try{
            // Query para inserir a adoção no banco
            String sql = "INSERT INTO adocoes (nome, email, telefone, animal_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Preenchendo cada ? com os valores enviados
            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, telefone);
            stmt.setString(4, animalId);

            // Executando o INSERT
            stmt.executeUpdate();
            return true;

        } catch(Exception e){
            // Se der erro, retorno false e não quebro o sistema
            return false;
        }
    }
%>