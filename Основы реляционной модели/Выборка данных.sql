-- Вывести информацию о всех книгах, хранящихся на складе.
SELECT * FROM book

-- Выбрать авторов, название книг и их цену из таблицы book.
SELECT author, title, price FROM book;

-- Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор.
SELECT title AS Название, author AS Автор FROM book;

-- В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack
SELECT title, amount, 
    amount * 1.65 AS pack 
FROM book;

-- В конце года цену каждой книги на складе пересчитывают – снижают ее на 30%. Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.
SELECT title, author, amount, 
    ROUND(price * 0.70, 2) AS new_price 
FROM book;

-- Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price
SELECT  author, title,
    ROUND(IF(author = "Булгаков М.А.", 
        price * 1.10, 
        IF(author = "Есенин С.А.", 
            price * 1.05, 
            price)), 2) 
    AS new_price
    FROM book;

-- Вывести автора, название  и цены тех книг, количество которых меньше 10.
SELECT author, title, price
FROM book
WHERE amount < 10;

-- Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.
SELECT title, author, price, amount
FROM book
WHERE (price > 600 OR price < 500) AND price * amount >= 5000;

-- Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .
SELECT title, author
FROM book
WHERE (price BETWEEN 540.50 AND 800) AND (amount IN (2, 3, 5 ,7));

-- Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).
SELECT author, title
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title ASC;

-- Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С».
SELECT title, author
FROM book
WHERE title LIKE "% %" AND title LIKE "__%" AND author LIKE "%С.%"
ORDER BY title;

-- Придумайте один или несколько запросов к нашей таблице book. Проверьте, правильно ли они работают
UPDATE book
SET author = 'Ozon671Games';
SELECT author, CONCAT('Гарри Поттер и ', title) AS title
FROM book
ORDER BY title;