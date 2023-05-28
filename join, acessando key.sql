SELECT 
p.nome,
p.email,
ec.nome AS estado_civil
FROM aula_12.pessoa p
INNER JOIN aula_12.estado_civil ec ON ec.id = p.id_estado_civil
ORDER BY p.nome;

