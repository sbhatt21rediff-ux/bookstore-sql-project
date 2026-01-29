DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    genre VARCHAR(50),
    published_year INT CHECK (published_year >= 0),
    price NUMERIC(10,2) CHECK (price >= 0),
    stock INT CHECK (stock >= 0)
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    country VARCHAR(150)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    book_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT CHECK (quantity > 0),
    total_amount NUMERIC(10,2) CHECK (total_amount >= 0),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    CONSTRAINT fk_book
        FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
);

-- =========================
-- DATA LOAD 
-- =========================

-- Books 
COPY Books (title, author, genre, published_year, price, stock)
FROM 'C:/Program Files/PostgreSQL/18/data/Books.csv'
CSV HEADER;

-- Customers 
COPY Customers (name, email, phone, city, country)
FROM 'C:/Program Files/PostgreSQL/18/data/Customers.csv'
CSV HEADER;

-- Orders 
COPY Orders (customer_id, book_id, order_date, quantity, total_amount)
FROM 'C:/Program Files/PostgreSQL/18/data/Orders.csv'
CSV HEADER;
