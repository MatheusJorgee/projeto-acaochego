<%@page language="java" import="java.sql.*" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 1. Verificação de Login
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/formularios/login/login.html");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    // 2. Leitura dos Parâmetros do Formulário (POST)
    if (request.getMethod().equalsIgnoreCase("POST")) {

        // Variáveis lidas do Formulário:
        String vnome_ani = request.getParameter("nome_ani");
        String vdata_nas = request.getParameter("nas");
        String vraca     = request.getParameter("raca");
        String vporte    = request.getParameter("porte");
        String vsexo     = request.getParameter("sexo");
        if (vsexo == null || vsexo.trim().isEmpty()) {
            vsexo = "";
        } else {
            String primeiraLetra = vsexo.trim().substring(0, 1).toUpperCase();
            vsexo = primeiraLetra; // salva apenas 'M' ou 'F'
        }
        String vcidade   = request.getParameter("cidade"); // Campo adicionado
        String vestado   = request.getParameter("estado"); // Campo adicionado (UF)
        
        // 3. Validação Básica
        if (vnome_ani == null || vdata_nas == null || vraca == null || vporte == null || vsexo == null || vcidade == null || vestado == null ||
            vnome_ani.isEmpty() || vdata_nas.isEmpty() || vraca.isEmpty() || vporte.isEmpty() || vsexo.isEmpty() || vcidade.isEmpty() || vestado.isEmpty()) {

            out.print("<script>alert('Algum campo está vazio! Preencha tudo.'); history.back();</script>");
            return;
        }

        Connection conexao = null;
        try {
            // Conexão com banco
            Class.forName("com.mysql.jdbc.Driver"); // Nome do Driver
            String url = "jdbc:mysql://localhost:3306/projeto2?serverTimezone=UTC";
            conexao = DriverManager.getConnection(url, "root", "");
            
            int idCidade = 0;

            // --- LÓGICA DE INSERIR OU SELECIONAR CIDADE ---

            // 4. Tenta encontrar a cidade existente
            String sqlSelectCidade = "SELECT id_cidade FROM cidade WHERE cidade = ? AND uf = ?";
            PreparedStatement stmSelectCidade = conexao.prepareStatement(sqlSelectCidade);
            stmSelectCidade.setString(1, vcidade);
            stmSelectCidade.setString(2, vestado);
            ResultSet rsSelectCidade = stmSelectCidade.executeQuery();

            if (rsSelectCidade.next()) {
                // Cidade JÁ existe, pega o ID
                idCidade = rsSelectCidade.getInt("id_cidade");
            } else {
                // Cidade NÃO existe, insere a nova
                String sqlInsertCidade = "INSERT INTO cidade (cidade, uf) VALUES (?, ?)";
                // Adicione Statement.RETURN_GENERATED_KEYS para obter o ID
                PreparedStatement stmInsertCidade = conexao.prepareStatement(sqlInsertCidade, Statement.RETURN_GENERATED_KEYS);
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

            // 5. Insere o Animal usando o idCidade obtido/gerado
            // Ajustamos a query para usar data_nas, raca, porte e id_cidade.
            String sqlAnimal = "INSERT INTO animais (nome_ani, data_nas, raca, porte, sexo, id_cidade) VALUES (?, ?, ?, ?, ?, ?)";
            
            PreparedStatement stmAnimal = conexao.prepareStatement(sqlAnimal);
            stmAnimal.setString(1, vnome_ani);
            stmAnimal.setString(2, vdata_nas); // A data já vem no formato 'AAAA-MM-DD' de input type="date"
            stmAnimal.setString(3, vraca); 
            stmAnimal.setString(4, vporte); 
            stmAnimal.setString(5, vsexo);
            stmAnimal.setInt(6, idCidade); // CHAVE ESTRANGEIRA (ID da cidade)

            stmAnimal.execute();
            stmAnimal.close();

            out.print("<script>alert('Animal cadastrado com sucesso!'); window.location='cadas_ani.jsp';</script>");
            return;

        } catch (Exception e) {
            out.print("Erro ao salvar no banco: " + e.getMessage());
            // Para debug, é útil imprimir o stack trace no console do servidor.
            // e.printStackTrace(); 
        } finally {
            // Garante que a conexão será fechada, mesmo se ocorrer um erro.
            if (conexao != null) {
                try { conexao.close(); } catch (SQLException ignore) {}
            }
        }
    }
%>
<!-- FORMULÁRIO  -->
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/fonts.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/frontend/assets/css/forms.css" />
    <title>Cadastrar Animal</title>

      <style>
.caixa input {
    width: 80%;
    padding: 12px 20px;
    border: 2px solid #84baef;
    border-radius: 25px;
    font-size: 16px;
}

.caixa select {
    width: 100%;
    padding: 12px 20px;
    border: 2px solid #84baef;
    border-radius: 25px;
    font-size: 16px;
}

    h2 {
            margin-top: 80px;
            font-size: 45px;
            color: #5aa0ff;
            text-align: center;
            margin-bottom: 15px;
        }

   </style>

   

  

<header>
        <div class="top-bar">
            <div class="container">
                 <img class="logo link"  src="<%= request.getContextPath() %>/frontend/assets/img/logo/logo-acaochego.png" alt="Logo Acãochego">

            <script>
            document.querySelector('.logo.link').addEventListener('click', () => {
                window.location.href = "<%= request.getContextPath() %>/formularios/Cadas_ani/menu_animais.jsp";
            });
            </script>

                <div class="name-slogan">
                    <p class="name">ACÃOCHEGO</p>
                    <p class="slogan">
                        ASSOCIAÇÃO PROTETORA DE ANIMAIS ABANDONADOS - ACÃOCHEGO
                    </p>
                </div>

               

                    <button class="menu-toggle" aria-label="Abrir menu">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                </div>
            </div>
        </div>

        <nav class="menu">
            <ul>
                <li><a href="index.html">Início</a></li>
                <li><a href="pages/sobre-nos.html">A Acãochego</a></li>
                <li><a href="adocao.html">Quero Adotar</a></li>
                <li><a href="pages/apadrinhamento.html">Quero Apadrinhar</a></li>
                <li><a href="pages/">Preciso de Ajuda</a></li>
                <li><a href="#">Matérias</a></li>
                <li><a href="#">Finais Felizes</a></li>
                <li><a href="#">Tributo</a></li>
            </ul>
        </nav>
        <div class="line"></div>
    </header>




<body style="background-image: url('<%= request.getContextPath() %>/frontend/assets/img/background_patas.png');">
  
 

<h2>Cadastro de Novo Animal</h2>

<form method="POST" action="cadas_ani.jsp">

    <div class="grupo-cx">

          <div class="caixa">
            <label>Nome do Animal</label>
            <input type="text" name="nome_ani" required>
        </div>

       <div class="caixa">
            <label for="nas">Data de Nascimento</label>
            <input id="nas" type="date" name="nas" placeholder="Obrigatório" required>
        </div>

        <div class="caixa">
                <label for="raca"> Raça</label>
                <select name="raca" class="caixa">
                    <option value="SRD">SRD</option>
                    <option value="PUG">Pug</option>
                    <option value="Pitbull">Pitbull</option>
                    <option value="Chihuahua">Chihuahua</option>
                    <option value="Pinscher">Pinscher</option>
                    <option value="Chow-Chow">Chow-Chow</option>
                    <option value="Pastor">Pastor Alemão</option>
                    <option value="Rottweiler">Rottweiler</option>
                </select>
                </div>

         <div class="caixa">
            <label>Sexo</label>
            <input type="text" name="sexo" required>
        </div>

        <div class="caixa">
                <label for="porte"> Porte</label>
                <select name="porte" class="caixa">
                    <option value="Filhote">Filhote</option>
                    <option value="Pequeno">Porte Pequeno</option>
                    <option value="medio">Porte Médio</option>
                    <option value="grande">Porte Grande</option>
                </select>
                </div>

        <div class="caixa">
            <label>Cidade</label>
            <input type="text" name="cidade" required>
        </div>

            <div class="caixa">
                <label for="estado"> Estado</label>
                <select name="estado" class="caixa">
                    <option value="RJ">RJ</option>
                    <option value="PR">PR</option>
                    <option value="MG">MG</option>
                    <option value="RS">RS</option>
                    <option value="SC">SC</option>
                    <option value="BA">BA</option>
                    <option value="ES">ES</option>
                    <option value="GO">GO</option>
                    <option value="DF">DF</option>
                    <option value="MA">MA</option>
                    <option value="MT">MT</option>
                    <option value="MS">MS</option>
                    <option value="MG">MG</option>
                    <option value="PA">PA</option>
                    <option value="PB">PB</option>
                    <option value="PR">PR</option>
                    <option value="PE">PE</option>
                    <option value="PI">PI</option>
                    <option value="RJ">RJ</option>
                    <option value="RN">RN</option>
                    <option value="RS">RS</option>
                    <option value="RO">RO</option>
                    <option value="RR">RR</option>
                    <option value="SC">SC</option>
                    <option value="SP">SP</option>

                </select>
                </div>

      
        <div class="btn-container2">
            <button type="submit">Cadastrar</button>
        </div>


</form>

</body>
</html>
