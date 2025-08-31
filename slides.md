---
theme: seriph
background: https://cover.sli.dev
title: Урок 8
info: |
  ## Backend Lesson 8
class: text-center
drawings:
  persist: false
transition: slide-left
mdc: true
---

# Добро пожаловать

---
layout: section
---

После 8 урока и перед началом 3-го месяца обучения вы должны договориться с техническим ментором о том, чтобы он вам установил Ubuntu на ноутбук!!!

---

### Базы данных

#### SELECT

SELECT - это ключевое слово в SQL, которое используется для выбора данных из таблицы.

**Пример:**

```sql
SELECT * FROM books;
```

Выборка всех записей из таблицы books. Звездочка(*) означает "все столбцы".
Для выбора конкретных столбцов мы указываем их имена через запятую.

**Пример:**

```sql
SELECT title, price FROM books;
```

Выборка только названия и цены книг.


---

#### WHERE

WHERE используется для ***фильтрации*** строк на основе определенного условия.

**Пример:**

```sql
SELECT title, price FROM books WHERE price > 100;
```

Выборка книг, цена которых больше 100. Иначе: выбрать все записи из таблицы books, для которых значение столбца price больше 100.

```sql
DELETE FROM books WHERE id = 1;
```

Удаление книги с id = 1. Иначе: удалить все записи из таблицы books, для которых значение столбца id равно 1.

---

#### WHERE

WHERE используется для ***фильтрации*** строк на основе определенного условия.

```sql
SELECT * FROM students WHERE age < 20 AND city = 'Karakol';
```

Выборка всех студентов младше 20 лет И из города Karakol.

---

#### ORDER BY и LIMIT

ORDER BY используется для ***сортировки*** строк на основе определенного столбца(-ов).

**Пример:**

```sql
SELECT * FROM students ORDER BY age DESC;
```

Выборка всех студентов, отсортированных по возрасту в порядке убывания.

LIMIT используется для ограничения количества возвращаемых строк.

**Пример:**

```sql
SELECT * FROM students LIMIT 2;
```

Выборка первых 2 студентов.

```sql
SELECT * FROM students ORDER BY city LIMIT 2;
```

Выборка первых 2 студентов, после сортировки таблицы по городу.

---
layout: two-cols
---

#### Внешний ключ (Foreign Key) в SQL

**Внешний ключ** — это ключ, используемый для связи двух таблиц. Это поле (или набор полей) в одной таблице, которое ссылается на **первичный ключ (Primary Key)** в другой таблице. `REFERENCES` - переводится как "ссылается".

Таблица, содержащая внешний ключ, называется дочерней, а таблица, на которую он ссылается, — родительской.

::right::

**Пример:**
- У нас есть таблицы `authors` (авторы) и `books` (книги).
- Каждая книга написана одним автором.
- В таблице `books` будет столбец `author_id`, который указывает на `id` автора, написавшего книгу.


```sql
CREATE TABLE authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);
```

---

#### Отношения между таблицами в SQL

В реляционной базе данных мы можем определять отношения между таблицами. Это помогает поддерживать целостность данных и отражать реальные связи между ними.

Существует три основных типа отношений:

- **Один-к-одному (One-to-One)**
- **Один-ко-многим (One-to-Many)**
- **Многие-ко-многим (Many-to-Many)**

Эти отношения устанавливаются с помощью первичных и внешних ключей.

---

#### Отношение Один-к-одному (One-to-One)

Каждая запись в Таблице А может быть связана только с одной записью в Таблице Б, и наоборот.

**Пример из реального мира:** `Человек` и его `Паспорт`.
У каждого человека может быть только один действующий паспорт (определенной страны), и каждый паспорт выдан только одному человеку.

**Как это создается:**
Это достигается путем размещения внешнего ключа в одной таблице, который ссылается на другую, и добавления ограничения `UNIQUE` к этому столбцу внешнего ключа.


```sql
CREATE TABLE persons (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT
);

CREATE TABLE passports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    passport_number TEXT UNIQUE,
    person_id INTEGER UNIQUE, 
    -- Ограничение UNIQUE здесь ключевое, 
    -- чтобы не было дублирования паспортов одного человека
    FOREIGN KEY (person_id) REFERENCES persons(id)
);
```

---

#### Отношение Один-ко-многим (One-to-Many)

Запись в Таблице А может быть связана с несколькими записями в Таблице Б, но запись в Таблице Б может быть связана только с одной записью в Таблице А.

**Пример из реального мира:** `Автор` и его `Книги`.
Один автор может написать много книг, но каждая книга (в этой простой модели) написана только одним автором.

**Как это создается:**
Это самый распространенный тип отношений. Он создается путем добавления внешнего ключа на сторону "многих", который ссылается на сторону "одного".

```sql
CREATE TABLE authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    price INTEGER,
    author_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);
```

---

#### Отношение Многие-ко-многим (Many-to-Many)

Запись в Таблице А может быть связана с несколькими записями в Таблице Б, и запись в Таблице Б также может быть связана с несколькими записями в Таблице А.

**Пример из реального мира:** `Студенты` и `Курсы`.
Студент может записаться на много курсов, и на курсе может быть много студентов.

**Как это создается:**
Это отношение требует третьей, **связующей таблицы** (junction table). Эта таблица хранит отношения, имея внешние ключи к обеим таблицам.

---

#### Отношение Многие-ко-многим (Many-to-Many)

```sql
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);
-- Связующая таблица
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    PRIMARY KEY (student_id, course_id), -- Составной первичный ключ
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
    -- Два внешних ключа, один на студентов, другой на курсы
);
```

---

#### JOIN - объединение таблиц

JOIN используется для объединения строк из двух или более таблиц на основе определенного условия.

Существует несколько типов JOIN:

1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN
4. FULL JOIN
5. CROSS JOIN
6. SELF JOIN

---

#### INNER JOIN

INNER JOIN возвращает только те строки, которые имеют совпадающие значения в обеих таблицах.

**Пример:**

```sql
SELECT 
    books.title, 
    authors.name AS author_name
FROM books
INNER JOIN authors ON books.author_id = authors.id;
```

Где `ON books.author_id = authors.id` - это условие, которое определяет, как мы объединяем таблицы.

В этом запросе не возвращаются книги, у которых не указан автор и авторы у которых нет книг.

---

#### LEFT JOIN(LEFT OUTER JOIN)

LEFT JOIN возвращает все строки из левой таблицы (authors), и совпадающие строки из правой таблицы (books). Если в правой таблице нет совпадений, то возвращаются NULL.

**Пример:**

```sql
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
LEFT JOIN books ON authors.id = books.author_id;
```

---

#### RIGHT JOIN(RIGHT OUTER JOIN)

RIGHT JOIN возвращает все строки из правой таблицы (books), и совпадающие строки из левой таблицы (authors). Если в левой таблице нет совпадений, то возвращаются NULL.

**Пример:**

```sql
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
RIGHT JOIN books ON authors.id = books.author_id;
```

В SQLite RIGHT JOIN не поддерживается, но можно использовать LEFT JOIN с обратной связью.

**Пример:**

```sql
SELECT 
    books.title,
    authors.name AS author_name
FROM books
LEFT JOIN authors ON books.author_id = authors.id;
```

---

#### FULL JOIN(FULL OUTER JOIN)

FULL JOIN возвращает все строки из обеих таблиц, и совпадающие строки из обеих таблиц. Если в одной из таблиц нет совпадений, то возвращаются NULL.

В SQLite FULL JOIN не поддерживается, но можно использовать UNION ALL в сочетании с LEFT JOIN и RIGHT JOIN.

**Пример в PostgreSQL:**

```sql
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
FULL OUTER JOIN books ON authors.id = books.author_id;
```

---

#### FULL JOIN(FULL OUTER JOIN)

**Пример в SQLite:**

```sql
SELECT 
    authors.name AS author_name,
    books.title
FROM authors
LEFT JOIN books ON authors.id = books.author_id
UNION ALL
SELECT 
    authors.name AS author_name,
    books.title
FROM books
LEFT JOIN authors ON books.author_id = authors.id;
```

Где UNION ALL используется для объединения результатов двух SELECT-запросов.

---

#### CROSS JOIN

CROSS JOIN возвращает все возможные комбинации строк из двух таблиц(декартово произведение)
 
Например комбинации цветов и размеров одежды и тд

**Пример:**

```sql
SELECT 
    colors.color,
    sizes.size
FROM colors
CROSS JOIN sizes;
```

Примечание: Это может привести к очень большим объемам данных и следует использовать с осторожностью.

---

#### Агрегатные функции

Агрегатные функции выполняют вычисления над набором значений и возвращают одно значение.

Есть следующие агрегатные функции:

- COUNT() - возвращает количество строк
- SUM() - возвращает сумму значений
- AVG() - возвращает среднее значение
- MAX() - возвращает максимальное значение
- MIN() - возвращает минимальное значение

---

#### Агрегатные функции

**Пример:**

```sql
SELECT 
    COUNT(*) AS total_books,
    AVG(price) AS average_price,
    MAX(price) AS max_price,
    MIN(price) AS min_price,
    SUM(price) AS total_price
FROM books;
```

--- 

#### Группировка данных

GROUP BY используется для группировки строк на основе одного или нескольких столбцов.

**Пример:**

```sql
SELECT 
    author_id,
    COUNT(*) AS total_books, -- Возвращает количество книг для каждого автора
    AVG(price) AS average_price, -- Возвращает среднюю цену книг для каждого автора
    MAX(price) AS max_price, -- Возвращает максимальную цену книг для каждого автора
    MIN(price) AS min_price, -- Возвращает минимальную цену книг для каждого автора
    SUM(price) AS total_price -- Возвращает общую сумму цен книг для каждого автора
FROM books
GROUP BY author_id;
```

Здесь мы группируем книги по автору и вычисляем количество книг, среднюю цену, максимальную цену, минимальную цену и общую сумму для каждого автора.

