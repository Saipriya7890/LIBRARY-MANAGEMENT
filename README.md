# Library Management System - Database Schema

This project implements a database schema for a **Library Management System**. The schema is designed to manage all aspects of library operations, including user login, books, authors, publishers, staff, readers, book issuance, and system settings. The database is created using SQL and includes relationships between tables to ensure data integrity.

## Features
1. **User Login Management**: Maintain user credentials and personal details.
2. **Author and Publisher Management**: Store information about authors and publishers, including their publications and release counts.
3. **Book Management**: Track book details, availability, authors, and publishers.
4. **Staff Management**: Record details of library staff, including their roles, shifts, and employment status.
5. **Reader Management**: Track library readers, their registration details, books issued, and fines.
6. **Book Issuance**: Manage the issuance and return of books, fines, and payment transactions.
7. **System Settings**: Configure global settings such as book issue limits, fines per day, and return periods.

## Schema Structure
### 1. **User Login Table**  
Stores login credentials and personal details of users.  
Fields: `user_id`, `user_password`, `first_name`, `last_name`, `sign_up_on`, `email_id`.

### 2. **Publisher Table**  
Maintains details about book publishers.  
Fields: `publisher_id`, `publisher`, `distributor`, `releases_count`, `last_release`.

### 3. **Author Table**  
Tracks information about authors and their publications.  
Fields: `author_id`, `first_name`, `last_name`, `publications_count`.

### 4. **Books Table**  
Contains details about books, including relationships to authors and publishers.  
Fields: `book_id`, `book_code`, `book_name`, `author_id`, `publisher_id`, `book_version`, `release_date`, `available_from`, `is_available`.

### 5. **Staff Table**  
Manages library staff information and their work schedules.  
Fields: `staff_id`, `first_name`, `last_name`, `staff_role`, `start_date`, `last_date`, `is_active`, `work_shift_start`, `work_shift_end`.

### 6. **Readers Table**  
Tracks library readers, books issued, and fines.  
Fields: `reader_id`, `first_name`, `last_name`, `registered_on`, `books_issued_total`, `books_issued_current`, `is_issued`, `last_issue_date`, `total_fine`, `current_fine`.

### 7. **Books Issue Table**  
Records book issuance details, return dates, and fines.  
Fields: `issue_id`, `book_id`, `issued_to`, `issued_on`, `return_on`, `current_fine`, `fine_paid`, `payment_transaction_id`.

### 8. **Settings Table**  
Configures global library settings such as book issue limits and fines.  
Fields: `book_issue_count_per_reader`, `fine_per_day`, `book_return_in_days`.

## Getting Started
1. **Create the Schema**:  
   Run the SQL command:  
   ```sql
   CREATE SCHEMA IF NOT EXISTS library_management;
   ```
2. **Execute the Script**:  
   Run the SQL commands to create the tables in the `library_management` schema.

## Contribution
Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.
