/* CREATE TABLE IF NOT EXISTS public.departamento
(
	id serial NOT NULL,
	nome character varying NOT NULL,
	id_regiao integer,
	PRIMARY KEY (id)
);

ALTER TABLE public.departamento
	OWNER to postgres; */
	
/* 
insert into regiao values (1,'Norte');
insert into regiao values (2,'Centro');
insert into regiao values (3,'Sul');

insert into departamento values (10,'Vendas',1);
insert into departamento values (20,'Operação',1);
insert into departamento values (30,'Administração',1);
insert into departamento values (40,'Financeiro',1);
*/

SELECT *
FROM regiao
