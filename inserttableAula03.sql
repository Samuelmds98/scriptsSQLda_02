/*CREATE TABLE rh.pessoa
(
	id serial,
	nome character varying,
	cpf character varying,
	email character varying,
	nascimento date,
	renda numeric (18,2),
	casa_propria boolean
)
;

ALTER TABLE IF EXISTS rh.pessoa
    OWNER to postgres;*/
	
	insert into rh.pessoa
	(nome, cpf, email, nascimento, renda, casa_propria)
	values ('Pedro','01234567890','pedro@digital.com','1990-01-01','7452.12', true);