CREATE TABLE IF NOT EXISTS dw.dim_nivel_experiencia (
id serial, primary key (id),
descricao character varying);

select * from dw.dim_nivel_experiencia

SELECT DISTINCT
CASE
	WHEN nivel_experiencia = 'EX' THEN 'Expert'
	WHEN nivel_experiencia = 'SE' THEN 'Senior'
	WHEN nivel_experiencia = 'MI' THEN 'Junior'
	WHEN nivel_experiencia = 'EN' THEN 'Estagiario'
	END as nivel_experiencia
FROM public.dm_salarios;

INSERT INTO dw.dim_nivel_experiencia (descricao)
SELECT DISTINCT nivel_experiencia
FROM dm_salarios;

CREATE TABLE IF NOT EXISTS dw.dim_tipo_trabalho
(
id serial, primary key (id),
descricao character varying
);

CREATE TABLE IF NOT EXISTS dw.dim_titulo
(
id serial, primary key (id),
descricao character varying
);

CREATE TABLE IF NOT EXISTS dw.moeda_corrente
(
id serial, primary key (id),
descricao character varying
);

CREATE TABLE IF NOT EXISTS dw.residencia_empregado
(
id serial, primary key (id),
descricao character varying
);

CREATE TABLE IF NOT EXISTS dw.percentual_remoto
(
id serial, primary key (id),
descricao character varying
);

CREATE TABLE IF NOT EXISTS dw.localizacao_empresa
(
id serial, primary key (id),
descricao character varying
);

CREATE TABLE IF NOT EXISTS dw.tamanho_empresa
(
id serial, primary key (id),
descricao character varying
);



CREATE TABLE dw.ft_salario
(
	id serial, primary key (id),
	id_tempo integer,
	id_nivel_experiencia integer,
	id_tipo_trabalho integer,
	id_titulo integer,
	id_moeda_corrente integer,
	id_residencia_empregado integer,
	id_percentual_remoto integer,
	id_localizacao_empresa integer,
	id_tamanho_empresa integer,
	salario numeric (18,2),
	salario_dolar numeric (18,2),
	
	CONSTRAINT id_tempofk FOREIGN KEY (id_tempo)
        REFERENCES dw.dim_Tempo (id) MATCH SIMPLE,
	
	CONSTRAINT id_nivel_experienciafk FOREIGN KEY (id_nivel_experiencia)
        REFERENCES dw.dim_nivel_experiencia (id) MATCH SIMPLE,
	
	CONSTRAINT id_tipo_trabalhofk FOREIGN KEY (id_tipo_trabalho)
        REFERENCES dw.dim_tipo_trabalho (id) MATCH SIMPLE,
	
	CONSTRAINT id_titulofk FOREIGN KEY (id_titulo)
        REFERENCES dw.dim_titulo (id) MATCH SIMPLE,
	
	CONSTRAINT id_moeda_correntefk FOREIGN KEY (id_moeda_corrente)
        REFERENCES dw.moeda_corrente (id) MATCH SIMPLE,
	
	CONSTRAINT id_residencia_empregadofk FOREIGN KEY (id_residencia_empregado)
        REFERENCES dw.residencia_empregado (id) MATCH SIMPLE,
	
	CONSTRAINT id_percentual_remotofk FOREIGN KEY (id_percentual_remoto)
        REFERENCES dw.percentual_remoto (id) MATCH SIMPLE,
		
	CONSTRAINT id_localizacao_empresafk FOREIGN KEY (id_localizacao_empresa)
        REFERENCES dw.localizacao_empresa (id) MATCH SIMPLE,
	
	CONSTRAINT id_tamanho_empresafk FOREIGN KEY (id_tamanho_empresa)
        REFERENCES dw.tamanho_empresa (id) MATCH SIMPLE
);
	
	