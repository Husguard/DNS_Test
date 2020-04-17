CREATE DATABASE EmployeesDB
GO
USE [EmployeesDB]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Departments] (
    [Id]   INT        IDENTITY (1, 1) NOT NULL,
    [Name] NCHAR (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);
GO
CREATE TABLE [dbo].[Employees] (
    [Id]         INT        IDENTITY (1, 1) NOT NULL,
    [Name]       NCHAR (40) NOT NULL,
    [Department] INT        NOT NULL,
    [Post]       NCHAR (40) NOT NULL,
    [Chief]      INT        NULL,
    [Date]       DATE       NOT NULL
);
GO
ALTER DATABASE EmployeesDB
COLLATE Cyrillic_General_CI_AS
GO
CREATE PROCEDURE [dbo].[ProcedureShowChiefs]
	@Id int = 0
AS
		with CTE as 
(select Id, Name, Department, Post, Chief, Date from Employees
where Id = @Id
 union all
 select Employees.Id, Employees.Name, Employees.Department, Employees.Post, Employees.Chief, Employees.Date
   from Employees
        inner join CTE 
                on Employees.Id = CTE.Chief)
select CTE.Id, CTE.Name, CTE.Chief AS ChiefId, S.Name AS Chief, cte.Department AS DepartmentId, D.Name AS Department, CTE.Date, CTE.Post
  from CTE  LEFT OUTER JOIN Employees AS S ON CTE.Chief = S.Id INNER JOIN Departments AS D ON CTE.Department = D.Id ORDER BY CTE.Id DESC
GO
CREATE PROCEDURE [dbo].[ProcedureAddEmployee]
	@Name NVARCHAR(40),
    @Post NVARCHAR(40),
    @Department INT,
    @Chief INT NULL,
	@Date DATE
AS
	 INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES(@Name, @Department, @Post, @Chief, @Date)
GO

CREATE PROCEDURE [dbo].[ProcedureDeleteEmployee]
    @Id INT
AS
	UPDATE Employees SET Chief = NULL WHERE Chief = @Id
	DELETE Employees WHERE Id=@Id
GO

CREATE PROCEDURE [dbo].[ProcedureFindEmployee]
	@id int
AS
	SELECT F.Id, F.Name, F.Department AS DepartmentId, D.Name AS Department, F.Post, S.Id AS ChiefId, S.Name AS Chief, F.Date FROM 
	((SELECT * FROM Employees WHERE Id = @id) AS F LEFT OUTER JOIN Employees AS S ON S.Id = F.Chief INNER JOIN Departments AS D ON F.Department = D.Id)
GO
CREATE PROCEDURE [dbo].[ProcedureGetSuggests]
	@Name NVARCHAR(40)
AS SELECT TOP(5) Id, Name FROM Employees WHERE Name LIKE @Name + '%'
GO
CREATE PROCEDURE [dbo].[ProcedureGetDepartments]
AS
	SELECT Id, Name FROM Departments
GO

CREATE PROCEDURE [dbo].[ProcedureShowPageOfEmployees]
	@page int,
	@selected int,
	@sort NVARCHAR(4),
	@column NVARCHAR(10)
AS
DECLARE @sqlText nvarchar(1000); 
SET @sqlText = 'SELECT F.Id, F.Name, F.Department AS DepartmentId, D.Name AS Department, F.Post, S.Id AS ChiefId, S.Name AS Chief, F.Date  
	 FROM Employees AS F LEFT OUTER JOIN Employees AS S ON (F.Chief = S.Id) INNER JOIN Departments AS D on F.Department = D.Id
	ORDER BY ' + @column + ' ' + @sort + ' OFFSET ' + STR(@page*@selected) + ' ROWS FETCH NEXT ' + STR(@selected) + ' ROWS ONLY'
Exec (@sqlText);
GO

INSERT INTO Departments(Name) VALUES('Îòäåë ñîïðîâîæäåíèÿ ñàéòà');
INSERT INTO Departments(Name) VALUES('Îòäåë ñòîðîííèõ ðàáîò');
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Çëîáà Äåíèñ Íàðêèñîâè÷', 1,'Àäìèíèñòðàòîð', '0', '2000.12.07')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Òåìíîõîëìîâ Èâàí Âàñèëüåâè÷', 1,'Ìàñòåð îòäåëà', '1', '2018.06.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ãóæåâñêèé Íèêèòà Èåðîôååâè÷', 2,'Òðåéäåð', '0', '2001.01.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áàøêèðåâ Àíäðåé Êèðèëëîâè÷', 1,'Òåõíîëîã', '0', '2002.02.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êíÿæíèí Ðîñòèñëàâ Ôèëèïïîâè÷', 2,'Ãåîýêîëîã', '2', '2002.06.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ãîâîðîâ Âëàäèìèð Àäðèÿíîâè÷', 2,'Åãèïòîëîã', '0', '2002.11.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Øîðèí Áîðèñ Ãâèäîíîâè÷', 1,'Web-äèçàéíåð', '5', '2004.02.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìèòêîâ Ãðèãîðèé Âñåñëàâîâè÷', 2,'Âîñïèòàòåëü', '3', '2004.05.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áåëèêîâ Âèêòîð Ðîáåðòîâè÷', 2,'Ðåôåðåíò', '5', '2005.10.27')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ïèí÷óê Ãåîðãèé Êîðíååâè÷', 2,'Ïåðåâîä÷èê', '8', '2007.06.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìàòêåâè÷ Àðêàäèé Èóñòèíîâè÷', 2,'Ñîöèîëîã', '7', '2009.01.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñòåáíèöêèé Ëåâ Ìèíååâè÷', 2,'Áèëåòíûé êàññèð', '0', '2009.07.17')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Øåâåëåâ Ìàêñèì Ñåðãååâè÷', 1,'Ó÷åíèê-ïðîãðàììèñò', '1', '2020.04.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ëèõàðåâ Ëåâ Ýììàíóèëîâè÷', 2,'Ìóñîðùèê', '0', '2010.02.16')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ãàðøèí Èííîêåíòèé Ìàðòèíîâè÷', 2,'Ñòîìàòîëîã', '0', '2010.06.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñàìîéëîâ Òèìóð Ìàðèàíîâè÷', 1,'Êîïèðàéòåð', '0', '2010.08.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìåðåæêîâñêèé Ãðèãîðèé Àâñååâè÷', 1,'Áëîãåð', '0', '2010.12.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áåêàðþêîâ Èâàí Èïïîëèòîâè÷', 2,'Ôëîðèñò', '0', '2012.01.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Çàáîðîâñêèé Àëåêñàíäð Âàñèëüåâè÷', 1,'Ïðîãðàììèñò', '0', '2012.07.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áîøíÿê Àëåêñåé Ñåâåðèàíîâè÷', 2,'Òàêñèñò', '12', '2012.07.26')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ïîëîâèíêèí Âëàäèñëàâ Àðõèïïîâè÷', 2,'Ñòèëèñò', '18', '2014.07.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñâèñòóíîâ ßêîâ Àðõèïîâè÷', 2,'Ìàðêåòîëîã', '4', '2016.02.01')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Äåíèñîâ Ãëåá Ñèëüâåñòðîâè÷', 2,'Ãåîäåçèñò', '0', '2016.04.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âàñèëåâñêèé Àðò¸ì Íàðöèññîâè÷', 2,'Ìèëèöèîíåð', '21', '2016.11.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñàâåëîâ Âëàäèñëàâ Àâðåëèåâè÷', 2,'Áðåíä-ìåíåäæåð', '0', '2017.01.30')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ïîçäååâ Ôèëèïï Çåíîíîâè÷', 1,'Ïðåïîäàâàòåëü', '0', '2018.03.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áàðàòàåâ Ñòàíèñëàâ Àñêîëüäîâè÷', 2,'Ñëåñàðü', '17', '2019.10.17')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êàðòàøåâñêèé Ñòåïàí Ìàêñèìèëèàíîâè÷', 2,'Ìîòîðèñò', '0', '2000.07.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âîðîòèíöåâ Àíäðåé Íèêîíîâè÷', 2,'Äåðìàòîëîã', '25', '2001.12.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áóðìàíòîâ Äåíèñ Àíäðèàíîâè÷', 2,'Ôîòîãðàô', '0', '2006.08.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Òîëáóãèí Âàëåíòèí Âèêóëîâè÷', 2,'Ýòíîãðàô', '0', '2006.09.05')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñîëîâöîâ Èëüÿ Çèíîíîâè÷', 2,'Îðòîïåä', '0', '2007.05.25')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Íîâàêîâ Þðèé Àíäðîíèêîâè÷', 2,'Øàõòåð', '6', '2007.07.31')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñîëòûêîâ Èííîêåíòèé Âàëåðèàíîâè÷', 2,'Òåîëîã', '0', '2007.11.05')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ïèí÷óê Ôèëèïï Âóêîëîâè÷', 1,'Ïñèõèàòð', '0', '2008.02.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Åôèìîâè÷ Àíòîí Ôèðñîâè÷', 2,'Ìàíèêþðøà', '18', '2008.05.15')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Øåâ÷óê Ýäóàðä Äîðìåäîíòîâè÷', 2,'Ìóçûêàíò', '13', '2008.11.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Äóáåíñêèé Âëàäèìèð Ñàìñîíîâè÷', 2,'Ìåäèöèíñêàÿ ñåñòðà', '0', '2009.06.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Àðíàóòîâ Âëàäèìèð Ñîêðàòîâè÷', 2,'Ìîðÿê', '31', '2009.09.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Äóðîâ Âàëåðèé Ïàâëèíîâè÷', 2,'Ó÷èòåëü', '0', '2009.12.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Øóêëèí Ðîñòèñëàâ Ôîêè÷', 2,'Ëåò÷èê', '23', '2010.10.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ãðèáîåäîâ Èííîêåíòèé Ïàíêðàòîâè÷', 2,'Ñòàëåâàð', '0', '2011.09.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êàðà÷àðîâ Ãàâðèèë Ôåêòèñòîâè÷', 2,'Òèïîãðàô', '0', '2013.02.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ãðèíåâåöêèé Èííîêåíòèé Ãåííàäüåâè÷', 2,'Ýêîëîã', '0', '2014.02.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñòðîéíîâñêèé Ñòåïàí Äîðìèäîíòîâè÷', 2,'Àêóøåð', '15', '2014.07.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Îøàíèí Âàñèëèé Àêèíôîâè÷', 2,'Àíäðîëîã', '0', '2015.01.06')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êëåìåíòüåâ Èãîðü Ãîðäååâè÷', 1,'Áóëî÷íèê', '34', '2016.10.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âèñëåíåâ Âëàäèñëàâ Ìèðîíîâè÷', 1,'Ñòàòèñòèê', '44', '2017.05.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñòàðîäóáñêèé Ñòåïàí Òåîäîðîâè÷', 2,'Ëèòåéùèê', '0', '2018.01.31')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ðîçåíáàõ Ðîñòèñëàâ Êîðíåëèåâè÷', 2,'Êîíòåíò-ìåíåäæåð', '0', '2018.06.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñïåøíåâ Âàëåðèé Òåîäîñüåâè÷', 2,'Êîíäèòåð', '14', '2018.06.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñòåöêèé Ìàêñèì Åãîðüåâè÷', 2,'Òèôëîïåäàãîã', '26', '2019.08.23')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Àêñàêîâ Ìàòâåé ßíóàðèåâè÷', 2,'Ñàïîæíèê', '0', '2001.05.10')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áåãè÷åâ Âàëåíòèí Àáðàìèåâè÷', 2,'Ñâÿùåííîñëóæèòåëü', '0', '2003.04.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êàõîâñêèé Èâàí Âèêóëîâè÷', 2,'Ýêñïåäèòîð', '1', '2004.01.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âîëîñàòîâ Ðîìàí Ìàêàðîâè÷', 2,'Äåëîïðîèçâîäèòåëü', '13', '2004.09.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Åñèïîâ Âàñèëèé Èñààêîâè÷', 2,'Ðåæèññåð', '14', '2005.01.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áóõâîñòîâà Äàðüÿ Àäðèÿíîâíà', 2,'Ïåêàðü', '24', '2005.02.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìàêñèìîâñêàÿ Ëàðèñà Âëàñèåâíà', 1,'Èíæåíåð-êîíñòðóêòîð', '46', '2005.04.26')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Òðåòüÿêîâà Þëèÿ Ìàâðîâíà', 1,'Òåñòèðîâùèê', '47', '2005.05.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ãàéâîðîíñêàÿ Åëåíà Ïåòðîâíà', 2,'Ìàëÿð', '0', '2006.06.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìàçóðîâà Äèàíà Âëàäèìèðîâíà', 2,'Âîäèòåëü', '0', '2008.02.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Øîëüöåâà Àãíèÿ Êàññèàíîâíà', 2,'Ãåíåðàëüíûé ñåêðåòàðü', '21', '2009.02.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ïóñòîðîñëåâà Âåðà Ðîáåðòîâíà', 2,'Ëîãîïåä', '45', '2011.11.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âñåâîëîæñêàÿ Òàòüÿíà Èðàêëèåâíà', 2,'Áèçíåñ-òðåíåð', '4', '2012.01.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Àðöûáàøåâà Ëèäèÿ Èóñòèíîâíà', 2,'Êîñìîíàâò', '0', '2012.02.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êàëèòååâñêàÿ Àë¸íà Àâåðêèåâíà', 2,'Àóäèòîð', '0', '2012.04.09')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('ßìèíñêàÿ Âàëåíòèíà Âëàäèìèðîâíà', 2,'Ïðîäàâåö-êîíñóëüòàíò', '0', '2012.10.30')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìèêóëàåâà Ëþäìèëà Èïàòüåâíà', 2,'Ïîðòüå', '26', '2014.10.14')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñïåøíåâà Ýëëà Èëüèíè÷íà', 2,'Êàïèòàí ñóäíà', '0', '2015.05.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Åëèñååâà Ëþäìèëà Ðóñëàíîâíà', 1,'Web-èíòåãðàòîð', '0', '2016.04.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êíÿçåâà Ýììà Âàëåðèåâíà', 2,'Ïðîçåêòîð', '0', '2017.09.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âàðåíöîâà Íèíà Àäðèÿíîâíà', 2,'Ïîëèöåéñêèé', '37', '2017.11.08')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ïåòóõîâà Ìàðãàðèòà Ãåííàäüåâíà', 2,'Êðèçèñ-ìåíåäæåð', '47', '2018.10.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áóòóðëèíà Ìàðèÿ Ìåôîäèåâíà', 2,'Êèíîîïåðàòîð', '51', '2019.09.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ìàðêîâà Íàòàëüÿ Ïàòðèêèåâíà', 1,'Èíæåíåð-òåõíîëîã', '0', '2020.02.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êóçüìèíà Àíòîíèíà Àðõèïïîâíà', 2,'Çàêðîéùèê', '71', '2020.10.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áóëóøåâà Ìàðèíà Ñòåôàíîâíà', 1,'Ðåäàêòîð', '37', '2000.05.08')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Àðìôåëüò Ñíåæàíà Àëåêñååâíà', 1,'Âåðñòàëüùèê', '1', '2000.12.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êóñàêîâà Îêñàíà Ïàíòåëåèìîíîâíà', 2,'Ôàðìàöåâò', '55', '2001.01.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Îëñóôüåâà Ãàëèíà Ãåîðãèåâíà', 2,'Èíæåíåð', '70', '2001.02.15')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Êðàìàðü Âèêòîðèÿ Âàëåðüÿíîâíà', 2,'Íåâðîïàòîëîã', '65', '2002.05.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñàìñîíîâà Âàëåíòèíà Êëèìåíòüåâíà', 2,'Ìàññàæèñò', '0', '2002.12.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âàñèëåâñêàÿ Ìàðèíà Åôðåìîâíà', 2,'Ïàëåîíòîëîã', '52', '2003.03.06')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Äîìàøíåâà Òàòüÿíà Ìèíè÷íà', 2,'Àãðîíîì', '77', '2006.02.09')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ñîêîëîâà Àëèñà Àêñåíòèåâíà', 2,'Àðõèòåêòîð-ïðîåêòèðîâùèê', '9', '2006.04.27')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ëóòêîâñêàÿ Íàòàëüÿ Ñâÿòîñëàâîâíà', 2,'Õîðåîãðàô', '0', '2007.06.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Áîáûíèíà Àëèíà Ðîáåðòîâíà', 2,'Çâóêîðåæèññåð', '62', '2009.05.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Âåðäåðåâñêàÿ Þëèÿ Áîãäàíîâíà', 2,'Ìåíåäæåð ïî PR', '74', '2010.04.28')
