select 
    com.cod_pc as Cod_Comanda, 
    comp.cod_c as Cod_Componenta, 
    comp.denumire as Denumire, 
    comp.pret as Pret, 
    lc.cantitate as Cantitate
from pc_comanda com
join pc_lista_comanda lc on lc.cod_pc = com.cod_pc
join pc_componenta comp on comp.cod_c = lc.cod_c
where com.cnp_client = '0000000000000'
order by com.cod_pc, comp.cod_c;