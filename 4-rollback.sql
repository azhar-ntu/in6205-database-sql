/*
 * OmniLibrary Rollback Script
 * This script undoes all INSERT operations in the original query file
 * Execute statements in this order to properly maintain referential integrity
 */

-- Begin transaction
START TRANSACTION;

-- =============================================================
-- 10. Undo Audit Logs Insertions
-- =============================================================
DELETE FROM AUDIT_LOG 
WHERE (user_id = 2 AND action = 'book_add' AND details = 'Added new book: "The Silmarillion"');

DELETE FROM AUDIT_LOG 
WHERE (user_id = 5 AND action = 'login_attempt' AND details = 'Successful login');

-- =============================================================
-- 8. Undo Review Insertions
-- =============================================================
DELETE FROM REVIEW
WHERE user_id = 6 AND book_id = 7 AND review_text = 'A fantastic classic that holds up well. The prose is sparse but powerful.';

-- =============================================================
-- 7. Undo Notification & Reservation Insertions
-- =============================================================
-- First find and delete related notifications
DELETE FROM NOTIFICATION
WHERE notification_type = 'reservation'
AND message LIKE 'The book you reserved "%' 
AND user_id IN (SELECT user_id FROM RESERVATION WHERE reservation_id = 3);

-- Then delete the reservation
DELETE FROM RESERVATION 
WHERE user_id = 7 AND book_id = 10;

-- =============================================================
-- 6. Undo Fine Insertions
-- =============================================================
DELETE FROM FINE
WHERE transaction_id = 8 AND payment_status = 'pending';

-- =============================================================
-- 4. Undo Borrowing Transaction Insertions
-- =============================================================
-- First restore the book's available_copies that were decremented
UPDATE BOOK
SET available_copies = available_copies + 1
WHERE book_id = 3;

-- Then delete the transaction
DELETE FROM TRANSACTION
WHERE user_id = 5 AND book_id = 3;

-- =============================================================
-- 1. Undo User Registration
-- =============================================================
DELETE FROM USER_ROLE
WHERE user_id = (SELECT user_id FROM USER WHERE email = 'new.user@example.com');

DELETE FROM USER
WHERE email = 'new.user@example.com';

-- Commit the transaction if everything is successful
COMMIT;

-- If you want to be cautious, you could use this instead of COMMIT:
-- ROLLBACK;
-- This would abort all changes if you want to review the script's effects first