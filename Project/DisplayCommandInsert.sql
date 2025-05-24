select distinct lc.cod_pc || ' (' || pccl.nume || ') ' , lc.cod_pc as "Codul comenzii" from pc_lista_comanda lc
    join pc_comanda pcc on lc.cod_pc = pcc.cod_pc
    join pc_client pccl on pcc.cnp_client = pccl.cnp
