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

INSERT INTO Departments(Name) VALUES('Отдел сопровождения сайта');
INSERT INTO Departments(Name) VALUES('Отдел сторонних работ');
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Злоба Денис Наркисович', 1,'Администратор', '0', '2000.12.07')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Темнохолмов Иван Васильевич', 1,'Мастер отдела', '1', '2018.06.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Гужевский Никита Иерофеевич', 2,'Трейдер', '0', '2001.01.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Башкирев Андрей Кириллович', 1,'Технолог', '0', '2002.02.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Княжнин Ростислав Филиппович', 2,'Геоэколог', '2', '2002.06.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Говоров Владимир Адриянович', 2,'Египтолог', '0', '2002.11.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Шорин Борис Гвидонович', 1,'Web-дизайнер', '5', '2004.02.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Митков Григорий Всеславович', 2,'Воспитатель', '3', '2004.05.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Беликов Виктор Робертович', 2,'Референт', '5', '2005.10.27')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Пинчук Георгий Корнеевич', 2,'Переводчик', '8', '2007.06.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Маткевич Аркадий Иустинович', 2,'Социолог', '7', '2009.01.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Стебницкий Лев Минеевич', 2,'Билетный кассир', '0', '2009.07.17')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Шевелев Максим Сергеевич', 1,'Ученик-программист', '1', '2020.04.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Лихарев Лев Эммануилович', 2,'Мусорщик', '0', '2010.02.16')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Гаршин Иннокентий Мартинович', 2,'Стоматолог', '0', '2010.06.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Самойлов Тимур Марианович', 1,'Копирайтер', '0', '2010.08.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Мережковский Григорий Авсеевич', 1,'Блогер', '0', '2010.12.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бекарюков Иван Ипполитович', 2,'Флорист', '0', '2012.01.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Заборовский Александр Васильевич', 1,'Программист', '0', '2012.07.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бошняк Алексей Северианович', 2,'Таксист', '12', '2012.07.26')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Половинкин Владислав Архиппович', 2,'Стилист', '18', '2014.07.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Свистунов Яков Архипович', 2,'Маркетолог', '4', '2016.02.01')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Денисов Глеб Сильвестрович', 2,'Геодезист', '0', '2016.04.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Василевский Артём Нарциссович', 2,'Милиционер', '21', '2016.11.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Савелов Владислав Аврелиевич', 2,'Бренд-менеджер', '0', '2017.01.30')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Поздеев Филипп Зенонович', 1,'Преподаватель', '0', '2018.03.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Баратаев Станислав Аскольдович', 2,'Слесарь', '17', '2019.10.17')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Карташевский Степан Максимилианович', 2,'Моторист', '0', '2000.07.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Воротинцев Андрей Никонович', 2,'Дерматолог', '25', '2001.12.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бурмантов Денис Андрианович', 2,'Фотограф', '0', '2006.08.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Толбугин Валентин Викулович', 2,'Этнограф', '0', '2006.09.05')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Соловцов Илья Зинонович', 2,'Ортопед', '0', '2007.05.25')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Новаков Юрий Андроникович', 2,'Шахтер', '6', '2007.07.31')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Солтыков Иннокентий Валерианович', 2,'Теолог', '0', '2007.11.05')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Пинчук Филипп Вуколович', 1,'Психиатр', '0', '2008.02.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ефимович Антон Фирсович', 2,'Маникюрша', '18', '2008.05.15')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Шевчук Эдуард Дормедонтович', 2,'Музыкант', '13', '2008.11.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Дубенский Владимир Самсонович', 2,'Медицинская сестра', '0', '2009.06.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Арнаутов Владимир Сократович', 2,'Моряк', '31', '2009.09.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Дуров Валерий Павлинович', 2,'Учитель', '0', '2009.12.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Шуклин Ростислав Фокич', 2,'Летчик', '23', '2010.10.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Грибоедов Иннокентий Панкратович', 2,'Сталевар', '0', '2011.09.02')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Карачаров Гавриил Фектистович', 2,'Типограф', '0', '2013.02.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Гриневецкий Иннокентий Геннадьевич', 2,'Эколог', '0', '2014.02.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Стройновский Степан Дормидонтович', 2,'Акушер', '15', '2014.07.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Ошанин Василий Акинфович', 2,'Андролог', '0', '2015.01.06')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Клементьев Игорь Гордеевич', 1,'Булочник', '34', '2016.10.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Висленев Владислав Миронович', 1,'Статистик', '44', '2017.05.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Стародубский Степан Теодорович', 2,'Литейщик', '0', '2018.01.31')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Розенбах Ростислав Корнелиевич', 2,'Контент-менеджер', '0', '2018.06.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Спешнев Валерий Теодосьевич', 2,'Кондитер', '14', '2018.06.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Стецкий Максим Егорьевич', 2,'Тифлопедагог', '26', '2019.08.23')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Аксаков Матвей Януариевич', 2,'Сапожник', '0', '2001.05.10')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бегичев Валентин Абрамиевич', 2,'Священнослужитель', '0', '2003.04.28')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Каховский Иван Викулович', 2,'Экспедитор', '1', '2004.01.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Волосатов Роман Макарович', 2,'Делопроизводитель', '13', '2004.09.13')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Есипов Василий Исаакович', 2,'Режиссер', '14', '2005.01.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бухвостова Дарья Адрияновна', 2,'Пекарь', '24', '2005.02.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Максимовская Лариса Власиевна', 1,'Инженер-конструктор', '46', '2005.04.26')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Третьякова Юлия Мавровна', 1,'Тестировщик', '47', '2005.05.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Гайворонская Елена Петровна', 2,'Маляр', '0', '2006.06.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Мазурова Диана Владимировна', 2,'Водитель', '0', '2008.02.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Шольцева Агния Кассиановна', 2,'Генеральный секретарь', '21', '2009.02.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Пусторослева Вера Робертовна', 2,'Логопед', '45', '2011.11.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Всеволожская Татьяна Ираклиевна', 2,'Бизнес-тренер', '4', '2012.01.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Арцыбашева Лидия Иустиновна', 2,'Космонавт', '0', '2012.02.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Калитеевская Алёна Аверкиевна', 2,'Аудитор', '0', '2012.04.09')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Яминская Валентина Владимировна', 2,'Продавец-консультант', '0', '2012.10.30')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Микулаева Людмила Ипатьевна', 2,'Портье', '26', '2014.10.14')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Спешнева Элла Ильинична', 2,'Капитан судна', '0', '2015.05.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Елисеева Людмила Руслановна', 1,'Web-интегратор', '0', '2016.04.29')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Князева Эмма Валериевна', 2,'Прозектор', '0', '2017.09.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Варенцова Нина Адрияновна', 2,'Полицейский', '37', '2017.11.08')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Петухова Маргарита Геннадьевна', 2,'Кризис-менеджер', '47', '2018.10.24')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бутурлина Мария Мефодиевна', 2,'Кинооператор', '51', '2019.09.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Маркова Наталья Патрикиевна', 1,'Инженер-технолог', '0', '2020.02.18')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Кузьмина Антонина Архипповна', 2,'Закройщик', '71', '2020.10.20')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Булушева Марина Стефановна', 1,'Редактор', '37', '2000.05.08')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Армфельт Снежана Алексеевна', 1,'Верстальщик', '1', '2000.12.19')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Кусакова Оксана Пантелеимоновна', 2,'Фармацевт', '55', '2001.01.11')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Олсуфьева Галина Георгиевна', 2,'Инженер', '70', '2001.02.15')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Крамарь Виктория Валерьяновна', 2,'Невропатолог', '65', '2002.05.21')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Самсонова Валентина Климентьевна', 2,'Массажист', '0', '2002.12.03')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Василевская Марина Ефремовна', 2,'Палеонтолог', '52', '2003.03.06')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Домашнева Татьяна Минична', 2,'Агроном', '77', '2006.02.09')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Соколова Алиса Аксентиевна', 2,'Архитектор-проектировщик', '9', '2006.04.27')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Лутковская Наталья Святославовна', 2,'Хореограф', '0', '2007.06.04')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Бобынина Алина Робертовна', 2,'Звукорежиссер', '62', '2009.05.22')
INSERT INTO Employees(Name,Department,Post,Chief, Date) VALUES('Вердеревская Юлия Богдановна', 2,'Менеджер по PR', '74', '2010.04.28')
