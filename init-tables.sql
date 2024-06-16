-- Create a custom schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS dnbookstore;

-- Enable the uuid-ossp extension if it doesn't exist
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Authors table
CREATE TABLE IF NOT EXISTS dnbookstore.Authors (
    AuthorId UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL
);

-- Books table
CREATE TABLE IF NOT EXISTS dnbookstore.Books (
    BookId UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Title VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    PublishedDate DATE,
    AuthorId UUID NOT NULL,
    Price DECIMAL(10, 2),
    FOREIGN KEY (AuthorId) REFERENCES dnbookstore.Authors (AuthorId)
);

-- Customers table
CREATE TABLE IF NOT EXISTS dnbookstore.Customers (
    CustomerId UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transactions table
CREATE TABLE IF NOT EXISTS dnbookstore.Transactions (
    TransactionId UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    CustomerId UUID NOT NULL,
    BookId UUID NOT NULL,
    TransactionType VARCHAR(50), -- Rent, Buy, Sell
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerId) REFERENCES dnbookstore.Customers (CustomerId),
    FOREIGN KEY (BookId) REFERENCES dnbookstore.Books (BookId)
);

-- Reviews table
CREATE TABLE IF NOT EXISTS dnbookstore.Reviews (
    ReviewId UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    CustomerId UUID NOT NULL,
    BookId UUID NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    ReviewText TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerId) REFERENCES dnbookstore.Customers (CustomerId),
    FOREIGN KEY (BookId) REFERENCES dnbookstore.Books (BookId)
);
