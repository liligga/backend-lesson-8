from sqlite3 import connect as sqlite_connect, Connection


def create_tables(conn: Connection):
    conn.execute("""
        CREATE TABLE persons (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
        )
    """)

    conn.execute("""
        CREATE TABLE IF NOT EXISTS passports (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            passport_number TEXT,
            person_id INTEGER,
            FOREIGN KEY (person_id) REFERENCES persons(id)
        )
    """)


    conn.execute("""
        CREATE TABLE authors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        )
    """)

    conn.execute("""
        CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            price INTEGER,
            author_id INTEGER,
            FOREIGN KEY (author_id) REFERENCES authors(id)
        )
    """)

def add_person(conn: Connection, first_name: str, last_name: str):
    conn.execute(
        "INSERT INTO persons (first_name, last_name) VALUES (?, ?)",
        (first_name, last_name),
    )
    conn.commit()

def add_passport(conn: Connection, person_id: int, passport_number: str):
    conn.execute(
        "INSERT INTO passports (person_id, passport_number) VALUES (?, ?)",
        (person_id, passport_number),
    )
    conn.commit()

def add_author(conn: Connection, name: str):
    conn.execute("INSERT INTO authors (name) VALUES (?)", (name,))

def add_book(conn: Connection, title: str, price: str, author_id: int):
    conn.execute(
        "INSERT INTO books (title, price, author_id) VALUES (?, ?, ?)",
        (title, price, author_id),
    )


def inner_join_example(conn: Connection):
    """
    INNER JOIN - возвращает записи, которые имеют совпадающие значения в обеих таблицах.
    Не включает 'Иван Тургенев' так как у него нет книг, и 'Книга без автора' так как у неё нет автора.
    """
    print("\n1. Пример INNER JOIN:")
    cursor = conn.execute("""
        SELECT 
            books.title, 
            authors.name AS author_name
        FROM books
        INNER JOIN authors ON books.author_id = authors.id
    """)
    for row in cursor.fetchall():
        print(f"Книга: {row[0]}, Автор: {row[1]}")


def left_join_example(conn: Connection):
    """
    LEFT JOIN - возвращает все записи из левой таблицы (authors) и совпадающие записи из правой таблицы (books).
    Включает 'Иван Тургенев' с NULL названием книги, так как у него нет книг.
    """
    print("\n2. Пример LEFT JOIN:")
    cursor = conn.execute("""
        SELECT 
            authors.name AS author_name,
            books.title
        FROM authors
        LEFT JOIN books ON authors.id = books.author_id
    """)
    for row in cursor.fetchall():
        book_title = row[1] if row[1] else "Нет книг"
        print(f"Автор: {row[0]}, Книга: {book_title}")


def right_join_example(conn: Connection):
    """
    RIGHT JOIN (эмулируется для SQLite) - возвращает все записи из правой таблицы (books) и совпадающие записи из левой таблицы (authors).
    SQLite не поддерживает RIGHT JOIN, поэтому мы эмулируем его, меняя таблицы местами и используя LEFT JOIN.
    Включает 'Книга без автора' с NULL именем автора.
    """
    print("\n3. Пример RIGHT JOIN (эмулируется для SQLite):")
    cursor = conn.execute("""
        SELECT 
            authors.name AS author_name,
            books.title
        FROM books
        LEFT JOIN authors ON books.author_id = authors.id
    """)
    for row in cursor.fetchall():
        author_name = row[0] if row[0] else "Нет автора"
        print(f"Автор: {author_name}, Книга: {row[1]}")


def full_outer_join_example(conn: Connection):
    """
    FULL OUTER JOIN (эмулируется для SQLite) - возвращает все записи, когда есть совпадение в левой или правой таблице.
    SQLite не поддерживает FULL OUTER JOIN, поэтому мы эмулируем его с помощью LEFT JOIN и UNION.
    Включает и 'Иван Тургенев' и 'Книга без автора'.
    """
    print("\n4. Пример FULL OUTER JOIN (эмулируется для SQLite):")
    cursor = conn.execute("""
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
        LEFT JOIN authors ON books.author_id = authors.id
    """)
    for row in cursor.fetchall():
        author_name = row[0] if row[0] else "Нет автора"
        book_title = row[1] if row[1] else "Нет книг"
        print(f"Автор: {author_name}, Книга: {book_title}")

if __name__ == "__main__":
    conn = sqlite_connect("database.sqlite3")

    create_tables(conn)

    add_person(conn, 'Иван', 'Иванов')
    add_person(conn, 'Аня', 'Султанова')
    add_person(conn, 'Алия', 'Назарбаяева')
    add_person(conn, 'Марат', 'Ахметов')
    add_person(conn, 'Сергей', 'Петров')

    add_passport(conn, 1, '123456789')
    add_passport(conn, 2, '987654321')
    add_passport(conn, 3, '112233445')
    add_passport(conn, 4, '556677889')
    add_passport(conn, 5, '121314151')

    add_author(conn, 'Абай Кунанбаев')
    add_author(conn, 'Лев Толстой')
    add_author(conn, 'Мухтар Ауэзов')
    add_author(conn, 'Агата Кристи')
    add_author(conn, 'Иван Тургенев')

    add_book(conn, 'Слова назидания', 1000, 1)
    add_book(conn, 'Путь Абая', 1500, 1)
    add_book(conn, 'Война и мир', 2000, 2)
    add_book(conn, 'Анна Каренина', 2500, 2)
    add_book(conn, 'Лихая година', 3000, 3)
    add_book(conn, 'Убийство в Восточном экспрессе', 4000, 4)
    add_book(conn, 'Таинственное происшествие в Стайлзе', 4500, 4)
    add_book(conn, 'Десять негритят', 5000, 4)
    add_book(conn, 'Книга без автора', 2000, None)

    # Выполняем примеры JOIN
    inner_join_example(conn)
    left_join_example(conn)
    right_join_example(conn)
    full_outer_join_example(conn)

    conn.close()