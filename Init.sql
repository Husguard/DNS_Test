CREATE DATABASE EmployeesDB
GO
USE [EmployeesDB]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Departments] (
    [Id]   INT        IDENTITY (1, 1) NOT NULL,
    [Name] NCHAR (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);
GO
CREATE TABLE [dbo].[Employees] (
    [Id]         INT        IDENTITY (1, 1) NOT NULL,
    [Name]       NCHAR (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Department] INT        NOT NULL,
    [Post]       NCHAR (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
    [Chief]      INT        NULL,
    [Date]       DATE       NOT NULL
);
GO
CREATE PROCEDURE [dbo].[ProcedureShowChiefs]
	@id int = 0
AS
	SELECT F.Id, F.Name, F.Department AS DepartmentId, D.Name AS Department, F.Post, S.Id AS ChiefId, S.Name AS Chief, F.Date FROM 
	((SELECT * FROM Employees WHERE Chief = @id) AS F 
	INNER JOIN Employees AS S ON F.Chief = S.Id INNER JOIN Departments AS D ON F.Department = D.Id)
GO
CREATE PROCEDURE [dbo].[ProcedureAddEmployee]
	@Name NVARCHAR(80),
    @Post NVARCHAR(80),
    @Department INT,
    @Chief INT NULL,
	@Date DATE
AS
	 INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES(@Name, @Department, @Post, @Chief, @Date)
GO

CREATE PROCEDURE [dbo].[ProcedureDeleteEmployee]
    @Id INT
AS
	DELETE Employees WHERE Id=@Id
GO

CREATE PROCEDURE [dbo].[ProcedureFindEmployee]
	@id int
AS
	SELECT F.Id, F.Name, F.Department AS DepartmentId, D.Name AS Department, F.Post, S.Id AS ChiefId, S.Name AS Chief, F.Date FROM 
	((SELECT * FROM Employees WHERE Id = @id) AS F LEFT OUTER JOIN Employees AS S ON S.Id = F.Chief INNER JOIN Departments AS D ON F.Department = D.Id)
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




