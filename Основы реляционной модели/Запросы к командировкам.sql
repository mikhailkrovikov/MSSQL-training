-- Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», в отсортированном по убыванию даты последнего дня командировки виде.
SELECT name, city, per_diem, date_first, date_last
FROM trip
WHERE name LIKE "%а _._."
ORDER  BY date_last DESC;

-- Вывести в алфавитном порядке фамилии и инициалы тех сотрудников, которые были в командировке в Москве.
SELECT DISTINCT name
FROM trip
WHERE city = 'Москва'
ORDER BY name ASC;

-- Для каждого города посчитать, сколько раз сотрудники в нем были.  Информацию вывести в отсортированном в алфавитном порядке по названию городов. Вычисляемый столбец назвать Количество. 
SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
ORDER BY city ASC;

-- Вывести два города, в которых чаще всего были в командировках сотрудники. Вычисляемый столбец назвать Количество.
SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
ORDER BY Количество DESC
LIMIT 2;

-- Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, город ,  длительность командировки в днях, при этом первый и последний день относится к периоду командировки).
SELECT name, city, DATEDIFF(date_last, date_first)+1 AS Длительность
FROM trip
WHERE city NOT IN ("Москва", "Санкт-Петербург") 
ORDER BY Длительность DESC;

-- Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени. В результат включить столбцы name, city, date_first, date_last.
SELECT name, city, date_first, date_last
FROM trip
WHERE DATEDIFF(date_last, date_first) in 
(
  SELECT MIN(DATEDIFF(date_last, date_first)) 
  FROM trip
);

-- Вывести информацию о командировках, начало и конец которых относятся к одному месяцу (год может быть любой).
SELECT name, city, date_first, date_last
FROM trip
WHERE MONTH(date_first) = MONTH(date_last)
ORDER BY city, name;

-- Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к некоторому месяцу, если она началась в этом месяце.
SELECT MONTHNAME(date_first) AS Месяц , COUNT(MONTHNAME(date_first)) AS Количество
FROM trip
GROUP BY MONTHNAME(date_first)
ORDER BY Количество DESC, Месяц ASC;

-- Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, первый день которых пришелся на февраль или март 2020 года.
SELECT name, city, date_first, (DATEDIFF(date_last, date_first)+1) * per_diem AS Сумма
FROM trip
WHERE MONTH(date_first) in (2, 3)
ORDER BY name ASC, Сумма DESC;

-- Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников, которые были в командировках больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. Последний столбец назвать Сумма.
SELECT name, SUM((DATEDIFF(date_last, date_first)+1) * per_diem) AS Сумма
FROM trip
WHERE name IN 
(
  SELECT name
  FROM trip
  GROUP BY name
  HAVING COUNT(name) > 3
)
GROUP BY name
ORDER BY Сумма DESC;