


--CONSULTA VALOR MEDIO DE COMPRA POR CLIENTE, ORDENADO DO MAIOR AO MENOR
SELECT nome_empresa,
    AVG ((pd.preco_unitario - (pd.preco_unitario * pd.desconto))
* quantidade )::numeric(18,2)::money as valor
FROM aula_18.pedido p
INNER JOIN aula_18.pedido_detalhe pd on pd.id_pedido = p.id
INNER JOIN aula_18.cliente c on c.id = p.id_cliente
GROUP BY nome_empresa
having avg((pd.preco_unitario - (pd.preco_unitario * pd.desconto))
* quantidade )::numeric(18,2) >= 0
ORDER BY valor desc


--CONSULTA DO PERCENTUAL DE LUCRO REAL DE CADA PRODUTO, ORDENADO DO MAIOR AO MENOR
SELECT pr.nome,
    SUM (((((pd.preco_unitario - (pd.preco_unitario * pd.desconto)) * pd.quantidade) --Vlr Venda
-
(pd.quantidade * pr.preco_unitario)) -- vlr Custo
/ (pd.quantidade * pr.preco_unitario)) * 100)::numeric(18,2) as valor
FROM aula_18.pedido_detalhe pd
INNER JOIN aula_18.produtos pr on pr.id = pd.id_produto
GROUP BY pr.nome
ORDER BY valor desc


--CONSULTA DO PERCENTUAL DE LUCRO POR ANO
SELECT date_part('Year', data_pedido),
    SUM (((((pd.preco_unitario - (pd.preco_unitario * pd.desconto)) * pd.quantidade) --Vlr Venda
-
(pd.quantidade * pr.preco_unitario)) -- vlr Custo
/ (pd.quantidade * pr.preco_unitario)) * 100)::numeric(18,2) as valor
FROM aula_18.pedido_detalhe pd
INNER JOIN aula_18.produtos pr on pr.id = pd.id_produto
INNER JOIN aula_18.pedido p on p.id = pd.id_pedido
GROUP BY date_part('Year', data_pedido);

--CONSULTA CATEGORIA DE PRODUTOS COM MAIOR LUCRATIVIDADE, ORDENADO DO MAIOR AO MENOR
SELECT c.nome,
    SUM (((((pd.preco_unitario - (pd.preco_unitario * pd.desconto)) * pd.quantidade) --Vlr Venda
-
(pd.quantidade * pr.preco_unitario)) -- vlr Custo
/ (pd.quantidade * pr.preco_unitario)) * 100)::numeric(18,2) as valor
FROM aula_18.pedido_detalhe pd
INNER JOIN aula_18.produtos pr on pr.id = pd.id_produto
INNER JOIN aula_18.categoria c on c.id = pr.id_categoria
GROUP BY c.nome
ORDER BY valor desc

-- CONSULTA LISTA DE VENDAS POR FUNCIONARIO
SELECT f.primeiro_nome as funcionario,
    SUM(pd.quantidade) as total_vendido
FROM aula_18.pedido p
INNER JOIN aula_18.funcionario f ON f.id = p.id_funcionario
INNER JOIN aula_18.pedido_detalhe pd ON pd.id_pedido = p.id
GROUP BY f.primeiro_nome
ORDER BY total_vendido DESC;

--LISTA DE VENDAS POR CATEGORIA
SELECT f.nome as categoria,
    SUM(pd.quantidade) as total_vendido
FROM aula_18.pedido p
INNER JOIN aula_18.categoria f ON f.id = p.id
INNER JOIN aula_18.pedido_detalhe pd ON pd.id_pedido = p.id
GROUP BY f.nome
ORDER BY total_vendido DESC;

--LISTA DE VENDAS POR FORNECEDOR

SELECT f.nome_empresa as fornecedor,
    SUM(pd.quantidade) as total_vendido
FROM aula_18.pedido p
INNER JOIN aula_18.fornecedor f ON f.id = p.id
INNER JOIN aula_18.pedido_detalhe pd ON pd.id_pedido = p.id
GROUP BY f.nome_empresa
ORDER BY total_vendido DESC;


--Gerar consulta com a seguinte saída (ano do pedido, cliente, funcionario, transportadora, valor do pedido)
SELECT EXTRACT(year FROM p.data_pedido) as ano_pedido,
   SUM (((pd.preco_unitario - (pd.preco_unitario * pd.desconto)) * pd.quantidade)) as valor_total,
   c.nome_empresa as cliente,
   f.primeiro_nome as funcionario,
   t.nome as transportadora
FROM aula_18.pedido p
INNER JOIN aula_18.cliente c ON c.id = p.id_cliente
INNER JOIN aula_18.funcionario f ON f.id = p.id_funcionario
INNER JOIN aula_18.transportadora t ON t.id = p.id_transportadora
INNER JOIN aula_18.pedido_detalhe pd ON pd.id_pedido = p.id
GROUP BY ano_pedido, cliente, funcionario, transportadora
ORDER BY ano_pedido DESC, cliente, funcionario; 