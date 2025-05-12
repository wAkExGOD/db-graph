USE MASTER
GO
DROP DATABASE IF EXISTS VlGraph
GO
CREATE DATABASE VlGraph
GO
USE VlGraph
GO

-- Таблицы узлов
CREATE TABLE Students (
    ID INTEGER PRIMARY KEY,
    Name NVARCHAR(100),
    Age INTEGER,
    University NVARCHAR(100)
) AS NODE;

CREATE TABLE Books (
    ID INTEGER PRIMARY KEY,
    Title NVARCHAR(100),
    Author NVARCHAR(100),
    YearPublished INTEGER
) AS NODE;

CREATE TABLE Movies (
    ID INTEGER PRIMARY KEY,
    Title NVARCHAR(100),
    Director NVARCHAR(100),
    YearReleased INTEGER
) AS NODE;

-- Таблицы рёбер
CREATE TABLE FriendsWith AS EDGE;
CREATE TABLE RecommendsBook (Comment NVARCHAR(100)) AS EDGE;
CREATE TABLE RecommendsMovie (Comment NVARCHAR(100)) AS EDGE;

INSERT INTO Students VALUES
(1, 'Иван Иванов', 20, 'БГУ'),
(2, 'Мария Петрова', 21, 'БГУИР'),
(3, 'Алексей Сидоров', 22, 'БНТУ'),
(4, 'Екатерина Кузнецова', 20, 'БГУ'),
(5, 'Дмитрий Смирнов', 23, 'БГМУ'),
(6, 'Ольга Васнецова', 21, 'БГПУ'),
(7, 'Сергей Козлов', 22, 'БГАТУ'),
(8, 'Анна Лебедева', 20, 'БГУ'),
(9, 'Павел Новиков', 21, 'БГУИР'),
(10, 'Юлия Морозова', 22, 'БГЭУ');

INSERT INTO Books VALUES
(1, 'Война и мир', 'Лев Толстой', 1869),
(2, 'Преступление и наказание', 'Фёдор Достоевский', 1866),
(3, '1984', 'Джордж Оруэлл', 1949),
(4, 'Улисс', 'Джеймс Джойс', 1922),
(5, 'Лолита', 'Владимир Набоков', 1955),
(6, 'Шум и ярость', 'Уильям Фолкнер', 1929),
(7, 'Невидимка', 'Ральф Эллисон', 1952),
(8, 'На маяк', 'Вирджиния Вулф', 1927),
(9, 'Гордость и предубеждение', 'Джейн Остин', 1813),
(10, 'Властелин колец', 'Дж. Р. Р. Толкин', 1954);

INSERT INTO Movies VALUES
(1, 'Крёстный отец', 'Фрэнсис Форд Коппола', 1972),
(2, 'Криминальное чтиво', 'Квентин Тарантино', 1994),
(3, 'Тёмный рыцарь', 'Кристофер Нолан', 2008),
(4, 'Космическая одиссея 2001', 'Стэнли Кубрик', 1968),
(5, 'Красота по-американски', 'Сэм Мендес', 1999),
(6, 'Матрица', 'Лана и Лилли Вачовски', 1999),
(7, 'Список Шиндлера', 'Стивен Спилберг', 1993),
(8, 'Побег из Шоушенка', 'Фрэнк Дарабонт', 1994),
(9, 'Форрест Гамп', 'Роберт Земекис', 1994),
(10, 'Начало', 'Кристофер Нолан', 2010);

-- Дружеские связи между студентами
INSERT INTO FriendsWith ($from_id, $to_id)
VALUES
-- Иван (1) дружит с Марией (2), Алексеем (3) и Екатериной (4)
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Students WHERE ID = 2)),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Students WHERE ID = 1)),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Students WHERE ID = 3)),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Students WHERE ID = 1)),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Students WHERE ID = 4)),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Students WHERE ID = 1)),

-- Мария (2) дружит с Дмитрием (5) и Ольгой (6)
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Students WHERE ID = 5)),
((SELECT $node_id FROM Students WHERE ID = 5), (SELECT $node_id FROM Students WHERE ID = 2)),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Students WHERE ID = 6)),
((SELECT $node_id FROM Students WHERE ID = 6), (SELECT $node_id FROM Students WHERE ID = 2)),

-- Алексей (3) дружит с Сергеем (7) и Анной (8)
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Students WHERE ID = 7)),
((SELECT $node_id FROM Students WHERE ID = 7), (SELECT $node_id FROM Students WHERE ID = 3)),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Students WHERE ID = 8)),
((SELECT $node_id FROM Students WHERE ID = 8), (SELECT $node_id FROM Students WHERE ID = 3)),

-- Екатерина (4) дружит с Павлом (9) и Юлией (10)
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Students WHERE ID = 9)),
((SELECT $node_id FROM Students WHERE ID = 9), (SELECT $node_id FROM Students WHERE ID = 4)),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Students WHERE ID = 10)),
((SELECT $node_id FROM Students WHERE ID = 10), (SELECT $node_id FROM Students WHERE ID = 4));

-- Рекомендации книг
INSERT INTO RecommendsBook ($from_id, $to_id, Comment)
VALUES
-- Иван (1) рекомендует книги
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Books WHERE ID = 3), 'Классика антиутопии, должен прочитать каждый'),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Books WHERE ID = 10), 'Лучшее фэнтези всех времён'),

-- Мария (2) рекомендует книги
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Books WHERE ID = 2), 'Глубокий психологический роман'),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Books WHERE ID = 9), 'Идеальное сочетание юмора и романтики'),

-- Алексей (3) рекомендует книги
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Books WHERE ID = 1), 'Эпичное произведение, хотя и длинное'),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Books WHERE ID = 4), 'Сложно, но стоит усилий'),

-- Екатерина (4) рекомендует книги
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Books WHERE ID = 5), 'Спорный, но гениальный роман'),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Books WHERE ID = 7), 'Важно для понимания расовых вопросов'),

-- Дмитрий (5) рекомендует книги
((SELECT $node_id FROM Students WHERE ID = 5), (SELECT $node_id FROM Books WHERE ID = 6), 'Экспериментальный стиль, но очень мощно'),
((SELECT $node_id FROM Students WHERE ID = 5), (SELECT $node_id FROM Books WHERE ID = 8), 'Потрясающий поток сознания');

-- Рекомендации фильмов
INSERT INTO RecommendsMovie ($from_id, $to_id, Comment)
VALUES
-- Иван (1) рекомендует фильмы
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Movies WHERE ID = 3), 'Лучший фильм про Бэтмена'),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Movies WHERE ID = 10), 'Умный и зрелищный фильм'),

-- Мария (2) рекомендует фильмы
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Movies WHERE ID = 2), 'Культовое кино, уникальный стиль'),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Movies WHERE ID = 6), 'Философия и экшен в одном флаконе'),

-- Алексей (3) рекомендует фильмы
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Movies WHERE ID = 1), 'Абсолютный шедевр кинематографа'),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Movies WHERE ID = 4), 'Научная фантастика высшего уровня'),

-- Екатерина (4) рекомендует фильмы
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Movies WHERE ID = 5), 'Красивая и грустная история'),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Movies WHERE ID = 7), 'Важный исторический фильм'),

-- Ольга (6) рекомендует фильмы
((SELECT $node_id FROM Students WHERE ID = 6), (SELECT $node_id FROM Movies WHERE ID = 8), 'Вдохновляющая история о надежде'),
((SELECT $node_id FROM Students WHERE ID = 6), (SELECT $node_id FROM Movies WHERE ID = 9), 'Трогательно и смешно одновременно'),

-- Павел (9) рекомендует фильмы
((SELECT $node_id FROM Students WHERE ID = 9), (SELECT $node_id FROM Movies WHERE ID = 3), 'Отличный супергеройский фильм'),
((SELECT $node_id FROM Students WHERE ID = 9), (SELECT $node_id FROM Movies WHERE ID = 10), 'Запутанно, но очень интересно');

-- MATCH запросы
-- 1. Найти всех друзей Ивана
SELECT s2.Name 
FROM Students s1, FriendsWith f, Students s2
WHERE MATCH(s1-(f)->s2)
AND s1.Name = 'Иван Иванов';

-- 2. Найти книги, рекомендованные друзьями Марии
SELECT b.Title, b.Author
FROM Students s1, FriendsWith f, Students s2, RecommendsBook rb, Books b
WHERE MATCH(s1-(f)->s2-(rb)->b)
AND s1.Name = 'Мария Петрова';

-- 3. Найти фильмы, рекомендованные студентами БГУ
SELECT m.Title, m.Director
FROM Students s, RecommendsMovie rm, Movies m
WHERE MATCH(s-(rm)->m)
AND s.University = 'БГУ';

-- 4. Найти студентов, которые рекомендуют книги, опубликованные после 1950
SELECT DISTINCT s.Name
FROM Students s, RecommendsBook rb, Books b
WHERE MATCH(s-(rb)->b)
AND b.YearPublished > 1950;

-- 5. Найти друзей друзей Алексея
SELECT s3.Name
FROM Students s1, FriendsWith f1, Students s2, FriendsWith f2, Students s3
WHERE MATCH(s1-(f1)->s2-(f2)->s3)
AND s1.Name = 'Алексей Сидоров'
AND s3.Name != 'Алексей Сидоров';

-- SHORTEST PATH запросы
-- 1. Найти кратчайший путь между Иваном и другими студентами
SELECT 
    Student1.Name AS StudentName,
    STRING_AGG(Student2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendsPath
FROM 
    Students AS Student1,
    FriendsWith FOR PATH AS fw,
    Students FOR PATH AS Student2
WHERE 
    MATCH(SHORTEST_PATH(Student1(-(fw)->Student2)+))
    AND Student1.Name = 'Иван Иванов';

-- 2. Найти друзей и друзей друзей Марии Петровой 
SELECT
    s1.Name AS Student,
    STRING_AGG(s2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS Path
FROM
    Students AS s1,
    Students FOR PATH AS s2,
    FriendsWith FOR PATH AS fw
WHERE
    MATCH(SHORTEST_PATH(s1(-(fw)->s2){1,2}))
    AND s1.Name = 'Мария Петрова';

-- для Power Bi
SELECT S1.ID AS IdFirst
	, S1.name AS First
	, CONCAT(N'user (', S1.id, ')') AS [First image name]
	, S2.ID AS IdSecond
	, S2.name AS Second
	, CONCAT(N'user (', S2.id, ')') AS [Second image name]
FROM Students AS S1
	, FriendsWith AS c
	, Students AS S2
WHERE MATCH(S1-(c)->S2)


SELECT S.ID AS IdFirst
	, S.name AS First
	, CONCAT(N'user (', S.id, ')') AS [First image name]
	, B.ID AS IdSecond
	, B.title AS Second
	, CONCAT(N'book (', B.id, ')') AS [Second image name]
FROM Students AS S
	, RecommendsBook AS rb
	, Books AS B
WHERE MATCH(S-(rb)->B)

SELECT S.ID AS IdFirst
	, S.name AS First
	, CONCAT(N'user (', S.id, ')') AS [First image name]
	, M.ID AS IdSecond
	, M.title AS Second
	, CONCAT(N'movie (', M.id, ')') AS [Second image name]
FROM Students AS S
	, RecommendsMovie AS rm
	, Movies AS M
WHERE MATCH(S-(rm)->M)