<%@ page import="java.sql.*" %>

<%!  
    // Aqui ficam as funções que realmente conversam com o banco.
    // Essa função salva o pedido de adoção dentro da tabela "acao".

    public boolean salvarAdocao(Connection conn, String nome, String email, String cel, String animalId){
        try{
            // Query para inserir a adoção no banco
            String sql = "INSERT INTO acao (nome, email, cel, id_ani, tipo) VALUES (?, ?, ?, ?, 'adocao')";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Preenchendo cada ? com os valores enviados
            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, cel);
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