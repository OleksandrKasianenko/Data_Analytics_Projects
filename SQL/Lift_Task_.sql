
Create database lift;

use lift;
CREATE TABLE books (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    genre VARCHAR(255),
    pages INT,
    price DECIMAL(10, 2)
);

INSERT INTO books (id, name, genre, pages, price) VALUES
(1, 'book_1', 'genre_1', 200, 30),
(2, 'book_2', 'genre_2', 170, 25),
(3, 'book_3', 'genre_3', 450, 50);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    id_book INT,
    date DATE
);

INSERT INTO orders (id, name, id_book, date) VALUES
(1, 'name_1', 1, '2024-01-01'),
(2, 'name_2', 2, '2024-01-02'),
(3, 'name_3', 3, '2024-01-03');

Select * from  orders

#1 Назву найбільшої книги

SELECT name, pages
FROM books
ORDER BY pages DESC
LIMIT 1;

#2 Усіх студентів, які брали в бібліотеці книгу name_1 (студент може взяти одну і ту саму книгу декілька разів - такі студенти мають виводитися лише раз)

SELECT *
FROM orders 
JOIN books  ON books.id = orders.id
and orders.name = 'name_1';

#3 Назви найдорожчих книг в кожному жанрі в алфавітному порядку, припускаючи, що всі ціни унікальні

with ranked AS (
    SELECT
        name ,
        genre,
        price,
        ROW_NUMBER() OVER (PARTITION BY genre ORDER BY price DESC) AS ranks
    FROM
	books 
)
SELECT
    name,
    genre,
    price
FROM
    ranked
WHERE
    ranks = 1
ORDER BY
    genre, name;

#4 Книги, які студенти не позичали протягом поточного місяця

SELECT
    books.name ,
    books.genre
FROM
    books 
LEFT JOIN
    orders  ON books.id = orders.id_book AND MONTH(orders.date) = MONTH(CURRENT_DATE()) AND YEAR(orders.date) = YEAR(CURRENT_DATE())
WHERE
    orders.id_book IS NULL;
    
    #5 Дату третьої позики книги для кожного студента (якщо така була)
    
    WITH RankedOrders AS (
    SELECT
        orders.name  ,
        orders.id_book,
        orders.date,
        ROW_NUMBER() OVER (PARTITION BY orders.name, orders.id_book ORDER BY orders.date) AS rankasa
    FROM
        orders 
)
SELECT
    name,
    orders.id_book,
    orders.date 
FROM
    RankedOrders
WHERE
    rankasa = 3;