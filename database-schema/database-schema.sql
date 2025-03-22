-- Drop tables if they exist (in reverse order to avoid foreign key constraints)
DROP TABLE IF EXISTS NOTIFICATION;
DROP TABLE IF EXISTS AUDIT_LOG;
DROP TABLE IF EXISTS FINE;
DROP TABLE IF EXISTS REVIEW;
DROP TABLE IF EXISTS RESERVATION;
DROP TABLE IF EXISTS TRANSACTION;
DROP TABLE IF EXISTS BOOK_GENRE;
DROP TABLE IF EXISTS GENRE;
DROP TABLE IF EXISTS BOOK_AUTHOR;
DROP TABLE IF EXISTS AUTHOR;
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS USER_ROLE;
DROP TABLE IF EXISTS ROLE;
DROP TABLE IF EXISTS USER;
DROP PROCEDURE IF EXISTS BorrowBook;
DROP PROCEDURE IF EXISTS CalculateOverdueFines;
DROP PROCEDURE IF EXISTS ProcessBookReturn;
DROP PROCEDURE IF EXISTS FulfillReservation;
DROP PROCEDURE IF EXISTS UpdateReservationQueue;
DROP TRIGGER IF EXISTS after_user_update;
DROP TRIGGER IF EXISTS after_reservation_update;

-- Create USER table
CREATE TABLE USER (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    last_login DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create ROLE table
CREATE TABLE ROLE (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create USER_ROLE table (junction table for many-to-many relationship)
CREATE TABLE USER_ROLE (
    user_role_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    assigned_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES ROLE(role_id) ON DELETE CASCADE,
    UNIQUE KEY user_role_unique (user_id, role_id)
);

-- Create BOOK table
CREATE TABLE BOOK (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    language VARCHAR(50) DEFAULT 'English',
    publication_year INT,
    publisher VARCHAR(100),
    num_pages INT,
    description TEXT,
    cover_image_url VARCHAR(255),
    available_copies INT NOT NULL DEFAULT 0,
    total_copies INT NOT NULL DEFAULT 0,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_title (title),
    INDEX idx_isbn (isbn),
    INDEX idx_publication_year (publication_year)
);

-- Create AUTHOR table
CREATE TABLE AUTHOR (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    biography TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_author_name (author_name)
);

-- Create BOOK_AUTHOR junction table
CREATE TABLE BOOK_AUTHOR (
    book_author_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id) ON DELETE CASCADE,
    UNIQUE KEY book_author_unique (book_id, author_id)
);

-- Create GENRE table
CREATE TABLE GENRE (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create BOOK_GENRE junction table
CREATE TABLE BOOK_GENRE (
    book_genre_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES GENRE(genre_id) ON DELETE CASCADE,
    UNIQUE KEY book_genre_unique (book_id, genre_id)
);

-- Create TRANSACTION table
CREATE TABLE TRANSACTION (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME NOT NULL,
    return_date DATETIME,
    transaction_status ENUM('borrowed', 'returned', 'overdue', 'lost') DEFAULT 'borrowed',
    fine_amount DECIMAL(10, 2) DEFAULT 0.00,
    fine_status ENUM('none', 'pending', 'paid', 'waived') DEFAULT 'none',
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id) ON DELETE CASCADE,
    INDEX idx_transaction_status (transaction_status),
    INDEX idx_fine_status (fine_status)
);

-- Create RESERVATION table
CREATE TABLE RESERVATION (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    expiry_date DATETIME NOT NULL,
    reservation_status ENUM('pending', 'fulfilled', 'expired', 'cancelled') DEFAULT 'pending',
    queue_position INT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id) ON DELETE CASCADE,
    INDEX idx_reservation_status (reservation_status)
);

-- Create REVIEW table
CREATE TABLE REVIEW (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    rating INT NOT NULL CHECK(rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    review_status ENUM('pending', 'approved', 'rejected') DEFAULT 'approved',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES BOOK(book_id) ON DELETE CASCADE,
    UNIQUE KEY user_book_review_unique (user_id, book_id)
);

-- Create FINE table
CREATE TABLE FINE (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    fine_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_date DATETIME,
    payment_method ENUM('credit_card', 'paypal', 'cash', 'waived') DEFAULT NULL,
    payment_status ENUM('pending', 'paid', 'waived') DEFAULT 'pending',
    receipt_number VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES TRANSACTION(transaction_id) ON DELETE CASCADE,
    INDEX idx_payment_status (payment_status)
);

-- Create AUDIT_LOG table
CREATE TABLE AUDIT_LOG (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100) NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    details TEXT,
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE SET NULL,
    INDEX idx_timestamp (timestamp),
    INDEX idx_action (action)
);

-- Create NOTIFICATION table
CREATE TABLE NOTIFICATION (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    notification_type ENUM('reservation', 'due_date', 'overdue', 'fine', 'system') NOT NULL,
    message TEXT NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    read_date DATETIME,
    status ENUM('unread', 'read') DEFAULT 'unread',
    FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_notification_type (notification_type)
);

-- Insert initial role data
INSERT INTO ROLE (role_name, description) VALUES
('admin', 'Administrator with full system access'),
('librarian', 'Staff member who manages books and transactions'),
('member', 'Regular library member/borrower');

-- Create some stored procedures for common operations

-- Calculate fines for overdue books
DELIMITER //
CREATE PROCEDURE CalculateOverdueFines()
BEGIN
    -- Find all overdue transactions without return date
    UPDATE TRANSACTION
    SET 
        transaction_status = 'overdue',
        fine_amount = DATEDIFF(CURRENT_TIMESTAMP, due_date) * 0.50 -- $0.50 per day
    WHERE 
        return_date IS NULL 
        AND due_date < CURRENT_TIMESTAMP
        AND transaction_status != 'overdue';
    
    -- Insert new fine records for newly overdue transactions
    INSERT INTO FINE (transaction_id, amount, payment_status)
    SELECT 
        transaction_id, fine_amount, 'pending'
    FROM 
        TRANSACTION
    WHERE 
        transaction_status = 'overdue'
        AND fine_status = 'none'
        AND fine_amount > 0;
    
    -- Update the fine status in transactions
    UPDATE TRANSACTION
    SET fine_status = 'pending'
    WHERE 
        transaction_status = 'overdue'
        AND fine_status = 'none'
        AND fine_amount > 0;
END //
DELIMITER ;


-- Process book return and calculate fines if needed
DELIMITER //
CREATE PROCEDURE ProcessBookReturn(
    IN p_transaction_id INT
)
BEGIN
    DECLARE v_book_id INT;
    DECLARE v_due_date DATETIME;
    DECLARE v_days_overdue INT;
    DECLARE v_fine_amount DECIMAL(10, 2);
    
    -- Get transaction details
    SELECT book_id, due_date INTO v_book_id, v_due_date
    FROM TRANSACTION
    WHERE transaction_id = p_transaction_id;
    
    -- Calculate days overdue
    SET v_days_overdue = DATEDIFF(CURRENT_TIMESTAMP, v_due_date);
    
    -- Update transaction
    IF v_days_overdue > 0 THEN
        -- Calculate fine
        SET v_fine_amount = v_days_overdue * 0.50; -- $0.50 per day
        
        UPDATE TRANSACTION
        SET 
            return_date = CURRENT_TIMESTAMP,
            transaction_status = 'returned',
            fine_amount = v_fine_amount,
            fine_status = 'pending'
        WHERE transaction_id = p_transaction_id;
        
        -- Create fine record
        INSERT INTO FINE (transaction_id, amount, payment_status)
        VALUES (p_transaction_id, v_fine_amount, 'pending');
    ELSE
        UPDATE TRANSACTION
        SET 
            return_date = CURRENT_TIMESTAMP,
            transaction_status = 'returned'
        WHERE transaction_id = p_transaction_id;
    END IF;
    
    -- Update book available copies
    UPDATE BOOK
    SET available_copies = available_copies + 1
    WHERE book_id = v_book_id;
    
    -- Check if there are pending reservations for this book
    -- and notify the first user in the queue
    INSERT INTO NOTIFICATION (user_id, notification_type, message)
    SELECT 
        r.user_id,
        'reservation',
        CONCAT('The book you reserved (', b.title, ') is now available. Please collect within 48 hours.')
    FROM 
        RESERVATION r
        JOIN BOOK b ON r.book_id = b.book_id
    WHERE 
        r.book_id = v_book_id
        AND r.reservation_status = 'pending'
        AND r.queue_position = 1;
END //
DELIMITER ;


-- Create book borrowing procedure
DELIMITER //
CREATE PROCEDURE BorrowBook(
    IN p_user_id INT,
    IN p_book_id INT,
    IN p_days INT -- Borrowing period in days
)
BEGIN
    DECLARE v_available_copies INT;
    DECLARE v_user_active BOOLEAN;
    DECLARE v_has_overdue BOOLEAN;
    DECLARE v_loan_limit INT;
    DECLARE v_current_loans INT;
    
    -- Check if user is active
    SELECT user_status = 'active' INTO v_user_active
    FROM USER
    WHERE user_id = p_user_id;
    
    -- Check if user has overdue books
    SELECT COUNT(*) > 0 INTO v_has_overdue
    FROM TRANSACTION
    WHERE user_id = p_user_id AND transaction_status = 'overdue';
    
    -- Count user's current loans
    SELECT COUNT(*) INTO v_current_loans
    FROM TRANSACTION
    WHERE user_id = p_user_id AND transaction_status = 'borrowed';
    
    -- Set loan limit (5 books per user)
    SET v_loan_limit = 5;
    
    -- Check book availability
    SELECT available_copies INTO v_available_copies
    FROM BOOK
    WHERE book_id = p_book_id;
    
    -- Process the loan if all conditions are met
    IF v_user_active AND NOT v_has_overdue AND v_current_loans < v_loan_limit AND v_available_copies > 0 THEN
        -- Insert transaction record
        INSERT INTO TRANSACTION (user_id, book_id, due_date)
        VALUES (p_user_id, p_book_id, DATE_ADD(CURRENT_TIMESTAMP, INTERVAL p_days DAY));
        
        -- Update book availability
        UPDATE BOOK
        SET available_copies = available_copies - 1
        WHERE book_id = p_book_id;
        
        -- Create audit log
        INSERT INTO AUDIT_LOG (user_id, action, details)
        VALUES (p_user_id, 'borrow_book', CONCAT('Borrowed book ID: ', p_book_id));
        
        -- Create due date notification
        INSERT INTO NOTIFICATION (user_id, notification_type, message)
        SELECT 
            p_user_id,
            'due_date',
            CONCAT('Your borrowed book "', title, '" is due on ', DATE_FORMAT(DATE_ADD(CURRENT_TIMESTAMP, INTERVAL p_days DAY), '%Y-%m-%d'), '.')
        FROM BOOK
        WHERE book_id = p_book_id;
        
        SELECT 'Book borrowed successfully' AS message;
    ELSE
        IF NOT v_user_active THEN
            SELECT 'User account is not active' AS error;
        ELSEIF v_has_overdue THEN
            SELECT 'User has overdue books' AS error;
        ELSEIF v_current_loans >= v_loan_limit THEN
            SELECT 'User has reached borrowing limit' AS error;
        ELSE
            SELECT 'Book is not available' AS error;
        END IF;
    END IF;
END

DELIMITER //
CREATE PROCEDURE FulfillReservation(IN p_reservation_id INT)
BEGIN
    DECLARE v_book_id INT;
    
    -- Get the book_id associated with this reservation
    SELECT book_id INTO v_book_id 
    FROM RESERVATION 
    WHERE reservation_id = p_reservation_id;
    
    -- Update the reservation status
    UPDATE RESERVATION
    SET reservation_status = 'fulfilled'
    WHERE reservation_id = p_reservation_id;
    
    -- Call procedure to update queue positions (separate operation)
    CALL UpdateReservationQueue(v_book_id);
END //
DELIMITER ;


-- Step 2: Create a procedure for updating queue positions
DELIMITER //
CREATE PROCEDURE UpdateReservationQueue(IN p_book_id INT)
BEGIN
    -- Update queue positions for remaining pending reservations
    UPDATE RESERVATION
    SET queue_position = queue_position - 1
    WHERE book_id = p_book_id
    AND reservation_status = 'pending'
    AND queue_position > 1;
END //
DELIMITER ;


-- Trigger to log user activities
DELIMITER //
CREATE TRIGGER after_user_update
AFTER UPDATE ON USER
FOR EACH ROW
BEGIN
    IF NEW.user_status != OLD.user_status THEN
        INSERT INTO AUDIT_LOG (user_id, action, details)
        VALUES (NEW.user_id, 'status_change', CONCAT('User status changed from ', OLD.user_status, ' to ', NEW.user_status));
    END IF;
END


-- Trigger to manage reservation queue when a reservation is fulfilled or cancelled
DELIMITER //
CREATE TRIGGER after_reservation_update
AFTER UPDATE ON RESERVATION
FOR EACH ROW
BEGIN
    IF NEW.reservation_status IN ('fulfilled', 'cancelled', 'expired') AND OLD.reservation_status = 'pending' THEN
        -- Update queue positions for remaining pending reservations
        UPDATE RESERVATION
        SET queue_position = queue_position - 1
        WHERE book_id = NEW.book_id
          AND reservation_status = 'pending'
          AND queue_position > OLD.queue_position;
    END IF;
END //
DELIMITER ;

