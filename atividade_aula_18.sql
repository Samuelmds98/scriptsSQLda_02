CREATE TABLE aula_18.funcionario
(
    id serial,
    ultimo_nome character varying,
    primeiro_nome character varying,
    titulo character varying,
    apelido character varying,
    data_nascimento date,
    data_contratacao date,
    endereco character varying,
    cidade character varying,
    regiao character varying,
    cep character varying,
    pais character varying,
    telefone character varying,
    ddd character varying,
    foto bytea,
    observacoes character varying,
    caminho_foto character varying,
    PRIMARY KEY (id)
);

CREATE TABLE aula_18.categoria
(
    id serial,
    nome character varying,
    descricao character varying,
    imagem bytea,
    PRIMARY KEY (id)
);

CREATE TABLE aula_18.transportadora
(
    id serial,
    nome character varying,
    telefone character varying,
    PRIMARY KEY (id)
);

CREATE TABLE aula_18.fornecedor
(
    id serial,
    nome_empresa character varying,
    nome_contato character varying,
    titulo_contato character varying,
    endereco character varying,
    cidade character varying,
    regiao character varying,
    cep character varying,
    pais character varying,
    telefone character varying,
    fax character varying,
    site character varying,
    PRIMARY KEY (id)
);

CREATE TABLE aula_18.produtos
(
    id serial,
    nome character varying,
    id_transportadora integer,
    id_categoria integer,
    quantidade integer,
    preco_unitario numeric(18,2),
    unidades_em_estoque integer,
    unidades_em_ordem integer,
    nivel_abastecimento integer,
    interrompido boolean,
    PRIMARY KEY (id)
    ,
    CONSTRAINT id_categoriafk FOREIGN KEY (id_categoria)
        REFERENCES aula_18.categoria (id) MATCH SIMPLE
        ,
    CONSTRAINT id_transportadorafk FOREIGN KEY (id_transportadora)
        REFERENCES aula_18.transportadora (id) MATCH SIMPLE
      
);

CREATE TABLE aula_18.cliente
(
    id serial,
    nome_empresa character varying,
    nome_contato character varying,
    titulo_contato character varying,
    endereco character varying,
    cidade character varying,
    regiao character varying,
    cep character varying,
    pais character varying,
    telefone character varying,
    fax character varying,
    PRIMARY KEY (id)
);

CREATE TABLE aula_18.regiao
(
    id serial,
    nome character varying,
    PRIMARY KEY (id)
);

CREATE TABLE aula_18.pedido
(
    id serial,
    id_cliente integer,
    id_funcionario integer,
    data_pedido date,
    data_requerida date,
    data_envio date,
    id_transportadora integer,
    frete boolean,
    nome_navio character varying,
    endereco_navio character varying,
    cidade_navio character varying,
    regiao_navio character varying,
    cep_navio character varying,
    pais_navio character varying,
    PRIMARY KEY (id),

CONSTRAINT id_clientefk FOREIGN KEY (id_cliente)
 	REFERENCES aula_18.cliente (id) MATCH SIMPLE
,
CONSTRAINT id_funcionariofk FOREIGN KEY (id_funcionario)
 	REFERENCES aula_18.funcionario (id) MATCH SIMPLE
,
CONSTRAINT id_transportadorafk FOREIGN KEY (id_transportadora)
 	REFERENCES aula_18.transportadora (id) MATCH SIMPLE

);

CREATE TABLE aula_18.territorio
(
    id serial,
    nome character varying,
    id_regiao integer,
    PRIMARY KEY (id)
,
CONSTRAINT id_regiaofk FOREIGN KEY (id_regiao)
 	REFERENCES aula_18.regiao (id) MATCH SIMPLE
);

CREATE TABLE aula_18.funcionario_territorio
(
    id_funcionario integer,
    id_territorio integer,
    CONSTRAINT id_funcionariofk FOREIGN KEY (id_funcionario)
        REFERENCES aula_18.funcionario (id) MATCH SIMPLE
   ,
    CONSTRAINT id_territoriofk FOREIGN KEY (id_territorio)
        REFERENCES aula_18.territorio (id) MATCH SIMPLE
 
);

CREATE TABLE aula_18.pedido_detalhe
(
    id_pedido integer,
    id_produto integer,
    preco_unitario numeric,
    quantidade integer,
    desconto numeric(2,2),
    CONSTRAINT id_pedido FOREIGN KEY (id_pedido)
        REFERENCES aula_18.pedido (id) MATCH SIMPLE
  ,
    CONSTRAINT id_produto FOREIGN KEY (id_produto)
        REFERENCES aula_18.produtos (id) MATCH SIMPLE
   
);

--INSERTS TABELA categoria--
INSERT INTO aula_18.categoria(nome, descricao, imagem) VALUES('higiene pessoal','limpeza pessoal','imagem 1');
INSERT INTO aula_18.categoria(nome, descricao, imagem) VALUES('bebidas','líquidos','imagem 2');
INSERT INTO aula_18.categoria(nome, descricao, imagem) VALUES('produtos de limpeza','limpeza de ambientes','imagem 3');
INSERT INTO aula_18.categoria(nome, descricao, imagem) VALUES('hortifruti','produtos naturais','imagem 4');
INSERT INTO aula_18.categoria(nome, descricao, imagem) VALUES('padaria','lanches','imagem 5');

--INSERTS TABELA fornecedor--
insert into aula_18.fornecedor (nome_empresa,nome_contato,titulo_contato,endereco,cidade,regiao,cep,pais,telefone,fax,site) values ('Alimenticia','Sandro Lucio','Sr','Rua Santos Dumont, 123','Fortaleza','Nordeste','60111-000','Brasil','85 3232 1111','85 3223 1122','www.alimenticia@gmail.com');
insert into aula_18.fornecedor (nome_empresa,nome_contato,titulo_contato,endereco,cidade,regiao,cep,pais,telefone,fax,site) values ('Automotiva','Tales Santos','Sr','Av. Rui Barbosa, 456','Manaus','Norte','59111-321','Brasil','87 3233 3214','87 3233 1234','www.automotiva@hotmail.com');
insert into aula_18.fornecedor (nome_empresa,nome_contato,titulo_contato,endereco,cidade,regiao,cep,pais,telefone,fax,site) values ('Papelaria','Cecilia Matos','Sra','Rua Contorno Leste, 935','Diadema','Sudeste','85612-111','Brasil','88 3288 6548','85 3288 6547','www.papelaria@gmail.com');
insert into aula_18.fornecedor (nome_empresa,nome_contato,titulo_contato,endereco,cidade,regiao,cep,pais,telefone,fax,site) values ('Construção','Tiago Jorge','Sr','Rua Senador Pompeu, 87','São Paulo','Sudeste','65654-222','Brasil','83 3598 1254','85 3588 7423','www.construcao@gmail.com');
insert into aula_18.fornecedor (nome_empresa,nome_contato,titulo_contato,endereco,cidade,regiao,cep,pais,telefone,fax,site) values ('Grafica','Alberto Meneses','Sr','Rua Brasil, 12','Porto Alegre','Sul','62333-000','Brasil','98 3158 6598','98 3157 3654','www.grafica@gmail.com');

--INSERTS TABELA cliente--
INSERT INTO aula_18.cliente(nome_empresa, nome_contato, titulo_contato, endereco, cidade, regiao, cep, pais, telefone, fax) values ('Ducor Representações', 'Roberta', 'Sra', 'Rua Carlos Vasconcelos 2459', 'Fortaleza', 'Nordeste', 60115171, 'Brasil', 8532465449, 8532465449);
INSERT INTO aula_18.cliente(nome_empresa, nome_contato, titulo_contato, endereco, cidade, regiao, cep, pais, telefone, fax) values ('Ligcel Telefonia', 'Georgia', 'Sra', 'Av Costa Barros 1640', 'Fortaleza', 'Nordeste', 60023045, 'Brasil', 8532442323, 8532442323);
INSERT INTO aula_18.cliente(nome_empresa, nome_contato, titulo_contato, endereco, cidade, regiao, cep, pais, telefone, fax) values ('Smart Tic', 'Erik', 'Sr', 'Av Antonio Sales 1885', 'Fortaleza', 'Nordeste', 60055203, 'Brasil', 8532671613, 8532671613);
INSERT INTO aula_18.cliente(nome_empresa, nome_contato, titulo_contato, endereco, cidade, regiao, cep, pais, telefone, fax) values ('Trust Control', 'Alberto', 'Sr', 'Rua Dragão do Mar 2334', 'Fortaleza', 'Nordeste', 60003541, 'Brasil', 8530213333, 8530213333);
INSERT INTO aula_18.cliente(nome_empresa, nome_contato, titulo_contato, endereco, cidade, regiao, cep, pais, telefone, fax) values ('Mercadinho Sao Luiz', 'Flavia', 'Sra', 'Av Santos Dumont 3456', 'Fortaleza', 'Nordeste', 60032145, 'Brasil', 8530332529, 8530332529);

--INSERTS TABELA transportadora--
INSERT INTO aula_18.transportadora(nome, telefone) VALUES ('AA transportes', '99999998');
INSERT INTO aula_18.transportadora(nome, telefone) VALUES ('BB transportes', '99999997');
INSERT INTO aula_18.transportadora(nome, telefone) VALUES ('DD transportes', '99999996');
INSERT INTO aula_18.transportadora(nome, telefone) VALUES ('CC transportes', '99999995');
INSERT INTO aula_18.transportadora(nome, telefone) VALUES ('EF transportes', '99999995');

--INSERTS TABELA funcionario--
INSERT INTO aula_18.funcionario(id, ultimo_nome, primeiro_nome , titulo , apelido, data_nascimento,  data_contratacao, endereco, cidade, regiao, cep,  pais, telefone,  ddd, foto, observacoes,caminho_foto) values (1,'Pimentel','Pablo ','Diretor','Big Boss','1997-03-01','23--04--2023', 'Rua A', 'Fortaleza', 'R1', '00000-000', 'Brasil', '988885555', '85', 'sim', 'Apenas o Dono', 'http:\\tem_uma_foto.com\png');
INSERT INTO aula_18.funcionario(id, ultimo_nome, primeiro_nome , titulo , apelido, data_nascimento, data_contratacao, endereco, cidade, regiao, cep, pais, telefone, ddd, foto, observacoes, caminho_foto) values (2, 'Rocha', 'Diego', 'Gerente', 'Boss', '1994-03-01', '23--04--2023', 'Rua B', 'Fortaleza', 'R1', '00000-000', 'Brasil', '988884444', '85', 'sim', 'Gerente de Negócios', 'http:\\tem_uma_foto.com\png');
INSERT INTO aula_18.funcionario(id, ultimo_nome, primeiro_nome , titulo , apelido, data_nascimento, data_contratacao, endereco, cidade, regiao, cep, pais, telefone, ddd, foto, observacoes) values (3, 'Soraya', 'Sandra', 'Gerente de Tecnologia', 'Boss', '1994-02-28', '23--04--2023', 'Rua HA', 'Fortaleza', 'R3', '00000-111', 'Brasil', '998985555', '85', 'não', 'A DBA da Empresa');
INSERT INTO aula_18.funcionario(id, ultimo_nome, primeiro_nome , titulo , apelido, data_nascimento, data_contratacao, endereco, cidade, regiao, cep, pais, telefone, ddd, foto, observacoes, caminho_foto) values (4, 'Pacheco', 'Eliano', 'Coordenador', 'Eliano', '1999-04-01', '23--04--2023', 'Rua 5', 'Fortaleza', 'R5', '00000-222', 'Brasil', '986555555', '85', 'sim', 'Coordenador', 'http:\\tem_uma_foto.com\png');
INSERT INTO aula_18.funcionario(id, ultimo_nome, primeiro_nome , titulo , apelido, data_nascimento, data_contratacao, endereco, cidade, regiao, cep, pais, telefone, ddd, foto, caminho_foto) values (5, 'Pacheco', 'Caio', 'Auxiliar Administrativo', 'Caio', '1999-04-01', '23--04--2023', 'Rua 5', 'Fortaleza', 'R5', '00000-222', 'Brasil', '999222222', '85', 'sim', 'http:\\tem_uma_foto.com\png');

--INSERTS TABELA regiao--
INSERT INTO aula_18.regiao (nome) VALUES ('Ceará');
INSERT INTO aula_18.regiao (nome) VALUES ('São Paulo');
INSERT INTO aula_18.regiao (nome) VALUES ('Rio Grande do Sul');
INSERT INTO aula_18.regiao (nome) VALUES ('Rio de janeiro');
INSERT INTO aula_18.regiao (nome) VALUES ('Curitiba');

--INSERTS TABELA produtos--
INSERT INTO aula_18.produtos(nome,id_categoria,id_transportadora,quantidade,preco_unitario,unidades_em_estoque,unidades_em_ordem,nivel_abastecimento,interrompido) VALUES('papel higienico',1,1,1.100,18.00,30,4,4,false);                                                                
INSERT INTO aula_18.produtos(nome,id_categoria,id_transportadora,quantidade,preco_unitario,unidades_em_estoque,unidades_em_ordem,nivel_abastecimento,interrompido) VALUES('cerveja',2,2,2.200,5.50,4000,10,6,false);                                                                     
INSERT INTO aula_18.produtos(nome,id_categoria,id_transportadora,quantidade,preco_unitario,unidades_em_estoque,unidades_em_ordem,nivel_abastecimento,interrompido) VALUES('escova',3,1,3.300,15.00,50,10,1,false);                                                                     
INSERT INTO aula_18.produtos(nome,id_categoria,id_transportadora,quantidade,preco_unitario,unidades_em_estoque,unidades_em_ordem,nivel_abastecimento,interrompido) VALUES('frutas',4,4,4.350,3.00,4,10,3,false);                                                                     
INSERT INTO aula_18.produtos(nome,id_categoria,id_transportadora,quantidade,preco_unitario,unidades_em_estoque,unidades_em_ordem,nivel_abastecimento,interrompido) VALUES('pao',5,5,5,500,21.50,100,10,7,false);

--INSERTS TABELA territorio--
INSERT INTO aula_18.territorio (nome,id_regiao) VALUES ('ab',1);
INSERT INTO aula_18.territorio (nome,id_regiao) VALUES ('bc',2);
INSERT INTO aula_18.territorio (nome,id_regiao) VALUES ('cd',3);
INSERT INTO aula_18.territorio (nome,id_regiao) VALUES ('de',4);
INSERT INTO aula_18.territorio (nome,id_regiao) VALUES ('ef',5);

--INSERTS TABELA funcionario_territorio--
INSERT INTO aula_18.funcionario_territorio(id_funcionario,id_territorio) VALUES(1,1);
INSERT INTO aula_18.funcionario_territorio(id_funcionario,id_territorio) VALUES(2,2);
INSERT INTO aula_18.funcionario_territorio(id_funcionario,id_territorio) VALUES(3,3);
INSERT INTO aula_18.funcionario_territorio(id_funcionario,id_territorio) VALUES(4,4);
INSERT INTO aula_18.funcionario_territorio(id_funcionario,id_territorio) VALUES(5,5);

--INSERTS TABELA pedido--
INSERT INTO aula_18.pedido(id_cliente, id_funcionario, data_pedido, data_requerida, data_envio, id_transportadora, frete, nome_navio, endereco_navio, cidade_navio, regiao_navio, cep_navio, pais_navio) values (1, 3, '2001-01-02', '2001-01-03', '2001-01-05', 4, true, 'navio01', 'rua portugal', 'niteroi', 'sudeste', '60000000', 'brasil');
INSERT INTO aula_18.pedido(id_cliente, id_funcionario, data_pedido, data_requerida, data_envio, id_transportadora, frete, nome_navio, endereco_navio, cidade_navio, regiao_navio, cep_navio, pais_navio) values (2, 1, '2001-01-05', '2001-01-06', '2001-01-10', 2, false, 'navio02', 'rua atlantica', 'macae', 'sudeste', 60000001, 'brasil');
INSERT INTO aula_18.pedido(id_cliente, id_funcionario, data_pedido, data_requerida, data_envio, id_transportadora, frete, nome_navio, endereco_navio, cidade_navio, regiao_navio, cep_navio, pais_navio) values (3, 4, '2001-01-06', '2001-01-15', '2001-01-16', 3, false, 'navio03', 'rua vieira', 'mesquita', 'sudeste', 60000002, 'brasil');
INSERT INTO aula_18.pedido(id_cliente, id_funcionario, data_pedido, data_requerida, data_envio, id_transportadora, frete, nome_navio, endereco_navio, cidade_navio, regiao_navio, cep_navio, pais_navio) values (4, 5, '2001-01-09', '2001-01-22', '2001-01-25', 1, true, 'navio04', 'rua rio branco', 'quatis', 'sudeste', 60000003, 'brasil');
INSERT INTO aula_18.pedido(id_cliente, id_funcionario, data_pedido, data_requerida, data_envio, id_transportadora, frete, nome_navio, endereco_navio, cidade_navio, regiao_navio, cep_navio, pais_navio) values (5, 2, '2001-01-10', '2001-01-13', '2001-01-15', 5, true, 'navio05', 'rua pessoa', 'saquarema', 'sudeste', '60000004', 'brasil');

--INSERTS TABELA pedido_detalhe--
INSERT INTO aula_18.pedido_detalhe(id_pedido, id_produto, preco_unitario, quantidade, desconto) VALUES(1,1,3.75,1,0.29);
INSERT INTO aula_18.pedido_detalhe(id_pedido, id_produto, preco_unitario, quantidade, desconto) VALUES(2,2,3.75,2,0.10);
INSERT INTO aula_18.pedido_detalhe(id_pedido, id_produto, preco_unitario, quantidade, desconto) VALUES(3,3,3.75,3,0.52);
INSERT INTO aula_18.pedido_detalhe(id_pedido, id_produto, preco_unitario, quantidade, desconto) VALUES(4,4,3.75,5,0.17);
INSERT INTO aula_18.pedido_detalhe(id_pedido, id_produto, preco_unitario, quantidade, desconto) VALUES(5,5,3.75,8,0.10);



--CRIANDO UM DATA MART
