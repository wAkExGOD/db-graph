USE MASTER
GO
DROP DATABASE IF EXISTS VlGraph
GO
CREATE DATABASE VlGraph
GO
USE VlGraph
GO

-- ������� �����
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

-- ������� ����
CREATE TABLE FriendsWith AS EDGE;
CREATE TABLE RecommendsBook (Comment NVARCHAR(100)) AS EDGE;
CREATE TABLE RecommendsMovie (Comment NVARCHAR(100)) AS EDGE;

INSERT INTO Students VALUES
(1, '���� ������', 20, '���'),
(2, '����� �������', 21, '�����'),
(3, '������� �������', 22, '����'),
(4, '��������� ���������', 20, '���'),
(5, '������� �������', 23, '����'),
(6, '����� ���������', 21, '����'),
(7, '������ ������', 22, '�����'),
(8, '���� ��������', 20, '���'),
(9, '����� �������', 21, '�����'),
(10, '���� ��������', 22, '����');

INSERT INTO Books VALUES
(1, '����� � ���', '��� �������', 1869),
(2, '������������ � ���������', 'Ը��� �����������', 1866),
(3, '1984', '������ ������', 1949),
(4, '�����', '������ �����', 1922),
(5, '������', '�������� �������', 1955),
(6, '��� � ������', '������ �������', 1929),
(7, '���������', '����� �������', 1952),
(8, '�� ����', '��������� ����', 1927),
(9, '�������� � �������������', '����� �����', 1813),
(10, '��������� �����', '��. �. �. ������', 1954);

INSERT INTO Movies VALUES
(1, '������� ����', '������� ���� �������', 1972),
(2, '������������ �����', '������� ���������', 1994),
(3, 'Ҹ���� ������', '��������� �����', 2008),
(4, '����������� ������� 2001', '������ ������', 1968),
(5, '������� ��-�����������', '��� ������', 1999),
(6, '�������', '���� � ����� ��������', 1999),
(7, '������ ��������', '������ ��������', 1993),
(8, '����� �� ��������', '����� ��������', 1994),
(9, '������� ����', '������ �������', 1994),
(10, '������', '��������� �����', 2010);

-- ��������� ����� ����� ����������
INSERT INTO FriendsWith ($from_id, $to_id)
VALUES
-- ���� (1) ������ � ������ (2), �������� (3) � ���������� (4)
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Students WHERE ID = 2)),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Students WHERE ID = 1)),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Students WHERE ID = 3)),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Students WHERE ID = 1)),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Students WHERE ID = 4)),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Students WHERE ID = 1)),

-- ����� (2) ������ � �������� (5) � ������ (6)
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Students WHERE ID = 5)),
((SELECT $node_id FROM Students WHERE ID = 5), (SELECT $node_id FROM Students WHERE ID = 2)),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Students WHERE ID = 6)),
((SELECT $node_id FROM Students WHERE ID = 6), (SELECT $node_id FROM Students WHERE ID = 2)),

-- ������� (3) ������ � ������� (7) � ����� (8)
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Students WHERE ID = 7)),
((SELECT $node_id FROM Students WHERE ID = 7), (SELECT $node_id FROM Students WHERE ID = 3)),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Students WHERE ID = 8)),
((SELECT $node_id FROM Students WHERE ID = 8), (SELECT $node_id FROM Students WHERE ID = 3)),

-- ��������� (4) ������ � ������ (9) � ����� (10)
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Students WHERE ID = 9)),
((SELECT $node_id FROM Students WHERE ID = 9), (SELECT $node_id FROM Students WHERE ID = 4)),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Students WHERE ID = 10)),
((SELECT $node_id FROM Students WHERE ID = 10), (SELECT $node_id FROM Students WHERE ID = 4));

-- ������������ ����
INSERT INTO RecommendsBook ($from_id, $to_id, Comment)
VALUES
-- ���� (1) ����������� �����
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Books WHERE ID = 3), '�������� ����������, ������ ��������� ������'),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Books WHERE ID = 10), '������ ������� ���� �����'),

-- ����� (2) ����������� �����
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Books WHERE ID = 2), '�������� ��������������� �����'),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Books WHERE ID = 9), '��������� ��������� ����� � ���������'),

-- ������� (3) ����������� �����
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Books WHERE ID = 1), '������� ������������, ���� � �������'),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Books WHERE ID = 4), '������, �� ����� ������'),

-- ��������� (4) ����������� �����
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Books WHERE ID = 5), '�������, �� ���������� �����'),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Books WHERE ID = 7), '����� ��� ��������� ������� ��������'),

-- ������� (5) ����������� �����
((SELECT $node_id FROM Students WHERE ID = 5), (SELECT $node_id FROM Books WHERE ID = 6), '����������������� �����, �� ����� �����'),
((SELECT $node_id FROM Students WHERE ID = 5), (SELECT $node_id FROM Books WHERE ID = 8), '����������� ����� ��������');

-- ������������ �������
INSERT INTO RecommendsMovie ($from_id, $to_id, Comment)
VALUES
-- ���� (1) ����������� ������
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Movies WHERE ID = 3), '������ ����� ��� �������'),
((SELECT $node_id FROM Students WHERE ID = 1), (SELECT $node_id FROM Movies WHERE ID = 10), '����� � ��������� �����'),

-- ����� (2) ����������� ������
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Movies WHERE ID = 2), '��������� ����, ���������� �����'),
((SELECT $node_id FROM Students WHERE ID = 2), (SELECT $node_id FROM Movies WHERE ID = 6), '��������� � ����� � ����� �������'),

-- ������� (3) ����������� ������
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Movies WHERE ID = 1), '���������� ������ �������������'),
((SELECT $node_id FROM Students WHERE ID = 3), (SELECT $node_id FROM Movies WHERE ID = 4), '������� ���������� ������� ������'),

-- ��������� (4) ����������� ������
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Movies WHERE ID = 5), '�������� � �������� �������'),
((SELECT $node_id FROM Students WHERE ID = 4), (SELECT $node_id FROM Movies WHERE ID = 7), '������ ������������ �����'),

-- ����� (6) ����������� ������
((SELECT $node_id FROM Students WHERE ID = 6), (SELECT $node_id FROM Movies WHERE ID = 8), '������������� ������� � �������'),
((SELECT $node_id FROM Students WHERE ID = 6), (SELECT $node_id FROM Movies WHERE ID = 9), '����������� � ������ ������������'),

-- ����� (9) ����������� ������
((SELECT $node_id FROM Students WHERE ID = 9), (SELECT $node_id FROM Movies WHERE ID = 3), '�������� �������������� �����'),
((SELECT $node_id FROM Students WHERE ID = 9), (SELECT $node_id FROM Movies WHERE ID = 10), '���������, �� ����� ���������');

-- MATCH �������
-- 1. ����� ���� ������ �����
SELECT s2.Name 
FROM Students s1, FriendsWith f, Students s2
WHERE MATCH(s1-(f)->s2)
AND s1.Name = '���� ������';

-- 2. ����� �����, ��������������� �������� �����
SELECT b.Title, b.Author
FROM Students s1, FriendsWith f, Students s2, RecommendsBook rb, Books b
WHERE MATCH(s1-(f)->s2-(rb)->b)
AND s1.Name = '����� �������';

-- 3. ����� ������, ��������������� ���������� ���
SELECT m.Title, m.Director
FROM Students s, RecommendsMovie rm, Movies m
WHERE MATCH(s-(rm)->m)
AND s.University = '���';

-- 4. ����� ���������, ������� ����������� �����, �������������� ����� 1950
SELECT DISTINCT s.Name
FROM Students s, RecommendsBook rb, Books b
WHERE MATCH(s-(rb)->b)
AND b.YearPublished > 1950;

-- 5. ����� ������ ������ �������
SELECT s3.Name
FROM Students s1, FriendsWith f1, Students s2, FriendsWith f2, Students s3
WHERE MATCH(s1-(f1)->s2-(f2)->s3)
AND s1.Name = '������� �������'
AND s3.Name != '������� �������';

-- SHORTEST PATH �������
-- 1. ����� ���������� ���� ����� ������ � ������� ����������
SELECT 
    Student1.Name AS StudentName,
    STRING_AGG(Student2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendsPath
FROM 
    Students AS Student1,
    FriendsWith FOR PATH AS fw,
    Students FOR PATH AS Student2
WHERE 
    MATCH(SHORTEST_PATH(Student1(-(fw)->Student2)+))
    AND Student1.Name = '���� ������';

-- 2. ����� ������ � ������ ������ ����� �������� 
SELECT
    s1.Name AS Student,
    STRING_AGG(s2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS Path
FROM
    Students AS s1,
    Students FOR PATH AS s2,
    FriendsWith FOR PATH AS fw
WHERE
    MATCH(SHORTEST_PATH(s1(-(fw)->s2){1,2}))
    AND s1.Name = '����� �������';

-- ��� Power Bi
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