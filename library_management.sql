
-- Drop Tables if they exist
DROP TABLE IF EXISTS user_login;
DROP TABLE IF EXISTS publisher;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS readers;
DROP TABLE IF EXISTS books_issue;
DROP TABLE IF EXISTS settings;

-- User Login Table
CREATE TABLE user_login (
    user_id TEXT PRIMARY KEY,
    user_password VARCHAR(255) NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    sign_up_on DATE DEFAULT CURRENT_DATE,
    email_id TEXT UNIQUE NOT NULL
);

-- Publisher Table
CREATE TABLE publisher (
    publisher_id TEXT PRIMARY KEY,
    publisher TEXT NOT NULL,
    distributor TEXT,
    releases_count INT DEFAULT 0,
    last_release DATE
);

-- Author Table
CREATE TABLE author (
    author_id TEXT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    publications_count INT DEFAULT 0
);

-- Books Table
CREATE TABLE books (
    book_id TEXT PRIMARY KEY,
    book_code TEXT UNIQUE NOT NULL,
    book_name TEXT NOT NULL,
    author_id TEXT NOT NULL REFERENCES author(author_id) ON DELETE CASCADE,
    publisher_id TEXT NOT NULL REFERENCES publisher(publisher_id) ON DELETE CASCADE,
    book_version TEXT,
    release_date DATE,
    available_from DATE,
    is_available BOOLEAN DEFAULT TRUE
);

-- Staff Table
CREATE TABLE staff (
    staff_id TEXT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    staff_role TEXT NOT NULL,
    start_date DATE DEFAULT CURRENT_DATE,
    last_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    work_shift_start TIME,
    work_shift_end TIME
);

-- Readers Table
CREATE TABLE readers (
    reader_id TEXT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    registered_on DATE DEFAULT CURRENT_DATE,
    books_issued_total INT DEFAULT 0,
    books_issued_current INT DEFAULT 0,
    is_issued BOOLEAN DEFAULT FALSE,
    last_issue_date DATE,
    total_fine FLOAT DEFAULT 0,
    current_fine FLOAT DEFAULT 0
);

-- Books Issue Table
CREATE TABLE books_issue (
    issue_id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id TEXT NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    issued_to TEXT NOT NULL REFERENCES readers(reader_id) ON DELETE CASCADE,
    issued_on DATE DEFAULT CURRENT_DATE,
    return_on DATE,
    returned_on DATE, -- Tracks actual return date
    current_fine FLOAT DEFAULT 0,
    fine_paid BOOLEAN DEFAULT FALSE,
    payment_transaction_id TEXT
);

-- Settings Table
CREATE TABLE settings (
    book_issue_count_per_reader INT DEFAULT 3,
    fine_per_day FLOAT DEFAULT 2.0,
    book_return_in_days INT DEFAULT 14
);

-- Indexes for Faster Queries
CREATE INDEX idx_books_name ON books(book_name);
CREATE INDEX idx_author_name ON author(first_name, last_name);
CREATE INDEX idx_reader_name ON readers(first_name, last_name);



-- Insert data into user_login table
INSERT INTO user_login (user_id, user_password, first_name, last_name, sign_up_on, email_id)
VALUES 
    ('U001', 'hashed_password_1', 'Alice', 'Johnson', '2024-01-01', 'alice@example.com'),
    ('U002', 'hashed_password_2', 'Bob', 'Smith', '2024-01-05', 'bob@example.com'),
    ('U003', 'hashed_password_3', 'Charlie', 'Brown', '2024-01-10', 'charlie@example.com');

-- Insert data into publisher table
INSERT INTO publisher (publisher_id, publisher, distributor, releases_count, last_release)
VALUES 
    ('P001', 'Penguin Random House', 'ABC Distributors', 500, '2023-12-01'),
    ('P002', 'HarperCollins', 'XYZ Distributors', 350, '2023-11-15'),
    ('P003', 'Simon & Schuster', 'LMN Distributors', 200, '2023-10-20');

-- Insert data into author table
INSERT INTO author (author_id, first_name, last_name, publications_count)
VALUES 
    ('A001', 'J.K.', 'Rowling', 15),
    ('A002', 'George R.R.', 'Martin', 10),
    ('A003', 'Agatha', 'Christie', 80);

-- Insert data into books table
INSERT INTO books (book_id, book_code, book_name, author_id, publisher_id, book_version, release_date, available_from, is_available)
VALUES 
    ('B001', 'HP001', 'Harry Potter and the Sorcerer''s Stone', 'A001', 'P001', '1st Edition', '1997-06-26', '2024-01-01', 1),
    ('B002', 'GOT001', 'Game of Thrones', 'A002', 'P002', '1st Edition', '1996-08-06', '2024-01-01', 1),
    ('B003', 'MUR001', 'Murder on the Orient Express', 'A003', 'P003', '1st Edition', '1934-01-01', '2024-01-01', 1);

-- Insert data into staff table
INSERT INTO staff (staff_id, first_name, last_name, staff_role, start_date, last_date, is_active, work_shift_start, work_shift_end)
VALUES 
    ('S001', 'Emma', 'Watson', 'Librarian', '2020-06-01', NULL, 1, '09:00', '17:00'),
    ('S002', 'John', 'Doe', 'Assistant Librarian', '2021-08-15', NULL, 1, '10:00', '18:00');

-- Insert data into readers table
INSERT INTO readers (reader_id, first_name, last_name, registered_on, books_issued_total, books_issued_current, is_issued, last_issue_date, total_fine, current_fine)
VALUES 
    ('R001', 'David', 'Miller', '2024-01-10', 2, 1, 1, '2024-01-15', 5.0, 2.0),
    ('R002', 'Sophia', 'Williams', '2024-01-12', 1, 0, 0, NULL, 0.0, 0.0),
    ('R003', 'Liam', 'Anderson', '2024-01-14', 3, 2, 1, '2024-01-18', 10.0, 5.0);

-- Insert data into books_issue table
INSERT INTO books_issue (book_id, issued_to, issued_on, return_on, returned_on, current_fine, fine_paid, payment_transaction_id)
VALUES 
    ('B001', 'R001', '2024-01-15', '2024-01-25', '2024-01-26', 2.0, 1, 'TXN12345'),
    ('B002', 'R003', '2024-01-18', '2024-01-28', NULL, 5.0, 0, NULL);

-- Insert data into settings table
INSERT INTO settings (book_issue_count_per_reader, fine_per_day, book_return_in_days)
VALUES (3, 2.0, 14);

