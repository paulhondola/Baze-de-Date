select pcco.cod_c, pcco.denumire, pcco.producator, pcco.pret, pclc.cantitate from pc_componenta pcco
    join pc_lista_comanda pclc on pclc.cod_c = pcco.cod_c
    where pclc.cod_pc = :P_VMAX
