-- ====================================
-- SCRIPT COMPLETO DO BANCO DE DADOS
-- Projeto Acãochego
-- ====================================

CREATE DATABASE IF NOT EXISTS projeto2;
USE projeto2;

-- ====================================
-- REMOVER TABELAS EXISTENTES
-- ====================================
DROP TABLE IF EXISTS contatos;
DROP TABLE IF EXISTS acao;
DROP TABLE IF EXISTS animais;
DROP TABLE IF EXISTS cidade;
DROP TABLE IF EXISTS login;

-- ====================================
-- TABELA: login
-- ====================================
CREATE TABLE login (
    id_login INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- TABELA: cidade
-- ====================================
CREATE TABLE cidade (
    id_cidade INT PRIMARY KEY AUTO_INCREMENT,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- TABELA: animais
-- ====================================
CREATE TABLE animais (
    id_ani INT PRIMARY KEY AUTO_INCREMENT,
    nome_ani VARCHAR(50) NOT NULL,
    data_nas DATE NOT NULL,
    raca VARCHAR(50) NOT NULL,
    porte VARCHAR(50) NOT NULL,
    sexo CHAR(1) NOT NULL,
    id_cidade INT NOT NULL,

    CONSTRAINT fk_animal_cidade
        FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- TABELA: acao
-- ====================================
CREATE TABLE acao (
    id_acao INT PRIMARY KEY AUTO_INCREMENT,
    id_ani INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cel VARCHAR(20) NOT NULL,
    tipo ENUM('adocao', 'lar', 'apadrinhamento') NOT NULL,

    CONSTRAINT fk_acao_animal
        FOREIGN KEY (id_ani) REFERENCES animais(id_ani)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- TABELA: contatos
-- ====================================
CREATE TABLE contatos (
    id_contato INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    assunto VARCHAR(50) NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lido BOOLEAN DEFAULT FALSE,
    
    INDEX idx_data_envio (data_envio),
    INDEX idx_lido (lido)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- DADOS INICIAIS
-- ====================================

INSERT INTO cidade (uf, cidade) VALUES
('AC', 'Rio Branco'),
('AP', 'Macapá'),
('AM', 'Manaus'),
('PA', 'Belém'),
('RO', 'Porto Velho'),
('RR', 'Boa Vista'),
('TO', 'Palmas'),
('AL', 'Maceió'),
('BA', 'Salvador'),
('CE', 'Fortaleza'),
('MA', 'São Luís'),
('PB', 'João Pessoa'),
('PE', 'Recife'),
('PI', 'Teresina'),
('RN', 'Natal'),
('SE', 'Aracaju'),
('GO', 'Goiânia'),
('MT', 'Cuiabá'),
('MS', 'Campo Grande'),
('DF', 'Brasília'),
('ES', 'Vitória'),
('MG', 'Belo Horizonte'),
('RJ', 'Rio de Janeiro'),
('SP', 'São Paulo'),
('SP', 'Guarulhos'),
('PR', 'Curitiba'),
('SC', 'Florianópolis'),
('RS', 'Porto Alegre');

-- Inserir usuário admin (ALTERE A SENHA EM PRODUÇÃO!)
INSERT INTO login (login, senha) VALUES
('admin', 'admin123');

-- Inserir todos os animais do sistema (12 cães do dogs.js)
-- Nota: As datas de nascimento foram calculadas considerando dezembro/2024 como referência
INSERT INTO animais (nome_ani, sexo, raca, id_cidade, data_nas, porte) VALUES
-- Nanda: 3 anos (nascida em 2021)
('Nanda', 'F', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2021-12-01', 'Médio'),

-- Carminha: 13 anos e 5 meses (nascida em julho/2011)
('Carminha', 'F', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'Guarulhos' AND uf = 'SP' LIMIT 1), '2011-07-01', 'Médio'),

-- Cora: 7 anos e 9 meses (nascida em março/2017)
('Cora', 'F', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2017-03-01', 'Médio'),

-- Bono: 7 anos e 8 meses (nascido em abril/2017)
('Bono', 'M', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2017-04-01', 'Médio'),

-- Pituca: 9 anos e 6 meses (nascida em junho/2015)
('Pituca', 'F', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2015-06-01', 'Médio'),

-- Roni: 6 anos (nascido em 2018)
('Roni', 'M', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2018-12-01', 'Médio'),

-- Tony: 6 anos e 10 meses (nascido em fevereiro/2018)
('Tony', 'M', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2018-02-01', 'Médio'),

-- Chocolate: 12 anos e 10 meses (nascido em fevereiro/2012)
('Chocolate', 'M', 'Poodle', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2012-02-01', 'Pequeno'),

-- Bruna: 12 anos e 2 meses (nascida em outubro/2012)
('Bruna', 'F', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2012-10-01', 'Médio'),

-- Caramelo: 4 anos e 9 meses (nascido em março/2020)
('Caramelo', 'M', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2020-03-01', 'Médio'),

-- Mel: 13 anos e 4 meses (nascida em agosto/2011)
('Mel', 'F', 'Mestiço', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2011-08-01', 'Médio'),

-- Brown: 9 anos e 6 meses (nascida em junho/2015)
('Brown', 'F', 'SRD', (SELECT id_cidade FROM cidade WHERE cidade = 'São Paulo' AND uf = 'SP' LIMIT 1), '2015-06-01', 'Médio');


-- ====================================
-- OBSERVAÇÕES IMPORTANTES
-- ====================================
-- 1. Campo 'sexo' em animais: armazena apenas 'M' ou 'F' (CHAR(1))
-- 2. Tabela 'contatos' foi adicionada para o formulário de contato
-- 3. Todos os campos de texto usam utf8mb4_unicode_ci para suportar caracteres especiais
-- 4. Índices adicionados em 'contatos' para melhor performance nas consultas
-- 5. LEMBRE-SE: Altere as credenciais padrão em ambiente de produção!

-- ====================================
-- FIM DO SCRIPT
-- ====================================
