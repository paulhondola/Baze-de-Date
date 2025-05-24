SELECT 
    cl.cnp,
    cl.nume,
    COUNT(DISTINCT c.cod_pc) AS numar_comenzi,
    SUM(lc.cantitate * comp.pret) AS pret_total
FROM 
    pc_client cl
JOIN 
    pc_comanda c ON cl.cnp = c.cnp_client
JOIN 
    pc_lista_comanda lc ON c.cod_pc = lc.cod_pc
JOIN 
    pc_componenta comp ON lc.cod_c = comp.cod_c
GROUP BY 
    cl.cnp, cl.nume
ORDER BY cl.nume
