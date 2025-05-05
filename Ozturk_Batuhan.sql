--Ahmet Batuhan Ozturk

use student

/*oef1*/
select f.facultyID, f.FacultyName
from Faculty f
left join FacultyDepartment d on f.FacultyID = d.FacultyID
where d.DepartmentID is null


/*oef2*/
select StudentFirstname as Voornaam,
		StudentSecondname as Familienaam,
		StudentDateOfBirth as Geboortedatum,
		lower(StudentSecondname + '.' + StudentFirstname) as login,
		lower(
			left(StudentFirstname, 3) +
			left(StudentSecondname, 3) +
			right(convert(varchar(10), StudentDateOfBirth, 112), 4)
			)
			as password
from student
order by StudentSecondname, StudentFirstname


/*oef3*/
select d.DepartmentName, count(c.ClassName) as aantal
from Department d
join Class c on d.DepartmentID = c.DepartmentID
group by d.DepartmentName
having count(c.ClassName) > 0 and count(c.ClassName) < 5



/*oef4a*/
select StudentFirstName, StudentSecondName, StudentDateOfBirth
from student
where StudentDateOfBirth = (
    select min(StudentDateOfBirth)
    from student
    where StudentID in (
        select StudentID
        from Enrollment
		where Classname= 'Databanken')
		)



/*oef4b*/
select StudentFirstname, StudentSecondname, StudentDateOfBirth
from student
where StudentDateOfBirth = 
		( select min(StudentDateOfBirth)
		from student
		join Enrollment on student.StudentID = Enrollment.StudentID
		join class on Enrollment.Classname = Class.ClassName
		where Class.Classname = 'Databanken' )


/*oef5*/
select DepartmentName, count(ClassName) as aantalvakken
from Department
join class on Department.DepartmentID = Class.DepartmentID
group by DepartmentName
having count(ClassName) = 
		(select max(aantal)
		from(
			select count(ClassName) as aantal
			from Department
			join class on Department.DepartmentID = Class.DepartmentID
			group by Department.DepartmentID) 
			as departement
			) 


/*oef6a*/ 
select StudentFirstname, StudentSecondname
from student
join Enrollment on student.StudentID = Enrollment.StudentID
join class on Enrollment.Classname = Class.ClassName
where Class.Classname = 'Databanken'




/*oef6b*/ 
select top 1 StudentFirstName, StudentSecondName
from student
join Enrollment on student.StudentID = Enrollment.StudentID
join Class on Enrollment.ClassName = Class.ClassName
where Class.ClassName = 'Databanken'
order by student.StudentSecondName DESC, student.StudentFirstName DESC



/*oef7*/ 
select Classroom, count(*) as aantalkeren
from Class
GROUP BY Classroom, ClassMeeting
HAVING COUNT(*) > 1



/*oef8*/
select DepartmentName
from Department 
WHERE Department.DepartmentID not in 
(
    select distinct Class.DepartmentID
    from Class
    where Class.Classroom = '10F113'
)


use Bibliotheek

/*oef9*/
select Titel as Etiket, 'boek' as Soort
from Boek

select Naam as Etiket, 'auteur' as Soort
from Auteur


/*oef10*/ 
select Titel
from Boek
where auteur_id = (
    select auteur_id
    from Boek
    where Titel = 'Japanse tuinen')


/*oef11a*/
select 
    datename(month, datum) as Maand, categorie as Categorie, count(uitlnr) as AantalUitgeleende
from Uitleen 
join Boek on Uitleen.boek_id = Boek.boek_id
join Categorie on Boek.cat_id = Categorie.cat_id
GROUP BY datename(month, Uitleen.datum), Categorie.categorie, month(Uitleen.datum)
ORDER BY Categorie.categorie ASC


/*oef11b*/
select 
    datename(month, datum) as Maand, categorie as Categorie, count(uitlnr) as AantalUitgeleende
from Uitleen 
join Boek on Uitleen.boek_id = Boek.boek_id
join Categorie on Boek.cat_id = Categorie.cat_id
GROUP BY datename(month, Uitleen.datum), Categorie.categorie, month(Uitleen.datum)
ORDER BY month(Uitleen.datum) ASC

/*oef12*/
select Naam
from Auteur
where Naam like '_o%'


/*oef13*/
select categorie, count(boek_id) as AantalBoeken
from Categorie
join boek on Categorie.cat_id = Boek.cat_id
group by categorie
having count(boek_id) = 
		(
		select min(aantal)
		from (
        select count(boek_id) as Aantal
        from Categorie
        join Boek on Categorie.cat_id = Boek.cat_id
        group by Categorie.cat_id
    ) as categorie )



		


	
