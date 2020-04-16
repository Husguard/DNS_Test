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
	@id int = 0
AS
	SELECT F.Id, F.Name, F.Department AS DepartmentId, D.Name AS Department, F.Post, S.Id AS ChiefId, S.Name AS Chief, F.Date FROM 
	((SELECT * FROM Employees WHERE Chief = @id) AS F 
	INNER JOIN Employees AS S ON F.Chief = S.Id INNER JOIN Departments AS D ON F.Department = D.Id)
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

INSERT INTO Departments(Name) VALUES('����� ������������� �����');
INSERT INTO Departments(Name) VALUES('����� ��������� �����');
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����� ����� ����������', 1,'�������������', '0', '2000.12.07')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����������� ���� ����������', 1,'������ ������', '1', '2018.06.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ������ ����������', 2,'�������', '0', '2001.01.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ������ ����������', 1,'��������', '0', '2002.02.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ��������� ����������', 2,'���������', '2', '2002.06.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� �������� ����������', 2,'���������', '0', '2002.11.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����� ����� ����������', 1,'Web-��������', '5', '2004.02.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ �������� �����������', 2,'�����������', '3', '2004.05.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������ ����������', 2,'��������', '5', '2005.10.27')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ������� ���������', 2,'����������', '8', '2007.06.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ������� ����������', 2,'��������', '7', '2009.01.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ��� ��������', 2,'�������� ������', '0', '2009.07.17')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������ ���������', 1,'������-�����������', '1', '2020.04.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ��� ������������', 2,'��������', '0', '2010.02.16')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ���������� ����������', 2,'����������', '0', '2010.06.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ����� ����������', 1,'����������', '0', '2010.08.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ �������� ��������', 1,'������', '0', '2010.12.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ���� �����������', 2,'�������', '0', '2012.01.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����������� ��������� ����������', 1,'�����������', '0', '2012.07.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ������� ������������', 2,'�������', '12', '2012.07.26')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ��������� ����������', 2,'�������', '18', '2014.07.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ���� ���������', 2,'����������', '4', '2016.02.01')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ���� �������������', 2,'���������', '0', '2016.04.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����������� ���� �����������', 2,'����������', '21', '2016.11.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ��������� ����������', 2,'�����-��������', '0', '2017.01.30')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������ ���������', 1,'�������������', '0', '2018.03.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ��������� �����������', 2,'�������', '17', '2019.10.17')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ������ ���������������', 2,'��������', '0', '2000.07.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ������ ���������', 2,'����������', '25', '2001.12.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ����� �����������', 2,'��������', '0', '2006.08.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� �������� ���������', 2,'��������', '0', '2006.09.05')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ���� ���������', 2,'�������', '0', '2007.05.25')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ���� ������������', 2,'������', '6', '2007.07.31')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ���������� ������������', 2,'������', '0', '2007.11.05')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ������ ���������', 1,'��������', '0', '2008.02.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ����� ��������', 2,'���������', '18', '2008.05.15')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ������ �������������', 2,'��������', '13', '2008.11.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� �������� ����������', 2,'����������� ������', '0', '2009.06.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� �������� ����������', 2,'�����', '31', '2009.09.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����� ������� ����������', 2,'�������', '0', '2009.12.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ��������� �����', 2,'������', '23', '2010.10.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ���������� �����������', 2,'��������', '0', '2011.09.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ������� �����������', 2,'��������', '0', '2013.02.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����������� ���������� �����������', 2,'������', '0', '2014.02.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ������ �������������', 2,'������', '15', '2014.07.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ������� ���������', 2,'��������', '0', '2015.01.06')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ����� ���������', 1,'��������', '34', '2016.10.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ��������� ���������', 1,'���������', '44', '2017.05.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ������ ����������', 2,'��������', '0', '2018.01.31')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ��������� �����������', 2,'�������-��������', '0', '2018.06.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������� �����������', 2,'��������', '14', '2018.06.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������ ���������', 2,'������������', '26', '2019.08.23')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������ ����������', 2,'��������', '0', '2001.05.10')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� �������� ����������', 2,'�����������������', '0', '2003.04.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ���� ���������', 2,'����������', '1', '2004.01.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ����� ���������', 2,'�����������������', '13', '2004.09.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������ ������� ���������', 2,'��������', '14', '2005.01.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ����� ����������', 2,'������', '24', '2005.02.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ������ ���������', 1,'�������-�����������', '46', '2005.04.26')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ���� ��������', 1,'�����������', '47', '2005.05.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ����� ��������', 2,'�����', '0', '2006.06.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ����� ������������', 2,'��������', '0', '2008.02.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ����� �����������', 2,'����������� ���������', '21', '2009.02.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ���� ����������', 2,'�������', '45', '2011.11.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ������� ����������', 2,'������-������', '4', '2012.01.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ����� ����������', 2,'���������', '0', '2012.02.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ���� ����������', 2,'�������', '0', '2012.04.09')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ��������� ������������', 2,'��������-�����������', '0', '2012.10.30')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ������� ���������', 2,'������', '26', '2014.10.14')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ���� ���������', 2,'������� �����', '0', '2015.05.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ������� ����������', 1,'Web-����������', '0', '2016.04.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ���� ����������', 2,'���������', '0', '2017.09.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ���� ����������', 2,'�����������', '37', '2017.11.08')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ��������� �����������', 2,'������-��������', '47', '2018.10.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ����� ����������', 2,'������������', '51', '2019.09.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� ������� �����������', 1,'�������-��������', '0', '2020.02.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� �������� ����������', 2,'���������', '71', '2020.10.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ������ ����������', 1,'��������', '37', '2000.05.08')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ������� ����������', 1,'�����������', '1', '2000.12.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ������ ���������������', 2,'���������', '55', '2001.01.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ������ ����������', 2,'�������', '70', '2001.02.15')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������� �������� ������������', 2,'������������', '65', '2002.05.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ��������� ������������', 2,'���������', '0', '2002.12.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('����������� ������ ���������', 2,'�����������', '52', '2003.03.06')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('��������� ������� �������', 2,'�������', '77', '2006.02.09')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ����� �����������', 2,'����������-�������������', '9', '2006.04.27')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('���������� ������� �������������', 2,'���������', '0', '2007.06.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('�������� ����� ����������', 2,'�������������', '62', '2009.05.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('������������ ���� ����������', 2,'�������� �� PR', '74', '2010.04.28')
