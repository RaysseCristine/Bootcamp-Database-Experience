create database Ecommerce;
USE Ecommerce;

-- Criar tabela Cliente
create table Cliente(
IdCliente int auto_increment primary key,
Nome varchar (45),
Identificação varchar (45),
Endereço varchar(45),
CPF varchar (11) not null,
CNPJ varchar (18),
CONSTRAINT unique_cpf_cliente UNIQUE (CPF),
CONSTRAINT unique_cnpj_cliente UNIQUE (CNPJ)
);

DESC Cliente;

-- Criar tabela Produto
create table Produto(
IdProduto int auto_increment primary key,
Categoria varchar(45),
Descrição varchar(45),
Valor float);

DESC Produto;

-- Criar tabela Pagamento
create table Pagamento(
IdPagamento int,
Cartão varchar(45),
Número varchar(45),
Boleto varchar(45),
constraint fk_pagamento_cliente foreign key (PagamentoCliente) references Cliente(idCliente)
);

DESC Pagamento;

-- Criar tabela Entrega
create table Entrega(
IdEntrega int,
Status varchar(45),
Rastreio varchar (45)
);

DESC Entrega;

-- Criar tabela Pedido
create table Pedido(
idPedido int auto_increment primary key,
StatusPedido bool default false,
Descrição varchar (45),
Frete float,
constraint fk_entrega foreign key (idPedido) references Entrega(idEntrega)
);

DESC Pedido;

-- Criar tabela Pagamento
create table Pagamento(
idPagamento int auto_increment PRIMARY KEY,
PagamentoCliente int,
Cartão varchar(45),
Número varchar(45),
Boleto varchar(45),
constraint fk_pagamento_cliente foreign key (PagamentoCliente) references Cliente(idCliente)
);

DESC Pagamento;

-- Criar tabela Estoque
create table Estoque(
IdEstoque int auto_increment primary key,
Local varchar (45)
);

DESC Estoque;

-- Produto em Estoque
create table EstoqueProduto(
IdProduto int primary key,
IdEstoqueProduto int,
Quantidade float,
constraint fk_estoque foreign key (IdProduto) references Produto (idProduto),
constraint fk_produto_estoque foreign key (IdEstoqueProduto) references Estoque (IdEstoque)
);

desc EstoqueProduto;

-- Criar tabela Fornecedor Principal
create table Fornecedor(
IdFornecedor int auto_increment primary key,
RazãoSocial varchar(45),
CNPJ varchar(18),
constraint unique_cnpj_cliente unique (CNPJ)
);

DESC Fornecedor;

-- Criar tabela Vendedor Terceiro
create table VendedorTerceiro(
IdTerceiro int auto_increment primary key,
RazãoSocial varchar(45),
Local varchar(45)
);

DESC VendedorTerceiro;

-- Criar tabela Pedido de Produto
create table PedidoProduto(
IdPedido int,
IdProduto int,
Quantidade float default 1,
constraint fk_pedido foreign key (idPedido) references VendedorTerceiro(idTerceiro),
constraint fk_produto foreign key (idProduto) references Produto(idProduto)
);

DESC PedidoProduto;

-- Criar tabela Pedido de Produto para Fornecedor Principal
create table PedidoFornecedor(
IdCompraFornecedor int,
idFornecedorPedido int,
Quantidade float default 1,
constraint fk_pedido_fornecedor foreign key (idCompraFornecedor) references Fornecedor(idFornecedor),
constraint fk_fornecedor_pedido foreign key (idFornecedorPedido) references Pedido(idPedido)
);

DESC PedidoFornecedor;

-- Criar tabela Produtos em Estoque com Fornecedor Principal
create table EstoqueFornecedor(
IdEstoqueFornecedor int,
idProdutoFornecedor int,
constraint fk_estoque_fornecedor foreign key (idEstoqueFornecedor) references Fornecedor(idFornecedor),
constraint fk_produtos_fornecedor foreign key (idProdutoFornecedor) references Produto(idProduto)
);

DESC EstoqueFornecedor;

-- Criar tabela Produtos em Estoque do Fornecedor Terceiro
create table EstoqueTerceiro(
IdProdutosEstoque int,
IdPOFornecedor int,
constraint fk_produtos_estoque foreign key (idProdutosEstoque) references Produto(idProduto),
constraint fk_po_fornecedor foreign key (idPOFornecedor) references Terceiro(idTerceiro)
);

DESC EstoqueTerceiro;

