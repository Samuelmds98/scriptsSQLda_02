Estudo sql

SELECT conluna1, coluna2, conluna_n
FROM tabela
WHERE condicao
/*
OPERADOR
=
>
<
>=
<=
<>  diferente de
AND
OR
*/

SELECT *
FROM Production.Product
WHERE color = 'blue' or color = 'black'
--todos os prudotos azuis ou pretos



SELECT *
FROM Person.Person
WHERE LastName = 'miller' and LastName = 'anna'
--todos os sobrenomes miller e anna


SELECT *
FROM Production.Product
WHERE ListPrice > 1500
--todos os produtos maiores que 1500

SELECT *
FROM Production.Product
WHERE ListPrice > 1500 and ListPrice < 5000
--todos os produtos entre 1500 e 5000

SELECT *
FROM Production.Product
WHERE color <> 'red'
-- todos os produtos que nao sejam vermelhos

SELECT *
FROM Production.Product
WHERE Weight >= 500 and Weight <= 700
-- todas as peças que pesam entre 500 e 700 kg

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'm' and SalariedFlag = 1
-- funcionarios casados e assalriados

SELECT *
FROM person.Person
where FirstName = 'Peter' and LastName = 'Krebs'
-- achar um funcionario e verificar a id
SELECT *
FROM Person.EmailAddress
WHERE BusinessEntityID = 26
-- pela id achar o email

-- COUNT
-- NUMERO DE LINHAS NA TABELA
SELECT (*) --PODE SER COLOCADO TAMBEM DE UMA COLUNA , SE COLOCAR DISTINCT TIRA AS LINHAS NULAS
FROM TABELA

SELECT count(*)
FROM person.Person
--numero de linhas na tabela

SELECT count(DISTINCT title)
FROM person.Person
--numero de titulos distintos na tabela

SELECT count(*)
FROM Production.Product
-- numero de produtos na tabela de produtos

SELECT count(size)
FROM Production.Product
-- quantidade de tamanhos cadastrados

SELECT count(DISTINCT size)
FROM Production.Product
-- quantidade de tamanhos cadastrados unicos

-- TOP
SELECT TOP 10 *  --AS PRIMEIRAS DEZ ENTRADAS
FROM TABELA

-- ORDER BY
SELECT *
FROM tabela
ORDER BY coluna1 asc/desc -- ordernar em ordem crescente ou decrescente de acordo com a coluna

SELECT *
FROM Person.Person
ORDER BY FirstName desc -- EM ORDEM CRESCENTE

SELECT *
FROM Person.Person
ORDER BY FirstName asc , LastName desc --primeiro nome em ordem crescente e o ultimo em ordem decrescente

SELECT TOP 10 ProductID, ListPrice -- aparacer somente essas duas colunas
FROM Production.Product -- tabela
ORDER BY ListPrice desc  --colocar em ordem decrescente

SELECT TOP 4 name, ProductNumber
FROM Production.Product
ORDER BY ProductID asc 
-- o nome e o numero dos primeiro 4 produtos em ordem crescente

-- BETWEEN (entre)
-- é usado pra encontrar valores entre um valor minimo e maximo
SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 100 and 1500

SELECT *
FROM Production.Product
WHERE ListPrice NOT BETWEEN 100 and 1500 -- exclui esse intervalo

SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2009/01/01' and '2010/01/01' --pessoas contratada nesse periodo
ORDER BY HireDate

-- IN
-- O OPERADOR IN É USADO JUNTO COM O WHERE
-- PARA VERIFICAR SE UM VALOR CORRESPONDE A QUALQUER VALOR PASSADO NA LISTA DE VALORES
SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (2,7,13) --A VIRGULA É OU

SELECT *
FROM Person.Person
WHERE BusinessEntityID NOT IN (2,7,13) --TODOS MENOS O 2,7,13

--LIKE
--encontrar algo ou alguem usando parte dos valores, por exemplo Dan, vai retornar tudo que contem Dan (danilo, daniel...)
SELECT *
FROM Person.Person
WHERE FirstName like 'dan%' --inicia com dan, 
--%dan finaliza com dan,
--%dan% se encontrar no inicio ou no fim
--%dan_ ele encontra que termina com dan mas que contenha so mais uma letra no fim

--1 quantos produtos temos cadastrados no sistema que custam mais de 1500 dolares?
SELECT COUNT(ListPrice)
FROM Production.Product
WHERE ListPrice NOT BETWEEN 0 and 1500
--WHERE ListPrice > 1500

-- Quantas Pessoas temos com o Sobrenome que inicia com a litra P
SELECT COUNT(LastName)
From person.person
WHERE LastName like 'P%'

-- Em quantas cidades unicas estao cadastrados nossos clientes.
SELECT COUNT (DISTINCT City)
From person.Address

-- QUAIS SAO AS CIDADES UNICAS CADASTRADOS NO NOSSO SITEMA
SELECT DISTINCT City
From person.Address

-- QUANTOS PRODUTOS VERMELHOS TEM PRECO ENTRE 500 A 1000 DOLARES
SELECT COUNT(*)
FROM Production.Product
WHERE color = 'red' 
AND	ListPrice BETWEEN 500 AND 1000

-- QUANTOS PRODUTOS CADASTRADOS TEM A PALAVRA ROAD NO NOME DELES?
SELECT COUNT(*)
FROM Production.Product
WHERE Name like '%road%' 

-- FUNÇÕES DE AGREGACAO MIN MAX SUM AVG
-- funcoes de agregação agregam ou combinam dados de uma tabela em 1 resultado
-- o 'as' da apelido a funcao
SELECT TOP 10 sum(linetotal) as "soma" -- funcao de soma
FROM Sales.SalesOrderDetail

SELECT TOP 10 min(linetotal) as "menor"  --menor valor
FROM Sales.SalesOrderDetail

SELECT TOP 10 max(linetotal) as "maxvalor" --valor maximo
FROM Sales.SalesOrderDetail

SELECT TOP 10 avg(linetotal) as "media" --valor medio
FROM Sales.SalesOrderDetail

--GROUP BY
-- divide o resultado da pesquisa em grupos
SELECT coluna1, funcaoAgregacao(coluna2)
FROM nomeTabela
GROUP BY conluna1

SELECT SpecialOfferId, SUM(UnitPrice) as "SOMA"
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
-- ORDER BY SpecialOfferID asc
--ele pega o item de uma coluna e agrega tudo de outra coluna usando ela como referencia
-- SpecialOfferId é uma id de oferta, onde foi usado em varias vendas, 
-- entao elepega os valores da coluna UnitPrice e soma e diz a soma total dos produtos que tiveram 
-- aquela pecialOfferId.

SELECT ProductID, COUNT(ProductID) as "CONTAGEM"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
--QUANTOS PRODUTOS FORAM VENDIDOS DE CADA ITEM

SELECT Color, avg(ListPrice) as "Media_Preco"
FROM Production.Product
WHERE Color = 'silver'
GROUP BY Color
--media de preco dos produtos cinza

-- QUANTAS PESSOAS TEM O MESMO MIDDLENAME AGRUPADAS POR MIDDLENAME
SELECT MiddleName, COUNT(MiddleName) AS "Contagem"
FROM Person.Person
GROUP BY MiddleName

--QUANTIDADE MEDIA EM QUE CADA PRODUTO É VENDIDO NA LOJA
SELECT ProductID, avg(OrderQty) as "Qtd_Media"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY ProductID asc

--QUAIS FORAM AS 10 VENDAS QUE NO TOTAL TIVERAM OS MAIORES VALORES DE VENDA(LINE TOTAL) POR 
--PRODUTO DO MAIOR VALOR PARA O MENOR
SELECT TOP 10 ProductID, sum(LineTotal) as "Soma"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY Soma desc

--QUANTOS PRODUTOS E QUA A QUANTIDADE MEDIA DE PRODUTOS TEMOS CADASTRADOS
-- NAS NOSSAS ORDEM DE SERVICO (WORKORDER, AGRUPADOS POR ID)
SELECT ProductID, COUNT(ProductID) as "Contagem", avg(OrderQty) as "Media"
FROM Production.WorkOrder
GROUP BY ProductID
ORDER BY ProductID

--HAVING
-- SERVE PARA FILTRAR OS DADOS QUE JA ESTAO AGRUPADOS
--É COMO UM WHERE PARA DADOS AGRUPADOS
SELECT coluna1, funcaoAgregacao(coluna2)
FROM nomeTabela
GROUP BY coluna1
HAVING condicao
-- a diferenca entre o HAVING e WHERE
-- é que o group by é aplicado depois que os dados ja foram agrupados, enquanto o
-- WHERE é aplicado antes dos dados serem agrupados

--quais nomes no sistema tem uma ocorrencia maior que 10 vezes
SELECT FirstName, count(FirstName) as "quantidade"
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) > 10

-- QUAIS PRODUTOS QUE NO TOTAL DE VENDAS ESTAO ENTRE 162K E 500K
SELECT ProductID, SUM(LineTotal) as "SOMA"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING sum(LineTotal) BETWEEN 162000 and 500000
ORDER BY SOMA desc

--QUAIS NOMES NO SISTEMA TEM UMA OCORRENCIA MAIOR QUE DEZ VEZES, POREM SOMENTE ONDE O TITULO É 'Mr.'
SELECT FirstName, COUNT(FirstName)
FROM Person.Person
WHERE Title = 'Mr.'
GROUP BY FirstName
HAVING COUNT(FirstName) >10

--IDENTIFICAR AS PROVINCIAS(STATEPROVINCEID) COM O MAIOR NUMERO DE CADASTROS NO SISTEMA,
--É PRECISO ENCONTRAR QUAIS PROVINCIAS ESTAO REGISTRADAS NO BANCO DE DADOS MAIS DE 1000 VEZES
SELECT StateProvinceID, COUNT(StateProvinceID) as "Quantidade"
FROM Person.Address
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) >1000

--QUAIS PRODUTOS NAO ESTAO TRAZENDO EM MEDIA ABAIXO DE 1M EM VENDAS TOTAIS
SELECT ProductID, avg(linetotal) AS "media"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING avg(LineTotal) < 1000000
ORDER BY media desc

--AS
--ATRIBUI UM NOVO NOME A UMA FUNCAO OU COLUNA
SELECT FirstName as Nome, LastName as Sobrenome
FROM Person.Person

SELECT ProductNumber as "Numero do Produto"
FROM Production.product 

--INNER JOIN
--INNER JOIN, OUTER JOIN E SELF-JOIN
SELECT C.ClienteId, C.Nome, E.Rua, E.cidade
FROM Cliente C
INNER JOIN Endereco E ON E.EnderecoID = C.EnderecoID

SELECT p.nome, --retorne dados da coluna nome na tabela pessoa
		p.email, --retorne dados da coluna email na tabela pessoa
		ec.nome as estado_civil -- trazer nome na tabela estado civil
FROM aula12.pessoa p -- oessoa agora será chamado de p
INNER JOIN aula12.estado_civil ec on ec.id = p.id_estado_civil --conectar a tabela estado civil a tabela pessoa
ORDER BY p.nome -- ordenar por nome

-- RETORNAR O PRIMEIRO NOME, SOBRENOME E EMAIL SENDO QUE O EMAIL ESTA EM OUTRA TABELA
-- O QUE CONECTA AS DUAS TABELAS E O BusinessEntityID
SELECT p.BusinessEntityID, p.FirstName, p.LastName, pe.EmailAddress
FROM Person.Person as P
INNER JOIN Person.EmailAddress PE on p.BusinessEntityID = pe.BusinessEntityID

--RETORNAR O PRECO, O NOME E NOME DA SUBCATEGORIA, E PRECO
SELECT p.ProductSubcategoryID, p.ListPrice, p.Name, pe.Name as "Name Subcategory"
FROM Production.Product as P
INNER JOIN Production.ProductSubcategory PE ON p.ProductSubcategoryID = pe.ProductSubcategoryID

-- JUNTAR TODAS AS COLUNAS DE UMA TABELA
SELECT *
FROM Person.BusinessEntityAddress BA
INNER JOIN person.Address PA ON PA.AddressID = BA.AddressID

-- saber informacoes sobre o telefone, juntar BusinessEntityID,Name,PhoneNumberTypeId,PhoneNumber 
SELECT pp.BusinessEntityID, pt.Name, pt.PhoneNumberTypeId, pp.PhoneNumber
FROM Person.PhoneNumberType PT
INNER JOIN Person.PersonPhone PP ON pt.PhoneNumberTypeId = pp.PhoneNumberTypeId

-- AddressId, City, StateProvinceId, Nome do estado
SELECT pa.AddressID, pa.City, pa.StateProvinceID, ps.Name as "Estado"
FROM Person.Address PA
INNER JOIN Person.StateProvince PS ON pa.StateProvinceID = ps.StateProvinceID

-- SQL TEM 17 TIPOS DE JOINS
-- LEFET OUTER JOIN = LEFT JOIN
--QUAIS PESSOAS TEM UM CARTAO DE CREDITO REGISTRADO
-- UMA DICA É SE BASEAR POR DIAGRAMAS QUE EXPLICAM OS JOIN
SELECT pp.BusinessEntityID, pp.FirstName, pp.LastName, pc.CreditCardID
FROM Person.Person PP
LEFT JOIN Sales.PersonCreditCard PC ON pp.BusinessEntityID = pc.BusinessEntityID

--DESCOBRIR QUEM NAO TEM CARTAO DE CREDITO REGISTRADO
SELECT pp.BusinessEntityID, pp.FirstName, pp.LastName, pc.CreditCardID
FROM Person.Person PP
LEFT JOIN Sales.PersonCreditCard PC 
ON pp.BusinessEntityID = pc.BusinessEntityID
WHERE pc.CreditCardID is null

-- UNION (TIRA DADOS DUPLICADOS)
-- UNION ALL (APARECE TODOS OS DADOS MESMO QUE DUPLICADOS)
-- TE AJUDA A COMBINAR DOIS OU MAIS RESULTADOS DE UM SELECT EM UM RESULTADO APENAS
-- tem que ser a mesma quantidade de colunas e o mesmo tipo de dados (inteiro, decimal, string)
SELECT coluna1, coluna2
FROM tabela1
UNION
SELECT coluna1, coluna2
FROM tabela 2
--exemplo
SELECT [ProductID], [Name], [ProductNumber]
FROM Production.Product
WHERE Name like '%Chain%'

UNION

SELECT [ProductID], [Name], [ProductNumber]
FROM Production.Product
WHERE Name like '%Decal%'

--SELF-JOIN
--ORDENAR DADOS DENTRO DA MESMA TABELA
-- FILTRAR INFORMACAO DENTRO DA MESMA TABELA
SELECT coluna1
FROM TABELA A, TABELA B
WHERE CONDICAO 

--TODAS AS PESSOAS QUE MORAM NA MESMA REGIAO
SELECT A.ContactName, A.Region, B.ContactName, B.Region
FROM Customers A, Customers B
WHERE A.Region = b.Region

--encontrar nome, e data de contratacao de todos os funcionarios que foram contratados no mesmo ano
SELECT a.Firstname, A.hiredate, b.Firstname, b.hiredate
FROM Employees A, Employees B
WHERE DATEPART(YEAR,A.hiredate) = DATEPART(YEAR,B.hiredate)

--eu quero saber na tabela detalhe do pedido quais produtos tem o mesmo percentual de desconto
SELECT A.ProductID, A.Discount, B.ProductID, B.Discount
FROM [Order Details]  A, [Order Details] B
WHERE A.Discount = b.Discount

--SUBQUERIES
--SUBSELECT
--MONTAR UM RELATORIO QUE TEM TODOS OS PRODUTOS CADASTRADOS QUE TEM PRECO DE VENDA ACIMA DA MEDIA
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product)

-- NOME DOS FUNCIONARIOS QUE TEM CARGO DE 'Design Enginner'
SELECT FirstName
FROM Person.Person
WHERE BusinessEntityID IN 
	(
    SELECT BusinessEntityID 
	FROM HumanResources.Employee
	WHERE JobTitle = 'Design Engineer'
    )

-- FAZENDO COM O JOIN
SELECT p.FirstName
FROM Person.Person P
INNER JOIN HumanResources.Employee E ON p.BusinessEntityID = e.BusinessEntityID
AND e.JobTitle = 'Design Engineer'

--encontre todos os enderecos que estao no estado de alberta
SELECT *
FROM Person.Address
where StateProvinceID IN
( SELECT StateProvinceID 
  FROM Person.StateProvince
  WHERE [NAME] = 'Alberta' )

--DATAS
--DATEPART
-- https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver16
SELECT SalesOrderID, DATEPART(month, OrderDate) as Mes-- extrair o mes da coluna OrderDate (month, day, year)
FROM Sales.SalesOrderHeader

--qual a media que tem sido paga por mes
SELECT avg(TOtalDue) as Media, DATEPART(month, OrderDate) as Mes
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(month, OrderDate)
ORDER BY Mes

--MANIPULACAO DE STRING
--https://learn.microsoft.com/pt-br/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver16
SELECT CONCAT(FirstName, ' ', LastName) --junta duas colunas
FROM Person.Person

SELECT UPPER(FirstName)--DEIXA TUDO MAISCULO LOWER DEIXA TUDO MINUSCULO
FROM Person.Person
--UPPER DEIXA TUDO MAIUSCULO
--LEN CONTA CARACTERES
--LOWER DEIXA TUDO MINISCULO
--SUBSTRING EXTRAI UM PEDAÇO DE UMA STRING

--SELECT SUBSTRING(coluna, indice, quantidade de caracteres) o indice inicia em 1
SELECT SUBSTRING(FirstName, 1, 3)
FROM Person.Person

--replace(coluna, o que eu quero substituir, pelo que eu quero substituir)
SELECT REPLACE(ProductNumber, '-', '#')
FROM Production.Product

--ARREDONDAR
--ROUND(coluna, casas decimais)
SELECT ROUND(LineTotal,2)
FROM Sales.SalesOrderDetail

--SQRT É A RAIZ QUADRADA
-- FUNCOES MATEMATICAS SQL SERVE PESQUISAR

--TIPOS DE DADOS
1 BOLEANOS
2 CARACTERE
3 NÚMEROS
4 TEMPORAIS

BOLEANOS
--POR PADRAO ELE É INICIALIZADO COMO NUL0, PODE RECEBER TANTO 1 OU 0

CARACTEREs
--TAMANHO FIXO - char //permite inserir ate uma quantidade fixa de caracters e sempre ocupa todo o espacao reservado (50 de memoria)
-- TAMANHOS VARIAVEIS  - varchar ou nvarchar // permite inserir ate uma quantidade que for definida, porem so usa o espaco que for preenchido 10/50

NUMEROS
--TINYINT - APENAS VALORES INTEIROS
--SMALLINT - MESMA COISA POREM TEM LIMITE MAIOR INTEIROS
--INT LIMITE AINDA MAIOR INTEIROS
--BIGINT VALORES AINDA MAIORES INTEIROS
--NUMERIC OU DECIMAL - NUMEROS COM CASAS DECIMAIS EX: NUMERIC(PRECISAO/QUANTIDADES DE NUMEROS QUE PODEM SER ARMAZENADOS, NUMERO DE CASAS DECIMAIS)
--EX NUMERIC(5,2)
--SERIAL - INCREMENTA UM NUMERO E NAO SE REPETE

--VALORES APROXIMADOS
--REAL - TEM PRECISAO APROXIMADA DE ATE 15 DIGITOS (DEPOIS DA VIRGULA)
--FLOAT - MESMO CONCEITO DE REAL

TEMPORAIS
--DATE - AMAZENA DATA NO FORMATO AAAA/MM/DD
--DATETIME - ARMAZENA DATA E HORAS NO FORMATO AAAA/MM/DD:HH:MM:SS
--DATETIME2 - ARMAZENA DATA E HORAS COM ADICAO DE MILISSEGUNDOS NO FORMATO AAAA/MM/DD:HH:MM:SSSSSSS
--SMALLDATETIME - DATA E HORA RESPEITANDO O LIMITE ENTRE 1900-01-01:00:00:00 ATE 2079-06-06:23:59:59
--TIME - HORAS, MINUTOS, SEGUNDOS E MILISEGUNDOS RESPEITANDO 00:00:0000000 ATE 23:59:5999999
--DATETIMEOFFSET - PERMITE ARMAZENAR INFORMACOES DE DATA E HORAS INCLUINDO FUSO HORARIO

CHAVES PRIMARIAS
--UMA CHAVE PRIMERIA É BASICAMENTE UMA COLUNA OU GRUPO DE COLUNAS, USADA PARA IDENTIFICAR UNICAMENTE UMA LINHA EM UMA TABELA
-- CONSEGUE CRIAR ESSAS CHAVES PRIMARIAS ATRAVÉS QUE RESTRIÇÕES(OU CONSTRAINTS EM INGLES),
  --QUE SAO REGRAS QUE VC DEFINE QUANDO ESTA CRIANDO UMA COLUNA
-- ASSIM QUANDO VOCE FAZ ISSO ESTA CRIANDO UM INDICE UNICO PARA AQUELA COLUNA OU GRUPO DE COLUNAS
CREAT TABLE nome_Tabela (
    nomeColuna tipoDeDados PRIMARY KEY
    nomeCOluna tipoDeDados
)

CHAVE ESTRANGEIRA
--UMA CHAVE ESTRANGEIRA É UMA COLUNA OU GRUPO DE COLUNAS EM UMA TABELA QUE IDENDIFICA UNICAMENTE
  --UMA LIUNHA EM OUTRA TABELA
--OU SEJA, UMA CHAVE ESTRANGEIRA É DEFINIDA EM UMA TABELA ONDE ELA É APENAS UMA REFERENCIA E
  -- NAO CONTEM TODOS OS DADOS ALI
--ENTAO UMA CHAVE ESTRANGEIRA É SIMPLISMENTE UMA COLUNA OU GRUPO DE COLUNAS QUE É UMA CHAVE PRIMÁRIA
  --EM OUTRA TABELA
-- A TABELA QUE CONTEM A CHAVE ESTRANGEIRA É CHAMADA DE TABELA REFERENCIADORA OU TABELA FILHO.
  --E A TABELA NA QUAL A CHAVE ESTRANGEIRA É REFERENCIADA É CHAMADA DE TABELA TABELA REFERENCIADA
  --OU TABELA PAI 
--UMA TABELA PODE TER MAIS DE UMA CHAVE ESTRANGEIRA DEPENDENDO DO SEU RELACIONAMENTO COM AS OUTRAS TABELAS
-- NO SQL SERVER VOCE DEFINE UMA CHAVE ESTRANGEIRA ATRAVEZ DE UM "Foreingn Key Constraint" OU RESTRICAO DE CHAVE ESTRANGEIRA
--UMA RESTRIÇAO DE CHAVE ESTRANGEIRA INDICA QUE OS VALORES EM UMA COLUNA OU GRUPO DE COLUNAS NA TABELA FILHO CORRESPONDEM AOS VALORES NA TABELA PAI
--NOS PODEMOS ENTENDER QUE UMA CHAVE ESTRANGEIRA MANTEM A "integridade referencial

CREATE TABLE
CREAT TABLE nome_Tabela (
    nomeColuna1 tipoDeDados restricaoDaColuna,
    nomeCOluna2 tipoDeDados restricaoDaColuna,
    nomeCOluna2 tipoDeDados restricaoDaColuna,
);
PRINCIPAIS TIPOS DE RESTRICOES QUE PODEM SER APLICADAS
NOT NULL -- NAO PERMITE NULOS
UNIQUE -- FORCA QUE TODOS OS VALORES EM UMA COLUNA SEJAM DIFERENTES
PRIMARY KEY -- UMA JUNCAO DE NOT NULL E UNIQUE
FOREIGN KEY -- IDENTIFICA UNICAMENTE UMA LINHA EM OUTRA TABELA
CHECK -- FORCA UMA CONDICAO ESPECIFICA EM UMA COLUNA
DEFAULT -- FORCA UM VALOR PADRAO QUANDO NENHUM VALOR É PASSADO

CRIANDO TABELA EXEMPLO YOUTUBE

CREATE TABLE Canal (
  CanalId INT PRIMARY KEY, --ID DO CANAL É A CHAVE PRIMARIA NA TABELA CANAL
  Nome VARCHAR (150) NOT NULL, --NOME DO CANAL MAX DE 150 CARACTER E NAO PODE SER NULO
  ContagemInscritos INT DEFAULT 0, --CONTAGEM DE INSCRITOS TEM QUE SER INTEIROS E INICIA EM 0
  DataCriacao DATETIME NOT NULL, --DATA DE CRIACAO NAO PODE SER NULA
);

CREATE TABLE Video ( --CRIANDO A TABELA VIDEO
VideoId INT PRIMARY KEY, -- CRIANDO A ID DO VIDEO
Nome VARCHAR (150) NOT NULL, --NOME DO VIDEO ATE 150 CARACTER E NAO PODE SER VAZIO
Vizualizacoes INT DEFAULT 0, --VIZUALIZACOES COMECANDO EM 0
Likes INT DEFAULT 0, --likes COMECANDO EM 0
Dislikes INT DEFAULT 0, --dislikes COMECANDO EM 0
Duracao INT NOT NULL, -- DURACAO DO VIDEO NAO PODE SER NULA OU ZERO
CanalID INT FOREIGN KEY REFERENCES Canal(CanalId), --INSERINDO CHAVE ESTRANGEIRA O VIDEO PERTENCE A UM ID DA TABELA CANAL
);

INSERIR DADOS EM UMA TABELA OU INSERIR DE OUTRA TABELA
--SINTAXE
INSERT INTO nomeTabela(coluna1, coluna2,...)
VALUES (valor1,valor2)
VALUES (valor1,valor2)
VALUES (valor1,valor2) --INSERIR VARIAS LINHAS

--ou

INSERT INTO nomeTabela(coluna1, coluna2,...)
  VALUES  (valor1,valor2),
        (valor1,valor2),
        (valor1,valor2); --INSERIR VARIAS LINHAS

INSERT INTO TabelaA (coluna1) --selecionar a tabela e a coluna que quero extrair
SELECT coluna2 --selecionar em qual coluna quero inserir
FROM TabelaB --selecionar em qual tabela quero inserir

CRIANDO UMA TABELA
CREATE TABLE aula (
id INT PRIMARY KEY,
nome VARCHAR(200)
);

INSERINDO INFORMACAO NA TABELA
INSERT INTO aula(id,nome)
VALUES
(2, 'aula 2'),
(3, 'aula 3'),
(4, 'aula 4');

SELECT * INTO tabelaNova FROM aula --CRIOU UMA NOVA TABELA COM OS DADOS DA TABELA AULA

ALTERAR LINHAS NO BD
UPDATE nomeTabela
SET coluna1 = valor1
    coluna2 = valor2
WHERE condicao

UPDATE aula
SET nome = 'teste' --ALTERA TODAS AS LINHAS NA COLUNA NOME PARA A PALAVRA TESTE

UPDATE aula
SET nome = 'mudei'
WHERE id = 3 --ALTERA SOMENTE A LINHA 3

APAGAR DADOS
DELETE FROM nomeTabela
WHERE condicao

DELETE FROM aula --escolhe a tabela
WHERE nome = 'mudei' --condicao para ser excluida

ALTERAR ESTRUTURA DE UMA TABELA USANDO ALTER TABLE

SYNTAXE
ALTER TABLE NomeDaTabela
ADICAO

EXEMPLOS DE O QUE PODE SER FEITO:
-- Adicionar, remover, ou alterar uma coluna
-- SETAR VALORES PADROES PARA UMA COLUNA
-- ADICIONAR OU REMOVER RESTRICOES DE UMA COLUNA
-- RENOMEAR UMA TABELA

CREATE TABLE youtube (
  id INT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL UNIQUE,
  categoria VARCHAR(200) NOT NULL,
  dataCriacao DATETIME NOT NULL,
 )

ALTER TABLE youtube
  ADD ativo BIT -- ADICIONANDO A COLUNA ATIVO DO TIPO BIT

ALTER TABLE youtube
ALTER COLUMN categoria VARCHAR(300) NOT NULL

ALTERAR NOME DA COLUNA
EXEC sp_RENAME 'nomeTabela.nomeColunaAtual', 'nomeColunaNova', 'COLUMN'
EXEC sp_RENAME 'youtube.nome', 'nomeCanal', 'COLUMN' --TROCANDO NOME DA COLUNA CANAL PARA NOMECANAL

ALTERAR NOME DA TABELA
EXEC sp_RENAME 'youtube', 'youtube2' --MUDANDO O NOME DA TABELA YOUTUBE PARA YOUTUBE2

DELETAR UMA TABELA DO BANCO DE DADOS
DROP TABLE NomeDaTabela

DELETAR OS DADOS DE UMA TABELA
TRUNCATE TABLE nomeTabela

CRIAR RESTRICOES DE VALORES QUE PODEM SER INSERIDOS EM UMA COLUNA DE UMA TABELA EM UM BD QUANDO VOCE ESTA CRIANDO UMA 
TABELA NOVA

CREATE TABLE CarteiraMotorista(
  Id int NOT NULL,
  Nome VARCHAR(255) NOT NULL,
  Idade INT CHECK (Idade >= 18) --RESTRINGINDO A IDADE PRA MAIOR OU IGUA A 18 COM O CHECK
);

INSERT INTO CarteiraMotorista(Id,Nome,Idade)
VALUES (1, 'Hugo', 17); -- AO INSERIR A IDADE 17 PRA HUGO DA ERRO POIS DA CONFLITA COM A CHECAGEM

CRIAR RESTRICOES PARA FAZER COM QUE NAO SEJA POSSIVEL INSERIR DADOS EM UMA TABELA SEM PREENCHER A COLUNA MARCADA COMO NOT NULL
CREATE TABLE CarteiraMotorista(
  Id int NOT NULL,
  Nome VARCHAR(255) NOT NULL, --NOT NULL FAZ COM QUE SEJA OBRIGATORIO INSERIR UM DADO NESSA COLUNA PARA INSERIR UMA LINHA
  Idade INT CHECK (Idade >= 18) 
);

CRIAR COLUNAS UNICAS, POREM DIFERENTE DE UMA PRIMARY KEY, PODE EXISTIR VARIAS COLUNAS COM A RESTRICAO UNIQUE
CREATE TABLE CarteiraMotorista(
  Id int NOT NULL,
  Nome VARCHAR(255) NOT NULL, 
  Idade INT CHECK (Idade >= 18),
  CodigoCNH INT NOT NULL UNIQUE --FAZ COM QUE NAO POSSA SE REPETIR O MESMO NUMERO NA COLUNA
);

VIEWS SAO TABELAS CRIADAS PARA CONSULTA ONDE VOCE USA OUTRAS TABELAS COMO BASE PARA CRIAR UMA NOVA TABELA DE
PESQUISA COM APENAS DADOS ESPECIFICOS QUE VOCE PRECISA DE UMA TABELA

CREATE VIEW [Pessoas Simplificado] AS
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE Title = 'Ms.'