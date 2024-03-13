create database Oficina;
USE Oficina;

DROP DATABASE Oficina;

-- VEICULO
CREATE TABLE Veiculo(
	idVeiculo INT auto_increment PRIMARY KEY,
    idRevisão INT,
    Placa CHAR(7) NOT NULL,
    CONSTRAINT placa_idVeiculo UNIQUE (idVeiculo, Placa)
);

ALTER TABLE Veiculo ADD CONSTRAINT fk_eq_mecanicos FOREIGN KEY (idVeiculo) REFERENCES EqMecanicos(idEqMecanicos),
ADD CONSTRAINT fk_conserto FOREIGN KEY (idVeiculo) REFERENCES Conserto(idConserto),
ADD CONSTRAINT fk_revisao FOREIGN KEY (idRevisão) REFERENCES Revisão(idRevisão);

DESC Veiculo;

-- CLIENTES
CREATE TABLE Clientes(
	idClientes INT auto_increment PRIMARY KEY,
    idVeiculo INT,
    CONSTRAINT fk_veiculo FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo)
);

DESC Clientes;

-- PESSOA FISICA
CREATE TABLE PessoaFisica(
	idPessoaFisica INT auto_increment PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Endereço VARCHAR(45),
    Contato CHAR(11)
);

ALTER TABLE PessoaFisica ADD CONSTRAINT unique_cpf_PessoaFisica UNIQUE (CPF);

ALTER TABLE PessoaFisica ADD CONSTRAINT fk_idClientes_pf FOREIGN KEY (idPessoaFisica) REFERENCES Clientes(idClientes),
ADD CONSTRAINT fk_clinte_pf FOREIGN KEY (idPessoaFisica) REFERENCES Clientes(idClientes),
ADD CONSTRAINT fk_veiculo_pf FOREIGN KEY (idPessoaFisica) REFERENCES Veiculo(idVeiculo);

DESC PessoaFisica;

-- PESSOA JURIDICA
CREATE TABLE PessoaJuridica(
	idPessoaJuridica INT auto_increment PRIMARY KEY,
    RazaoSocial VARCHAR(45) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Endereço VARCHAR(45),
    Contato CHAR(11),
    CONSTRAINT unique_cnpj_PessoaJuridica UNIQUE (CNPJ)
);

ALTER TABLE PessoaJuridica ADD CONSTRAINT fk_clientes_pj FOREIGN KEY (idPessoaJuridica) REFERENCES Clientes(idClientes),
ADD CONSTRAINT fk_veiculo_pj FOREIGN KEY (idPessoaJuridica) REFERENCES Veiculo(idVeiculo);

DESC PessoaJuridica;

-- CONSERTO
CREATE TABLE Conserto(
	idConserto INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45) NOT NULL
);

DESC Conserto;

-- REVISÃO
CREATE TABLE Revisão(
	idRevisão INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45) NOT NULL
);

DESC Revisão;

-- MECANICO
CREATE TABLE Mecanico(
	idMecanico INT auto_increment PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Endereço VARCHAR(45) NOT NULL,
    Especialidade VARCHAR(45) NOT NULL
);

DESC Mecanico;

-- EQUIPE MECÂNICOS
CREATE TABLE EqMecanicos(
	idEqMecanicos INT auto_increment PRIMARY KEY
);

ALTER TABLE EqMecanicos ADD CONSTRAINT fk_Mecanicos FOREIGN KEY (idEqMecanicos) REFERENCES Mecanico(idMecanico);
ALTER TABLE OdServiço ADD CONSTRAINT fk_OdServiço FOREIGN KEY (idOdServiço) REFERENCES OdServiço(idOdServiço);

DESC EqMecanicos;

-- ORDEM DE SERVIÇO
CREATE TABLE OdServiço(
	idOdServiço INT auto_increment PRIMARY KEY,
    DataEmissão DATE,
    ValorServiço FLOAT NOT NULL,
    ValorPeça FLOAT NOT NULL,
    ValorTotal FLOAT NOT NULL,
    Status ENUM('AGUARDANDO', 'EM ANDAMENTO', 'CONCLUIDO', 'CANCELADO'),
    DataConclusão DATE
);

SELECT * FROM OdServiço ORDER BY DataEmissão;
SELECT * FROM OdServiço ORDER BY ValorTotal;
DESC OdServiço;

-- REFERENCIA DE PREÇOS
CREATE TABLE TabelaValores(
	idTabelaValores INT auto_increment PRIMARY KEY,
    CONSTRAINT fk_tabela_precos FOREIGN KEY (idTabelaValores) REFERENCES OdServiço(idOdServiço)
);

DESC TabelaValores;

-- AUTORIZAÇÃO CLIENTE
CREATE TABLE Autorização(
	idAutorização INT auto_increment PRIMARY KEY,
	Autorizado BOOL DEFAULT FALSE,
    CONSTRAINT fk_autorização_cliente FOREIGN KEY (idAutorização) REFERENCES Clientes(idClientes),
    CONSTRAINT fk_autorização_veiculo FOREIGN KEY (idAutorização) REFERENCES Veiculo(idVeiculo),
    CONSTRAINT fk_autorização_OdServiço FOREIGN KEY (idAutorização) REFERENCES OdServiço(idOdServiço)
);

DESC Autorização;

-- PEÇAS
CREATE TABLE Pecas(
	idPecas INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45),
    Valor FLOAT NOT NULL
);

DESC Pecas;

-- OS PEÇAS
CREATE TABLE OsPecas(
	idOsPecas INT auto_increment PRIMARY KEY,
	CONSTRAINT fk_pecas FOREIGN KEY (idOsPecas) REFERENCES Pecas(idPecas),
    CONSTRAINT fk_os_pecas FOREIGN KEY (idOsPecas) REFERENCES OdServiço(idOdServiço)
);

DESC OsPecas;

-- SERVIÇOS
CREATE TABLE Serviços(
	idServiços INT auto_increment PRIMARY KEY,
    Descrição VARCHAR(45),
    Valor FLOAT NOT NULL
);

DESC Serviços;

-- ORDEM DE SERVIÇO
CREATE TABLE OdServiço(
	idOdServiço INT auto_increment PRIMARY KEY,
    CONSTRAINT fk_serviços FOREIGN KEY (idOdServiço) REFERENCES Serviços(idServiços),
    CONSTRAINT fk_os_serviços FOREIGN KEY (idOdServiço) REFERENCES OdServiço(idOdServiço)
);

DESC OdServiço;

