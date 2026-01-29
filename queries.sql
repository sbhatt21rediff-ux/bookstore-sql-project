-- ==========================================
-- Bookstore SQL Project
-- Description: Business & analytical queries
-- ==========================================


-- 1) Retrieve all books in the "Fiction" genre
SELECT title AS book_name, genre
FROM Books
WHERE genre = 'Fiction';


-- 2) Find books published after the year 1950
SELECT title AS book_name, published_year
FROM Books
WHERE published_year > 1950;


-- 3) List all customers from Canada
SELECT name AS customer_name, country
FROM Customers
WHERE country = 'Canada';


-- 4) Show orders placed in November 2023
SELECT order_id,
       customer_id,
       book_id,
       total_amount,
       order_date AS nov_month_orders
FROM Orders
WHERE order_date >= DATE '2023-11-01'
  AND order_date <  DATE '2023-12-01';


-- 5) Retrieve the total stock of books available
SELECT b.book_id,
       b.title,
       b.stock - COALESCE(SUM(o.quantity), 0) AS available_book_stock
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;


-- 6) Find the details of the most expensive book
SELECT title, price
FROM Books
ORDER BY price DESC
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book
SELECT c.name,
       c.customer_id,
       o.quantity
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
WHERE o.quantity > 1;


-- 8) Retrieve all orders where the total amount exceeds $20
SELECT customer_id,
       book_id,
       total_amount
FROM Orders
WHERE total_amount > 20;


-- 9) List all genres available in the Books table
SELECT DISTINCT genre
FROM Books;


-- 10) Find the book with the lowest stock
SELECT title, stock
FROM Books
ORDER BY stock
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue_generated
FROM Orders;


-- ==========================
-- ADVANCED QUERIES
-- ==========================


-- 12) Retrieve the total number of books sold for each genre
SELECT b.genre,
       COALESCE(SUM(o.quantity), 0) AS total_number_of_books
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.genre;


-- 13) Find the average price of books in the "Fantasy" genre
SELECT AVG(price) AS average_price_of_book
FROM Books
WHERE genre = 'Fantasy';


-- 14) List customers who have placed at least 2 orders
SELECT c.name,
       c.customer_id,
       COUNT(o.customer_id) AS no_of_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
HAVING COUNT(o.customer_id) >= 2;


-- 15) Find the most frequently ordered book
SELECT b.title,
       b.book_id,
       COUNT(o.book_id) AS most_frequently_ordered
FROM Books b
JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.title, b.book_id
ORDER BY most_frequently_ordered DESC
LIMIT 1;


-- 16) Show the top 3 most expensive books of the 'Fantasy' genre
SELECT title, genre, price
FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;


-- 17) Retrieve the total quantity of books sold by each author
SELECT b.author,
       COALESCE(SUM(o.quantity), 0) AS total_quantity_books
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.author;


-- 18) List the cities where customers who spent over $30 are located
SELECT c.city,
       SUM(o.total_amount) AS amount_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 30;


-- 19) Find the customer who spent the most on orders
SELECT c.name,
       c.customer_id,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
ORDER BY total_spent DESC
LIMIT 1;


-- 20) Calculate the stock remaining after fulfilling all orders
SELECT b.book_id,
       b.title,
       b.stock - COALESCE(SUM(o.quantity), 0) AS available_book_stock
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;
