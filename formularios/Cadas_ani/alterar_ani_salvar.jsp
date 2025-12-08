<%@page import="java.sql.*, java.util.logging.Logger, java.sql.Statement"%>
<%
    // Definindo o Logger para debug, se necessário
    // Logger log = Logger.getLogger("alterar_ani_salvar"); 
    
    String nome_antigo = request.getParameter("nome_antigo");
    String vnome_ani   = request.getParameter("nome_ani");
    String vdata_nas   = request.getParameter("data_nas");
    String vraca       = request.getParameter("raca");
    String vporte      = request.getParameter("porte");
    String vsexo       = request.getParameter("sexo");
    String vcidade     = request.getParameter("cidade");
    String vestado     = request.getParameter("estado");
    
    // Variáveis que precisam ser inicializadas fora do try para o bloco finally
    Connection con = null;
    int idCidade = 0; // Usada na lógica de cidade

    try {
        // 1. Conexão com o Banco de Dados
        String url = "jdbc:mysql://localhost:3306/projeto2?serverTimezone=UTC";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, "root", "");

        // --- LÓGICA DE INSERIR OU SELECIONAR CIDADE PARA OBTER id_cidade ---

        // 2. Tenta encontrar a cidade existente
        String sqlSelectCidade = "SELECT id_cidade FROM cidade WHERE cidade = ? AND uf = ?";
        PreparedStatement stmSelectCidade = con.prepareStatement(sqlSelectCidade);
        stmSelectCidade.setString(1, vcidade);
        stmSelectCidade.setString(2, vestado);
        ResultSet rsSelectCidade = stmSelectCidade.executeQuery();

        if (rsSelectCidade.next()) {
            // Cidade JÁ existe, pega o ID
            idCidade = rsSelectCidade.getInt("id_cidade");
        } else {
            // Cidade NÃO existe, insere a nova (usando INSERT, não UPDATE)
            String sqlInsertCidade = "INSERT INTO cidade (cidade, uf) VALUES (?, ?)";
            // IMPORTANTE: Precisa usar Statement.RETURN_GENERATED_KEYS para obter o ID
            PreparedStatement stmInsertCidade = con.prepareStatement(sqlInsertCidade, Statement.RETURN_GENERATED_KEYS);
            stmInsertCidade.setString(1, vcidade);
            stmInsertCidade.setString(2, vestado);
            stmInsertCidade.executeUpdate();

            // Obtém o ID da cidade recém-inserida
            ResultSet rsKeys = stmInsertCidade.getGeneratedKeys();
            if (rsKeys.next()) {
                idCidade = rsKeys.getInt(1);
            }
            rsKeys.close();
            stmInsertCidade.close();
        }
        rsSelectCidade.close();
        stmSelectCidade.close();
        
        // --- FIM DA LÓGICA DE CIDADE ---


        // 3. Atualiza os dados do animal (usando idCidade)
        // A query deve incluir id_cidade, mas NÃO as colunas cidade e estado
        String sql = "UPDATE animais SET nome_ani=?, data_nas=?, raca=?, porte=?, sexo=?, id_cidade=? WHERE nome_ani=?";

        PreparedStatement stmt = con.prepareStatement(sql);

        stmt.setString(1, vnome_ani);
        stmt.setString(2, vdata_nas); 
        stmt.setString(3, vraca); 
        stmt.setString(4, vporte); 
        stmt.setString(5, vsexo);
        stmt.setInt(6, idCidade);      // CHAVE ESTRANGEIRA (id_cidade)
        stmt.setString(7, nome_antigo); // Condição WHERE
        
        // O bind de parâmetros estava incorreto no seu código, excedendo o número de '?'
        // O código ORIGINAL estava tentando setar 8 parâmetros (index 1 a 8), mas a sua query
        // "UPDATE animais SET nome_ani=?, data_nas=?, raca=?, porte=?, sexo=?, cidade=?, estado=? WHERE nome_ani=?"
        // tinha 8 placeholders '?' (setando cidade e estado que não existem na tabela animais)

        int linhasAfetadas = stmt.executeUpdate();
        stmt.close();

        if (linhasAfetadas > 0) {
            out.print("<script>alert('Animal alterado com sucesso!'); window.location.href='menu_animais.jsp';</script>");
        } else {
            out.print("<script>alert('Erro: Animal com nome antigo não encontrado. Nenhuma alteração realizada.'); window.location.href='menu_animais.jsp';</script>");
        }

    } catch (Exception e) {
        // Encerra a conexão em caso de erro
        out.print("<script>alert('Erro ao salvar as alterações no banco de dados: " + e.getMessage() + "'); history.back();</script>");
        e.printStackTrace(); 
    } finally {
        // Garante que a conexão será fechada
        if (con != null) {
            try { con.close(); } catch (SQLException ignore) {}
        }
    }
%>

