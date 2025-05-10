drop table pc_lista_comanda cascade constraints;
drop table pc_comanda cascade constraints;
drop table pc_componenta cascade constraints;
drop table pc_client cascade constraints;

create table pc_client(
    cnp char(13) not null,
    nume varchar2(40) not null,
    email varchar2(40) not null,

    constraint pc_client_pk primary key(cnp)
);

create table pc_componenta(
    cod_c varchar2(10) not null,
    denumire varchar2(40) not null,
    producator varchar2(40) not null,
    pret number(6) not null,

    constraint pc_componenta_pk primary key(cod_c)
);

create table pc_comanda(
    cod_pc varchar2(10) not null,
    cnp_client char(13) not null,
    data_comanda date not null,

    constraint pc_comanda_pk primary key(cod_pc),
    constraint pc_client_fk foreign key(cnp_client) references pc_client(cnp) on delete cascade
);

create table pc_lista_comanda(
    cod_pc varchar2(10) not null,
    cod_c varchar2(10) not null,
    cantitate number(4) not null,
    
    -- foreign keys
    constraint pc_componenta_fk foreign key(cod_c) references pc_componenta(cod_c) on delete cascade,
    constraint pc_comanda_fk foreign key(cod_pc) references pc_comanda(cod_pc) on delete cascade,

    -- composite primary key
    constraint pc_lista_comanda_pk primary key(cod_pc, cod_c)
);

