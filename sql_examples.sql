-- SQL Examples for Table Relationships and Joins

-- =================================================================
-- One-to-One Relationship Example
-- =================================================================

-- У каждого пользователя есть только один профиль, и у каждого профиля есть только один пользователь.

CREATE TABLE persons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
);

CREATE TABLE passports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER NOT NULL UNIQUE,
    passport_number TEXT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE
);

-- Insert data for one-to-one relationship
INSERT INTO persons (first_name, last_name) VALUES
('Иван', 'Иванов'),
('Аня', 'Султанова'),
('Алия', 'Назарбаяева'),
('Марат', 'Ахметов'),
('Сергей', 'Петров');

INSERT INTO passports (person_id, passport_number) VALUES
(1, '123456789'),
(2, '987654321'),
(3, '112233445'),
(4, '556677889'),
(5, '121314151');


-- =================================================================
-- One-to-Many Relationship Example
-- =================================================================

-- У автора может быть много книг, но книга принадлежит только одному автору.

CREATE TABLE authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    price INTEGER,
    author_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- Insert data for one-to-many relationship
INSERT INTO authors (name) VALUES
('Абай Кунанбаев'),
('Лев Толстой'),
('Мухтар Ауэзов'),
('Агата Кристи'),
('Иван Тургенев');

INSERT INTO books (title, price, author_id) VALUES
('Слова назидания', 1000, 1),
('Путь Абая', 1500, 1),
('Война и мир', 2000, 2),
('Анна Каренина', 2500, 2),
('Лихая година', 3000, 3),
('Убийство в Восточном экспрессе', 4000, 4),
('Таинственное происшествие в Стайлзе', 4500, 4),
('Десять негритят', 5000, 4),
('Книга без автора', 2000, NULL);

-- =================================================================
-- Many-to-Many Relationship Example
-- =================================================================

-- У студента может быть много курсов, и у курса может быть много студентов.

CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    gender TEXT NOT NULL
);

CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- This is the junction/join table
-- Таблица для хранения связей между студентами и курсами, таблица регистраций
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Insert data for many-to-many relationship
INSERT INTO students (name, age, gender) VALUES
('Арман Жумабаев', 22, 'male'),
('Елена Белова', 21, 'female'),
('Даулет Зеленов', 23, 'male'),
('Айша Чернова', 22, 'female'),
('Дмитрий Синев', 21, 'male');

INSERT INTO courses (name) VALUES
('Введение в Python'),
('Управление базами данных'),
('Основы веб-разработки'),
('Продвинутые алгоритмы');

INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1), -- Арман Жумабаев в Python
(1, 2), -- Арман Жумабаев в Управление базами данных
(3, 1), -- Давид Зеленов в Python
(3, 4), -- Давид Зеленов в Продвинутые алгоритмы
(4, 2), -- Айша Чернова в Управление базами данных
(4, 4), -- Айша Чернова в Продвинутые алгоритмы
(5, 1), -- Дмитрий Синев в Python
(5, 2), -- Дмитрий Синев в Управление базами данных
(5, 4); -- Дмитрий Синев в Продвинутые алгоритмы


-- =================================================================
-- JOIN Examples (for the One-to-Many relationship)
-- =================================================================

-- 1. INNER JOIN
-- Возвращает записи, которые имеют совпадающие значения в обеих таблицах.
-- Не включает 'Иван Тургенев' как он не имеет книг, и 'Книга без автора' как у нее нет автора.
SELECT 
    books.title, 
    authors.name AS author_name
FROM books
INNER JOIN authors ON books.author_id = authors.id;


-- 2. LEFT JOIN (и LEFT OUTER JOIN)
-- Возвращает все записи из левой таблицы (authors), и совпадающие записи из правой таблицы (books).
-- Результат NULL из правой стороны, если нет совпадения.
-- Включает 'Иван Тургенев' с NULL названием книги, так как у него нет книг.
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
LEFT JOIN books ON authors.id = books.author_id;


-- 3. RIGHT JOIN (эмулируем для SQLite)
-- Возвращает все записи из правой таблицы (books), и совпадающие записи из левой таблицы (authors).
-- SQLite не поддерживает RIGHT JOIN, поэтому мы эмулируем его, меняя таблицы местами и используя LEFT JOIN.

SELECT 
    authors.name AS author_name,
    books.title
FROM books
LEFT JOIN authors ON books.author_id = authors.id;


-- 4. FULL OUTER JOIN (эмулируем для SQLite)
-- Возвращает все записи, когда есть совпадение в левой или правой таблице.
-- SQLite не поддерживает FULL OUTER JOIN, поэтому мы эмулируем его с помощью LEFT JOIN и UNION.
-- (Включает 'Иван Тургенев' и 'Книга без автора')
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
LEFT JOIN books ON authors.id = books.author_id
UNION
SELECT 
    authors.name AS author_name,
    books.title
FROM books
LEFT JOIN authors ON books.author_id = authors.id;

-- В Postgres и других СУБД
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
FULL OUTER JOIN books ON authors.id = books.author_id;


-- 5. CROSS JOIN
-- Возвращает декартово произведение двух таблиц (все возможные комбинации).
-- Примечание: Это может привести к очень большому количеству строк и следует использовать с осторожностью.
CREATE TABLE IF NOT EXISTS days (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS times (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

INSERT INTO days (name) VALUES
('Понедельник'),
('Вторник'),
('Среда'),
('Четверг'),
('Пятница'),
('Суббота'),
('Воскресенье');

INSERT INTO times (name) VALUES
('17:00'),
('19:00'),
('21:00');

SELECT 
    days.name AS day_name,
    times.name AS time_name
FROM days
CROSS JOIN times;

-- 6. Self Join
-- Связь таблицы сам с собой
CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    manager_id INTEGER,
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);

INSERT INTO employees (name, manager_id) VALUES
('Анна Петрова', NULL),
('Борис Иванов', 1),
('Василиса Петрова', 1),
('Дмитрий Сидоров', 2),
('Елена Владимирова', 2);

SELECT 
    employees.name AS employee_name,
    managers.name AS manager_name
FROM employees
LEFT JOIN employees managers ON employees.manager_id = managers.id;
    
