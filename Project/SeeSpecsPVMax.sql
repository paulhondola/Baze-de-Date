select c.cod_pc || ' (' || cl.nume || ')' as display_value,
       c.cod_pc as return_value
from pc_comanda c
join pc_client cl on c.cnp_client = cl.cnp
