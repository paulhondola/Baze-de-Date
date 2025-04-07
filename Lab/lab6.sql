-- L6.Ex1. Modificați interogarea de la Activitatea1 pentru a nu include și studenții fără bursă.
SELECT
	s1.sid,
	s1.nume,
	s1.an,
	s1.bursa
	FROM
	Student s1
WHERE
	s1.bursa < 750
UNION
SELECT
	s2.sid,
	s2.nume,
	s2.an,
	s2.bursa
FROM
	Student s2
WHERE
	s2.bursa > 900 MINUS
SELECT
	s3.sid,
	s3.nume,
	s3.an,
	s3.bursa
FROM
	Student s3
WHERE
	s3.bursa = 0
	-- L6.Ex2. Rescrieți interogarea anterioară ca să obțineți același rezultat fără a folosi operații pe mulțimi.
select
	sid,
	nume
from
	student
where
	(
		bursa < 750
		or bursa > 900
	)
	and bursa <> 0

--L6.Ex3. Folosind reuniunea să se listeze toți studenții (sid, nume, an, bursa) care au bursa minimă împreună cu cei care au bursa maximă. Obs. Cei care au bursa = 0 sau NULL se consideră că nu au bursă.

select
	s1.sid,
	s1.nume,
	s1.an,
	s1.bursa
from
	student s1
where
	s1.bursa = (
		select
			min(bursa)
		from
			student
		where
			bursa is not null
	)
union
select
	s2.sid,
	s2.nume,
	s2.an,
	s2.bursa
from
	student s2
where
	s2.bursa = (
		select
			max(bursa)
		from
			student
		where
			bursa is not null
	)
	-- or
select
	s1.sid,
	s1.nume,
	s1.an,
	s1.bursa
from
	student s1
where
	s1.bursa >= all (
		select
			bursa
		from
			student
		where
			bursa is not null
	)
union
select
	s2.sid,
	s2.nume,
	s2.an,
	s2.bursa
from
	student s2
where
	s2.bursa <= all (
		select
			bursa
		from
			student
		where
			bursa is not null
	)
	--L6.Ex4. Folosind intersecția să se listeze facultățile (fid, nume, adr) care au cursuri și la etajul 1 și la etajul 2.
select
	fid,
	nume,
	adr
from
	facultate
where
	fid in (select fid from curs
		where
			sala in (
				select
					cods
				from
					sala
				where
					etaj = 1
			)
		intersect
		select
			fid
		from
			curs
		where
			sala in (
				select
					cods
				from
					sala
				where
					etaj = 2
			)
	)

-- L6.Ex5. Folosind intersecția să se listeze studenții (sid, nume, an, bursa) nu au bursa (0 sau NULL) și au ore în sala A101.
select s1.sid, s1.nume from student s1
    where s1.bursa = 0 or s1.bursa is null
intersect
select s2.sid, s2.nume from student s2
    join contract c on s2.sid = c.sid
    join curs crs on c.cid = crs.cid
    where crs.sala = 'A101'

-- L6.Ex6. Folosind diferența să se listeze studenții (sid, nume, an, bursa) sunt înscriși facultatea care are numărul de telefon '0256-403211' și nu au ore cu profesorul Ciprian Porumbescu.
select s1.sid, s1.nume from student s1
	where s1.fid = (select fid from facultate where tel = '0256-403211')
minus
select s2.sid, s2.nume from student s2
join contract ct on ct.sid = s2.consider
join curs c on c.cid = ct.cid
join profesor p on p.pid = c.pid
where p.nume = 'Ciprian Porumbescu'