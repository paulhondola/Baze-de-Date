-- L5.Ex1. Să se listeze toți studenții de la facultatea AC care au media mai mica decât studentul cu CNP = 1020608359554.
SELECT
	nume,
	media
FROM
	student
WHERE
	fid = 'AC'
	AND media < (
		SELECT
			media
		FROM
			student
		WHERE
			cnp = '1020608359554'
	);

-- L5.Ex2. Folosind subinterogări să se afișeze valoarea bursei minime la facultatea AC. Obs. - Se vor ignora studenții fără bursă sau cu bursa necunoscută. Se acceptă doar soluții care folosesc materia studiată până acum (ex. fără agregare).
SELECT DISTINCT
	bursa
FROM
	student
WHERE
	bursa > 0
	and fid = 'AC'
	and bursa <= all (
		SELECT
			bursa
		FROM
			student
		WHERE
			bursa > 0
			and fid = 'AC'
	);

-- L5.Ex3. Folosind subinterogări (fără a folosi join) să se afișeze toate cursurile care se țin într-o sală cu mai mult de 100 de locuri.
SELECT
	*
FROM
	curs
WHERE
	sala in (
		SELECT
			cods
		FROM
			sala
		WHERE
			nrlocuri > 100
	);

-- L5.Ex4. Să se listeze toate sălile, împreună cu numărul de locuri, care sunt folosite și de facultatea MEC și de cea AC pentru cursuri la aceste facultăți
SELECT
	*
FROM
	sala
WHERE
	cods IN (
		SELECT
			sala
		FROM
			curs
		WHERE
			fid = 'AC'
	)
	AND cods IN (
		SELECT
			sala
		FROM
			curs
		WHERE
			fid = 'MEC'
	);

-- L5.Ex5. Să se listeze toți studenții unde mai există cel puțin încă un student care are exact aceiași bursă și exact aceiași medie, indiferent de facultatea la care sunt înscriși.
SELECT DISTINCT
	s1.nume,
	s1.bursa,
	s1.media
FROM
	student s1,
	(
		SELECT
			sid,
			nume,
			bursa,
			media
		FROM
			student
	) s2
WHERE
	s1.bursa = s2.bursa
	and s1.media = s2.media
	and s1.sid <> s2.sid
	-- another way to solve
SELECT DISTINCT
	s1.nume,
	s1.bursa,
	s1.media
FROM
	student s1
WHERE
	EXISTS (
		SELECT
			s2.nume,
			s2.bursa,
			s2.media
		FROM
			student s2
		WHERE
			s1.bursa = s2.bursa
			and s1.media = s2.media
			and s1.sid <> s2.sid
	);

-- L5.Ex6. Folosind operatorul EXISTS să se listeze facultățile(fid și nume) care au cel puțin un student cu bursa cea mai mare posibilă în universitate. (Obs.: Se pot utiliza două sau mai multe subinterogări succesive imbricate)
SELECT
	f.fid,
	f.nume
FROM
	facultate f
WHERE
	EXISTS (
		SELECT
			*
		FROM
			student s
		WHERE
			s.fid = f.fid
			AND s.bursa > 0
			AND s.bursa >= ALL (
				SELECT
					bursa
				FROM
					student
				WHERE
					bursa > 0
			)
	)
