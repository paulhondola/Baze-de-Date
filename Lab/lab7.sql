-- L7.Ex1. Să se calculeze numărul de studenți care nu au bursă și au media peste 7.50.
select count(*) as nr_studenti
from student
where (bursa is null or bursa = 0) and media > 7.50

-- L7.Ex2. Să se calculeze numărul de studenți care au ore cu profesorul 'Luca Caragiale'.
select count(distinct student.sid) as nr_studenti
from student
join contract on contract.sid = student.sid
join curs on curs.cid = contract.cid
join profesor on profesor.pid = curs.pid
where profesor.nume = 'Luca Caragiale'

-- L7.Ex3. Să se calculeze numărul total de studenți care au ore la etajul 1 (încărcarea sălilor de la etajul 1), indiferent de facultate si de zi.
select count(student.sid) as nr_studenti
from student
join contract on contract.sid = student.sid
join curs on curs.cid = contract.cid
join sala on sala.cods = curs.sala
where sala.etaj = 1

-- L7.Ex4. Să se afișeze data nașterii celui mai tânăr și celui mai bătrân student din anul 2.
select max(datan), min(datan)
from student
where an = 2

-- L7.Ex5. Să se calculeze suma și media burselor pe fiecare an de studiu la fiecare facultate. Se vor afișa numele facultății, anul de studiu, suma și media burselor.
select facultate.nume, student.an, sum(bursa) as suma, avg(bursa) as average
from student
join facultate on student.fid = facultate.fid
group by facultate.nume, student.an

-- L7.Ex6. Să se afișeze bursa minimă (>0), medie și maximă a tuturor studenților care au ore in ziua de 'Luni', indiferent de curs.
select 
    min(bursa), 
    avg(bursa), 
    max(bursa)
from student
where sid in (
    select student.sid
    from student
    join contract on contract.sid = student.sid
    join curs on curs.cid = contract.cid
    where curs.zi = 'Luni' and student.bursa > 0
)

-- L7.Ex7. Folosind subinterogări și agregări să se afișeze toți studenții cu bursa peste bursa medie din universitate.
select *
from student
where bursa > (
    select avg(bursa)
    from student
)

-- L7.Ex8. Să se calculeze intervalul de normalitate a mediilor pentru fiecare facultate în parte. Se va afișa numele fiecărei facultăți precum și pragurile de jos și de sus a intervalului de normalitate pentru mediile studenților din acea facultate.
select
    f.nume as nume_facultate,
    ROUND(AVG(s.media) - STDDEV(s.media), 2) as prag_jos,
    ROUND(AVG(s.media) + STDDEV(s.media), 2) as prag_sus
from facultate f
left join student s on s.fid = f.fid
group by f.nume;

-- L7.Ex9. Folosind subinterogări și agregări să se afișeze toți studenții care au medii în afara intervalului de normalitate a mediilor pe universitate.
select *
from student
where media < (
    select avg(media) - stddev(media)
    from student
) or media > (
    select avg(media) + stddev(media)
    from student
)

-- Folosind agregarea datelor afisati media notelor (2 zecimale) pentru contractele de studii din semestrul 2 grupate pe fiecare an
select
    an,
    trunc(avg(nota), 2)
from contract
where semestru = 2
group by an

-- Folosind agregarea datelor afisati varianta notelor (2 zecimale) pentru contractele de studii din semestrul 1 grupate pe fiecare an
select
    an,
    trunc(variance(nota), 2)
from contract
where semestru = 1
group by an

-- Folosind agregarea datelor afisati numarul total de locuri ale salilor de pe fiecare etaj
select etaj, sum(nrlocuri) as numar_locuri
from sala
group by etaj

-- Folosind agregarea datelor afisati numarul total de cursuri din semestrul 1
select count(*)
from curs
where semestru = 1

-- numar studenti cu media intre 7 si 9
select count(*)
from student
where media between 7 and 9

-- grupurile pe baza gradului si nr de profesori pentru fiecare grup care are mai mult de 5 membri
select grad, count(*)
from profesor
group by grad
having count(*) > 5

-- cel mai batran student
select min(datan)
from student