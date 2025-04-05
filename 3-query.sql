/*markdown
# OmniLibrary Feature Demonstration Queries
*/

/*markdown
## 1. User Registration & Authentication Queries
---
*/

-- Check if an email already exists (for email validation during registration)
SELECT COUNT(*) AS email_exists 
FROM USER 
WHERE email = 'new.user@example.com';

-- Register a new user
INSERT INTO USER (email, password, full_name, phone_number)
VALUES ('new.user@example.com', '$2a$10$new45uvwGHI6jkL7mnoPQRST8UvWXyZ9Nbcde1fghI2JklmNOP3qr', 'New User', '555-123-4567');

-- Authenticate a user (retrieve user details for password verification)
SELECT user_id, email, password, full_name, user_status
FROM USER
WHERE email = 'john.doe@example.com';

-- Update last login timestamp after successful authentication
UPDATE USER
SET last_login = CURRENT_TIMESTAMP
WHERE user_id = 4;

/*markdown
## 2. User Management (RBAC) Queries
---
*/

-- Get user details with their assigned roles
SELECT u.user_id, u.full_name, u.email, u.user_status, 
       GROUP_CONCAT(r.role_name) AS roles
FROM USER u
JOIN USER_ROLE ur ON u.user_id = ur.user_id
JOIN ROLE r ON ur.role_id = r.role_id
GROUP BY u.user_id, u.full_name, u.email, u.user_status;

-- Assign a new role to a user
INSERT INTO USER_ROLE (user_id, role_id)
VALUES (8, 2); -- Assign librarian role to user 8

-- Remove a role from a user
DELETE FROM USER_ROLE
WHERE user_id = 8 AND role_id = 2;

-- Check if user has admin privileges
SELECT COUNT(*) > 0 AS is_admin
FROM USER_ROLE ur
JOIN ROLE r ON ur.role_id = r.role_id
WHERE ur.user_id = 1 AND r.role_name = 'admin';

-- Change user status (activate/suspend)
UPDATE USER
SET user_status = 'suspended'
WHERE user_id = 7;

/*markdown
## 3. Advanced Book Search & Filtering Queries
---
*/

-- Search books by title (full or partial match)
SELECT b.book_id, b.isbn, b.title, b.publication_year, b.available_copies,
       GROUP_CONCAT(DISTINCT a.author_name) AS authors,
       GROUP_CONCAT(DISTINCT g.genre_name) AS genres
FROM BOOK b
LEFT JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
LEFT JOIN AUTHOR a ON ba.author_id = a.author_id
LEFT JOIN BOOK_GENRE bg ON b.book_id = bg.book_id
LEFT JOIN GENRE g ON bg.genre_id = g.genre_id
WHERE b.title LIKE '%Harry Potter%'
GROUP BY b.book_id, b.isbn, b.title, b.publication_year, b.available_copies;

-- Search books by author
SELECT b.book_id, b.isbn, b.title, b.publication_year, b.available_copies
FROM BOOK b
JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
JOIN AUTHOR a ON ba.author_id = a.author_id
WHERE a.author_name LIKE '%Rowling%';

-- Filter books by genre
SELECT b.book_id, b.isbn, b.title, b.publication_year, b.available_copies,
       GROUP_CONCAT(DISTINCT a.author_name) AS authors
FROM BOOK b
JOIN BOOK_GENRE bg ON b.book_id = bg.book_id
JOIN GENRE g ON bg.genre_id = g.genre_id
LEFT JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
LEFT JOIN AUTHOR a ON ba.author_id = a.author_id
WHERE g.genre_name = 'Science Fiction'
GROUP BY b.book_id, b.isbn, b.title, b.publication_year, b.available_copies;

-- Filter books by average rating (4 stars and above)
SELECT b.book_id, b.title, b.isbn,
       AVG(r.rating) AS average_rating,
       COUNT(r.review_id) AS review_count
FROM BOOK b
JOIN REVIEW r ON b.book_id = r.book_id
WHERE r.review_status = 'approved'
GROUP BY b.book_id, b.title, b.isbn
HAVING AVG(r.rating) >= 4
ORDER BY average_rating DESC;

-- Filter books by publication year
SELECT b.book_id, b.isbn, b.title, b.publication_year, b.available_copies
FROM BOOK b
WHERE b.publication_year BETWEEN 1990 AND 2000
ORDER BY b.publication_year DESC;

-- Combined search and filter (books by a specific author in a specific genre)
SELECT b.book_id, b.isbn, b.title, b.publication_year
FROM BOOK b
JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
JOIN AUTHOR a ON ba.author_id = a.author_id
JOIN BOOK_GENRE bg ON b.book_id = bg.book_id
JOIN GENRE g ON bg.genre_id = g.genre_id
WHERE a.author_name LIKE '%King%' AND g.genre_name = 'Horror';

-- New arrivals (books added in the last 30 days)
SELECT b.book_id, b.isbn, b.title, b.date_added
FROM BOOK b
WHERE b.date_added >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 30 DAY)
ORDER BY b.date_added DESC;

/*markdown
## 4. Book Borrowing & Transaction Processing Queries
---
*/

-- Check available copies before borrowing
SELECT book_id, title, available_copies
FROM BOOK
WHERE book_id = 1 AND available_copies > 0;

-- Check user borrowing eligibility (active status, no overdue books, under limit)
SELECT 
    u.user_status = 'active' AS is_active,
    (SELECT COUNT(*) > 0 FROM TRANSACTION 
     WHERE user_id = 5 AND transaction_status = 'overdue') AS has_overdue,
    (SELECT COUNT(*) FROM TRANSACTION 
     WHERE user_id = 5 AND transaction_status = 'borrowed') AS current_borrowed_count
FROM USER u
WHERE u.user_id = 5;

-- Create a new borrowing transaction
INSERT INTO TRANSACTION (user_id, book_id, due_date)
VALUES (5, 3, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 14 DAY));

-- Update book availability after borrowing
UPDATE BOOK
SET available_copies = available_copies - 1
WHERE book_id = 3;

-- Get all active borrowed books for a user
SELECT t.transaction_id, b.title, a.author_name, 
       t.borrow_date, t.due_date,
       DATEDIFF(t.due_date, CURRENT_TIMESTAMP) AS days_remaining
FROM TRANSACTION t
JOIN BOOK b ON t.book_id = b.book_id
JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
JOIN AUTHOR a ON ba.author_id = a.author_id
WHERE t.user_id = 5 AND t.transaction_status = 'borrowed'
ORDER BY t.due_date;

-- Send due date reminder (books due in the next 3 days)
SELECT t.transaction_id, u.user_id, u.email, u.full_name, b.title, t.due_date
FROM TRANSACTION t
JOIN USER u ON t.user_id = u.user_id
JOIN BOOK b ON t.book_id = b.book_id
WHERE t.transaction_status = 'borrowed'
AND t.due_date BETWEEN CURRENT_TIMESTAMP AND DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 3 DAY);

/*markdown
## 5. Book Return & Fine Calculation Queries
---
*/

-- Process book return
UPDATE TRANSACTION
SET 
    return_date = CURRENT_TIMESTAMP,
    transaction_status = CASE 
        WHEN CURRENT_TIMESTAMP > due_date THEN 'overdue'
        ELSE 'returned'
    END
WHERE transaction_id = 5 AND return_date IS NULL;

-- Update book availability after return
UPDATE BOOK
SET available_copies = available_copies + 1
WHERE book_id = (SELECT book_id FROM TRANSACTION WHERE transaction_id = 5);

-- Calculate fine for overdue book
UPDATE TRANSACTION
SET 
    fine_amount = DATEDIFF(IFNULL(return_date, CURRENT_TIMESTAMP), due_date) * 0.50
WHERE transaction_id = 8 AND due_date < IFNULL(return_date, CURRENT_TIMESTAMP);

-- Create fine record for overdue return
INSERT INTO FINE (transaction_id, amount, payment_status)
SELECT transaction_id, fine_amount, 'pending'
FROM TRANSACTION
WHERE transaction_id = 8 AND fine_amount > 0;

-- List all overdue books with calculated fines (ignoring fines as 0 and showing one fee per user and book)
SELECT 
    MIN(t.transaction_id) AS transaction_id, -- Select the earliest transaction ID for uniqueness
    u.full_name, 
    b.title, 
    t.due_date, 
    DATEDIFF(CURRENT_TIMESTAMP, t.due_date) AS days_overdue,
    t.fine_amount AS calculated_fine
FROM TRANSACTION t
JOIN USER u ON t.user_id = u.user_id
JOIN BOOK b ON t.book_id = b.book_id
WHERE t.due_date < CURRENT_TIMESTAMP 
AND t.return_date IS NULL
AND t.fine_amount > 0
GROUP BY u.user_id, b.book_id, t.due_date, t.fine_amount
ORDER BY days_overdue DESC;

/*markdown
## 6. Fine Payment & Status Update Queries
---
*/

-- Get all pending fines for a user
SELECT f.fine_id, t.transaction_id, b.title, f.amount, 
       f.fine_date, f.payment_status
FROM FINE f
JOIN TRANSACTION t ON f.transaction_id = t.transaction_id
JOIN BOOK b ON t.book_id = b.book_id
WHERE t.user_id = 7 AND f.payment_status = 'pending';

-- Process fine payment
UPDATE FINE
SET 
    payment_date = CURRENT_TIMESTAMP,
    payment_method = 'credit_card',
    payment_status = 'paid',
    receipt_number = CONCAT('FIN', LPAD(fine_id, 5, '0'))
WHERE fine_id = 2;

-- Update transaction fine status
UPDATE TRANSACTION t
JOIN FINE f ON t.transaction_id = f.transaction_id
SET t.fine_status = f.payment_status
WHERE f.fine_id = 2;

-- Generate receipt for payment
SELECT 
    f.receipt_number, u.full_name, b.title,
    f.amount, f.payment_date, f.payment_method
FROM FINE f
JOIN TRANSACTION t ON f.transaction_id = t.transaction_id
JOIN USER u ON t.user_id = u.user_id
JOIN BOOK b ON t.book_id = b.book_id
WHERE f.fine_id = 2;

-- Waive fine for a special case
UPDATE FINE
SET 
    payment_status = 'waived',
    payment_method = 'waived',
    payment_date = CURRENT_TIMESTAMP
WHERE fine_id = 3;

/*markdown
## 7. User Reviews & Ratings Queries
---
*/

-- Add a new review
INSERT INTO REVIEW (user_id, book_id, rating, review_text)
VALUES (6, 7, 4, 'A fantastic classic that holds up well. The prose is sparse but powerful.');

-- Get average rating for a book
SELECT 
    b.book_id, b.title,
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.rating), 1) AS average_rating
FROM BOOK b
LEFT JOIN REVIEW r ON b.book_id = r.book_id
WHERE b.book_id = 1 AND r.review_status = 'approved'
GROUP BY b.book_id, b.title;

-- Get all reviews for a book
SELECT 
    r.review_id, u.full_name, r.rating, r.review_text, 
    r.review_date, r.review_status
FROM REVIEW r
JOIN USER u ON r.user_id = u.user_id
WHERE r.book_id = 1
ORDER BY r.review_date DESC;

-- Moderate reviews (approve/reject)
UPDATE REVIEW
SET review_status = 'approved'
WHERE review_id = 8;

-- Find top-rated books (with at least 3 reviews)
SELECT 
    b.book_id, b.title, 
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.rating), 1) AS average_rating
FROM BOOK b
JOIN REVIEW r ON b.book_id = r.book_id
WHERE r.review_status = 'approved'
GROUP BY b.book_id, b.title
HAVING COUNT(r.review_id) >= 3
ORDER BY average_rating DESC, review_count DESC
LIMIT 10;

-- Check if a user has already reviewed a book
SELECT COUNT(*) > 0 AS already_reviewed
FROM REVIEW
WHERE user_id = 5 AND book_id = 7;

/*markdown
## 8. Book Reservations & Notifications Queries
---
*/

-- Check if a book is available for reservation
SELECT 
    b.book_id, b.title, b.available_copies,
    CASE 
        WHEN b.available_copies > 0 THEN 'Available'
        ELSE 'Unavailable'
    END AS availability_status,
    (SELECT COUNT(*) FROM RESERVATION WHERE book_id = b.book_id AND reservation_status = 'pending') AS current_reservations
FROM BOOK b
WHERE b.book_id = 10;

-- Create a new reservation
INSERT INTO RESERVATION (user_id, book_id, expiry_date, queue_position)
SELECT 
    7, 10, 
    DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY),
    IFNULL((SELECT MAX(queue_position) FROM RESERVATION WHERE book_id = 10 AND reservation_status = 'pending'), 0) + 1;

-- Get all reservations for a book with queue information
SELECT 
    r.reservation_id, r.user_id, u.full_name, r.reservation_date, 
    r.expiry_date, r.queue_position
FROM RESERVATION r
JOIN USER u ON r.user_id = u.user_id
WHERE r.book_id = 10 AND r.reservation_status = 'pending'
ORDER BY r.queue_position;

-- Find books that became available and need notifications
SELECT 
    b.book_id, b.title, r.reservation_id, r.user_id, u.email, u.full_name
FROM BOOK b
JOIN RESERVATION r ON b.book_id = r.book_id
JOIN USER u ON r.user_id = u.user_id
WHERE b.available_copies > 0
AND r.reservation_status = 'pending'
AND r.queue_position = 1;

-- Create notification for book availability
INSERT INTO NOTIFICATION (user_id, notification_type, message)
SELECT 
    r.user_id, 'reservation',
    CONCAT('The book you reserved "', b.title, '" is now available. Please collect within 48 hours.')
FROM RESERVATION r
JOIN BOOK b ON r.book_id = b.book_id
WHERE r.reservation_id = 3 AND r.reservation_status = 'pending';

-- Update queue positions after reservation fulfillment or cancellation
UPDATE RESERVATION
SET queue_position = queue_position - 1
WHERE book_id = 10
AND reservation_status = 'pending'
AND queue_position > 1;

/*markdown
## 9. Reports & Analytics Queries
---
*/

-- Most borrowed books in the last 30 days
SELECT 
    b.book_id, b.title, 
    COUNT(t.transaction_id) AS borrow_count
FROM TRANSACTION t
JOIN BOOK b ON t.book_id = b.book_id
WHERE t.borrow_date >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 30 DAY)
GROUP BY b.book_id, b.title
ORDER BY borrow_count DESC
LIMIT 10;

-- Most active borrowers
SELECT 
    u.user_id, u.full_name, 
    COUNT(t.transaction_id) AS transaction_count
FROM USER u
JOIN TRANSACTION t ON u.user_id = t.user_id
WHERE t.borrow_date >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY)
GROUP BY u.user_id, u.full_name
ORDER BY transaction_count DESC
LIMIT 10;

-- Books with highest overdue rates
SELECT 
    b.book_id, b.title,
    COUNT(t.transaction_id) AS total_borrows,
    SUM(CASE WHEN t.transaction_status = 'overdue' OR 
             (t.return_date IS NOT NULL AND t.return_date > t.due_date)
             THEN 1 ELSE 0 END) AS overdue_count,
    ROUND(SUM(CASE WHEN t.transaction_status = 'overdue' OR 
               (t.return_date IS NOT NULL AND t.return_date > t.due_date)
               THEN 1 ELSE 0 END) / COUNT(t.transaction_id) * 100, 2) AS overdue_percentage
FROM BOOK b
JOIN TRANSACTION t ON b.book_id = t.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(t.transaction_id) >= 5
ORDER BY overdue_percentage DESC
LIMIT 10;

-- Monthly revenue from fines
SELECT 
    DATE_FORMAT(f.payment_date, '%Y-%m') AS month,
    SUM(f.amount) AS total_revenue,
    COUNT(f.fine_id) AS fine_count
FROM FINE f
WHERE f.payment_status = 'paid'
AND f.payment_date IS NOT NULL
AND f.payment_date >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(f.payment_date, '%Y-%m')
ORDER BY month DESC;

-- Genre popularity analysis
SELECT 
    g.genre_name,
    COUNT(t.transaction_id) AS borrow_count
FROM GENRE g
JOIN BOOK_GENRE bg ON g.genre_id = bg.genre_id
JOIN BOOK b ON bg.book_id = b.book_id
JOIN TRANSACTION t ON b.book_id = t.book_id
WHERE t.borrow_date >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 180 DAY)
GROUP BY g.genre_name
ORDER BY borrow_count DESC;

-- Books requiring more copies (high reservation-to-copy ratio)
SELECT 
    b.book_id, b.title, b.total_copies, b.available_copies,
    COUNT(DISTINCT r.reservation_id) AS active_reservations,
    COUNT(DISTINCT r.reservation_id) / b.total_copies AS reservation_to_copy_ratio
FROM BOOK b
JOIN RESERVATION r ON b.book_id = r.book_id
WHERE r.reservation_status = 'pending'
GROUP BY b.book_id, b.title, b.total_copies, b.available_copies
HAVING COUNT(DISTINCT r.reservation_id) / b.total_copies > 0.5
ORDER BY reservation_to_copy_ratio DESC;

/*markdown
## 10. Audit Logs & User Activity Tracking Queries
---
*/

-- Query recent system activity 
SELECT 
    al.log_id, u.full_name, al.action, 
    al.timestamp, al.ip_address, al.details
FROM AUDIT_LOG al
LEFT JOIN USER u ON al.user_id = u.user_id
ORDER BY al.timestamp DESC
LIMIT 50;

-- Filter logs by specific action type
SELECT 
    al.log_id, u.full_name, al.action, 
    al.timestamp, al.ip_address, al.details
FROM AUDIT_LOG al
LEFT JOIN USER u ON al.user_id = u.user_id
WHERE al.action LIKE '%book%'
ORDER BY al.timestamp DESC;

-- Filter logs by date range
SELECT 
    al.log_id, u.full_name, al.action, 
    al.timestamp, al.ip_address, al.details
FROM AUDIT_LOG al
LEFT JOIN USER u ON al.user_id = u.user_id
WHERE al.timestamp BETWEEN '2025-03-01 00:00:00' AND '2025-03-15 23:59:59'
ORDER BY al.timestamp;

-- Filter logs by specific user
SELECT 
    al.log_id, al.action, al.timestamp, 
    al.ip_address, al.details
FROM AUDIT_LOG al
WHERE al.user_id = 1
ORDER BY al.timestamp DESC;

-- Track suspicious login attempts
SELECT 
    al.ip_address, 
    COUNT(*) AS failed_attempts
FROM AUDIT_LOG al
WHERE al.action = 'login_attempt'
AND al.details LIKE '%failed%'
AND al.timestamp >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 HOUR)
GROUP BY al.ip_address
HAVING COUNT(*) >= 5;

-- Generate security report on user activity
SELECT 
    COALESCE(u.full_name, 'System/Unknown') AS user,
    al.action, 
    COUNT(*) AS action_count
FROM AUDIT_LOG al
LEFT JOIN USER u ON al.user_id = u.user_id
WHERE al.timestamp >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 30 DAY)
GROUP BY COALESCE(u.full_name, 'System/Unknown'), al.action
ORDER BY user, action_count DESC;