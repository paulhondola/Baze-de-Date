select 
    c.cod_c as Cod_Componenta, 
    c.denumire as Denumire, 
    c.producator as Producator, 
    c.pret as Pret, 
    sum(lc.cantitate) as Total_Comenzi 
from pc_componenta c
join pc_lista_comanda lc on lc.cod_c = c.cod_c
group by c.cod_c, c.denumire, c.producator, c.pret