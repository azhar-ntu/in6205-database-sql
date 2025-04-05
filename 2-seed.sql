-- Seed data for Library Management System

-- Insert users (passwords shown here would be hashed in a real system)
INSERT INTO USER (email, password, full_name, phone_number, registration_date, user_status, last_login) VALUES 
('admin@library.com', '$2a$10$XtRg1PmP6G1Nzw.xpvL4f.oY9z8jB1F4O0hvs1jGj3Ydh1Djy3i8e', 'Admin User', '123-456-7890', '2023-01-01 10:00:00', 'active', '2025-03-21 09:15:23'),
('librarian1@library.com', '$2a$10$yp89KSE8TKr8n/jB1Uvjg.QcIKlMHjlh3h4SQY6E0Gn/zBJVG/5pS', 'Sarah Johnson', '234-567-8901', '2023-01-15 11:30:00', 'active', '2025-03-20 14:22:45'),
('librarian2@library.com', '$2a$10$Kl2P7MzK.iF9abrNQuYy9OPsRqN0FEFnH3vzi/58CQ9Pjv9y6FV1y', 'Michael Chen', '345-678-9012', '2023-02-05 09:45:00', 'active', '2025-03-21 11:05:33'),
('john.doe@example.com', '$2a$10$abc13tzPyxEF4XvSvB9RmeB1XK2tU3QnH0hIggvGb4jRzM25EFrSq', 'John Doe', '456-789-0123', '2023-03-10 14:20:00', 'active', '2025-03-19 16:40:12'),
('jane.smith@example.com', '$2a$10$def45uvwGHI6jkL7mnoPQRST8UvWXyZ9Nbcde1fghI2JklmNOP3qr', 'Jane Smith', '567-890-1234', '2023-03-15 15:10:00', 'active', '2025-03-20 10:33:51'),
('robert.johnson@example.com', '$2a$10$ghi78xyzABCD2efGHIjkLMNO3pQrsTUvWXyZ9abCDe1fGHI2jkLMno', 'Robert Johnson', '678-901-2345', '2023-04-05 16:30:00', 'active', '2025-03-18 09:27:44'),
('lisa.wong@example.com', '$2a$10$jkl01abcDEF3ghiJKLmno4PqRsTUvWXyZ9abCDe1fGHI2jkLMnoPQ', 'Lisa Wong', '789-012-3456', '2023-04-20 13:25:00', 'active', '2025-03-21 13:17:25'),
('david.miller@example.com', '$2a$10$mno23defGHI4jklMNO5pqR6sTUvWXyZ9abCDe1fGHI2jkLMnoPQrs', 'David Miller', '890-123-4567', '2023-05-12 10:15:00', 'active', '2025-03-19 11:42:30'),
('olivia.parker@example.com', '$2a$10$pqr56ghiJKL7mnoP8QrSt9UvWXyZ9abCDe1fGHI2jkLMnoPQrsTU', 'Olivia Parker', '901-234-5678', '2023-05-25 09:40:00', 'inactive', '2025-02-15 14:55:18'),
('james.wilson@example.com', '$2a$10$tuv89jklMNO0pqrSTU1vwX2yZ9abCDe1fGHI2jkLMnoPQrsTUvWX', 'James Wilson', '012-345-6789', '2023-06-08 14:35:00', 'suspended', '2025-01-30 08:22:47');

-- Assign roles to users
INSERT INTO USER_ROLE (user_id, role_id, assigned_date) VALUES
(1, 1, '2023-01-01 10:30:00'), -- Admin role for admin user
(2, 2, '2023-01-15 12:00:00'), -- Librarian role for Sarah
(3, 2, '2023-02-05 10:15:00'), -- Librarian role for Michael
(4, 3, '2023-03-10 14:45:00'), -- Member role for John
(5, 3, '2023-03-15 15:40:00'), -- Member role for Jane
(6, 3, '2023-04-05 17:00:00'), -- Member role for Robert
(7, 3, '2023-04-20 13:55:00'), -- Member role for Lisa
(8, 3, '2023-05-12 10:45:00'), -- Member role for David
(9, 3, '2023-05-25 10:10:00'), -- Member role for Olivia
(10, 3, '2023-06-08 15:05:00'); -- Member role for James

-- Insert authors
INSERT INTO AUTHOR (author_name, biography) VALUES
('J.K. Rowling', 'Joanne Rowling CH, OBE, HonFRSE, FRCPE, FRSL, better known by her pen name J. K. Rowling, is a British author and philanthropist. She is best known for writing the Harry Potter fantasy series.'),
('George Orwell', 'Eric Arthur Blair, known by his pen name George Orwell, was an English novelist, essayist, journalist and critic. His work is characterized by lucid prose, biting social criticism, opposition to totalitarianism, and outspoken support of democratic socialism.'),
('Jane Austen', 'Jane Austen was an English novelist known primarily for her six major novels, which interpret, critique and comment upon the British landed gentry at the end of the 18th century.'),
('F. Scott Fitzgerald', 'Francis Scott Key Fitzgerald was an American novelist, essayist, and short story writer. He is best known for his novels depicting the flamboyance and excess of the Jazz Age.'),
('Harper Lee', 'Nelle Harper Lee was an American novelist best known for her 1960 novel To Kill a Mockingbird. It won the 1961 Pulitzer Prize and has become a classic of modern American literature.'),
('Agatha Christie', 'Dame Agatha Mary Clarissa Christie, Lady Mallowan, DBE was an English writer known for her 66 detective novels and 14 short story collections, particularly those revolving around fictional detectives Hercule Poirot and Miss Marple.'),
('Ernest Hemingway', 'Ernest Miller Hemingway was an American novelist, short-story writer, journalist, and sportsman. His economical and understated style—which he termed the iceberg theory—had a strong influence on 20th-century fiction.'),
('Toni Morrison', 'Toni Morrison was an American novelist, essayist, editor, teacher, and professor emeritus at Princeton University. Her first novel, The Bluest Eye, was published in 1970.'),
('Stephen King', 'Stephen Edwin King is an American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels. His books have sold more than 350 million copies.'),
('J.R.R. Tolkien', 'John Ronald Reuel Tolkien CBE FRSL was an English writer, poet, philologist, and academic. He was the author of the classic high fantasy works The Hobbit, The Lord of the Rings, and The Silmarillion.');

-- Insert genres
INSERT INTO GENRE (genre_name, description) VALUES
('Fiction', 'Literature created from the imagination, not presented as fact, though it may be based on a true story or situation.'),
('Non-Fiction', 'Prose writing that is based on facts, real events, and real people, such as biography or history.'),
('Mystery', 'Fiction dealing with the solution of a crime or the unraveling of secrets.'),
('Science Fiction', 'Fiction based on imagined future scientific or technological advances and major social or environmental changes.'),
('Fantasy', 'Fiction featuring magical and supernatural elements that do not exist in the real world.'),
('Romance', 'Fiction that focuses on the romantic relationship between characters as the main plot.'),
('Thriller', 'Fiction characterized by fast pacing, frequent action, and resourceful heroes who must thwart the plans of more-powerful and better-equipped villains.'),
('Horror', 'Fiction in which the aim is to create a sense of fear, dread, repulsion, or terror in the audience.'),
('Historical Fiction', 'Fiction that takes place in the past and usually includes real historical figures or events.'),
('Biography', 'A detailed description or account of someone\'s life written by someone else.'),
('Self-Help', 'Books written with the intention of instructing readers on solving personal problems.'),
('Classics', 'Books that are accepted as being notable for their quality and lasting cultural significance.');

-- Insert books
INSERT INTO BOOK (isbn, title, language, publication_year, publisher, num_pages, description, cover_image_url, available_copies, total_copies) VALUES
('9780747532743', 'Harry Potter and the Philosopher\'s Stone', 'English', 1997, 'Bloomsbury', 223, 'The first novel in the Harry Potter series follows Harry Potter, a young wizard who discovers his magical heritage on his eleventh birthday, when he receives a letter of acceptance to Hogwarts School of Witchcraft and Wizardry.', 'https://covers.openlibrary.org/b/id/8245123-L.jpg', 3, 5),
('9780451524935', '1984', 'English', 1949, 'Signet Classic', 328, 'The novel examines the role of truth and facts within politics and the ways in which they are manipulated. The story takes place in an imagined future, the year 1984, when much of the world has fallen victim to perpetual war, omnipresent government surveillance, historical negationism, and propaganda.', 'https://covers.openlibrary.org/b/id/9127115-L.jpg', 2, 3),
('9780141439518', 'Pride and Prejudice', 'English', 1813, 'Penguin Classics', 432, 'The novel follows the character development of Elizabeth Bennet, the dynamic protagonist of the book who learns about the repercussions of hasty judgments and comes to appreciate the difference between superficial goodness and actual goodness.', 'https://covers.openlibrary.org/b/id/8409593-L.jpg', 1, 2),
('9780743273565', 'The Great Gatsby', 'English', 1925, 'Scribner', 180, 'The novel chronicles an era that Fitzgerald himself dubbed the "Jazz Age". Following the shock and chaos of World War I, American society enjoyed unprecedented levels of prosperity during the "roaring" 1920s as the economy soared.', 'https://covers.openlibrary.org/b/id/8231991-L.jpg', 2, 3),
('9780061120084', 'To Kill a Mockingbird', 'English', 1960, 'Harper Perennial Modern Classics', 336, 'The novel is renowned for its warmth and humor, despite dealing with serious issues of rape and racial inequality. The narrator\'s father, Atticus Finch, has served as a moral hero for many readers and as a model of integrity for lawyers.', 'https://covers.openlibrary.org/b/id/8314135-L.jpg', 0, 2),
('9780062073483', 'Murder on the Orient Express', 'English', 1934, 'Harper Collins', 274, 'The story revolves around the murder of an American businessman aboard the Orient Express train, and the detective Hercule Poirot who investigates it.', 'https://covers.openlibrary.org/b/id/12457534-L.jpg', 3, 3),
('9780684801223', 'The Old Man and the Sea', 'English', 1952, 'Scribner', 127, 'The novel centers upon Santiago, an aging fisherman who struggles with a giant marlin far out in the Gulf Stream off the coast of Cuba.', 'https://covers.openlibrary.org/b/id/8232406-L.jpg', 1, 2),
('9781400033416', 'Beloved', 'English', 1987, 'Vintage', 324, 'The novel tells the story of a family of formerly enslaved people whose Cincinnati home is haunted by a malevolent spirit.', 'https://covers.openlibrary.org/b/id/8024808-L.jpg', 1, 1),
('9781501142970', 'The Shining', 'English', 1977, 'Scribner', 447, 'The novel tells the story of Jack Torrance, his wife Wendy, and their five-year-old son Danny, who move into the Overlook Hotel in the Colorado Rockies. Jack has been hired as a caretaker for the hotel during its off-season winter closure.', 'https://covers.openlibrary.org/b/id/8713407-L.jpg', 2, 2),
('9780544003415', 'The Hobbit', 'English', 1937, 'Houghton Mifflin Harcourt', 300, 'The book follows the quest of home-loving Bilbo Baggins, the titular hobbit, to win a share of the treasure guarded by the dragon, Smaug. Bilbo\'s journey takes him from light-hearted, rural surroundings into more sinister territory.', 'https://covers.openlibrary.org/b/id/8406786-L.jpg', 0, 3);

-- Link books with authors
INSERT INTO BOOK_AUTHOR (book_id, author_id) VALUES
(1, 1), -- Harry Potter and J.K. Rowling
(2, 2), -- 1984 and George Orwell
(3, 3), -- Pride and Prejudice and Jane Austen
(4, 4), -- The Great Gatsby and F. Scott Fitzgerald
(5, 5), -- To Kill a Mockingbird and Harper Lee
(6, 6), -- Murder on the Orient Express and Agatha Christie
(7, 7), -- The Old Man and the Sea and Ernest Hemingway
(8, 8), -- Beloved and Toni Morrison
(9, 9), -- The Shining and Stephen King
(10, 10); -- The Hobbit and J.R.R. Tolkien

-- Link books with genres
INSERT INTO BOOK_GENRE (book_id, genre_id) VALUES
(1, 5), -- Harry Potter and Fantasy
(1, 1), -- Harry Potter and Fiction
(2, 1), -- 1984 and Fiction
(2, 4), -- 1984 and Science Fiction
(3, 1), -- Pride and Prejudice and Fiction
(3, 6), -- Pride and Prejudice and Romance
(3, 12), -- Pride and Prejudice and Classics
(4, 1), -- The Great Gatsby and Fiction
(4, 12), -- The Great Gatsby and Classics
(5, 1), -- To Kill a Mockingbird and Fiction
(5, 12), -- To Kill a Mockingbird and Classics
(6, 1), -- Murder on the Orient Express and Fiction
(6, 3), -- Murder on the Orient Express and Mystery
(7, 1), -- The Old Man and the Sea and Fiction
(7, 12), -- The Old Man and the Sea and Classics
(8, 1), -- Beloved and Fiction
(8, 9), -- Beloved and Historical Fiction
(9, 1), -- The Shining and Fiction
(9, 8), -- The Shining and Horror
(10, 1), -- The Hobbit and Fiction
(10, 5); -- The Hobbit and Fantasy

-- Create transactions (borrowed books)
INSERT INTO TRANSACTION (user_id, book_id, borrow_date, due_date, return_date, transaction_status, notes) VALUES
-- Completed transactions
(4, 1, '2025-01-10 10:30:00', '2025-01-24 10:30:00', '2025-01-22 14:15:00', 'returned', 'Returned in good condition.'),
(5, 2, '2025-01-15 11:45:00', '2025-01-29 11:45:00', '2025-01-28 16:20:00', 'returned', 'Slight damage on page 15, noted.'),
(6, 3, '2025-01-20 14:00:00', '2025-02-03 14:00:00', '2025-02-01 10:30:00', 'returned', 'Returned on time.'),
(7, 4, '2025-01-25 15:30:00', '2025-02-08 15:30:00', '2025-02-10 09:45:00', 'returned', 'Returned 2 days late, fine applied.'),
(4, 1, '2025-01-10 10:30:00', '2025-01-24 10:30:00', '2025-01-22 14:15:00', 'returned', 'Returned in good condition.'),
-- Active transactions
(6, 6, '2025-03-31 10:00:00', '2025-04-14 10:00:00', NULL, 'borrowed', 'First-time borrower of Agatha Christie.'),
(4, 6, '2025-04-01 10:00:00', '2025-04-15 10:00:00', NULL, 'borrowed', 'First-time borrower of Agatha Christie.'),
(5, 7, '2025-04-02 14:20:00', '2025-04-16 14:20:00', NULL, 'borrowed', 'Reserved for book club.'),
(6, 9, '2025-04-03 11:30:00', '2025-04-17 11:30:00', NULL, 'borrowed', NULL),
-- Overdue by multiple days
(9, 3, '2025-03-15 10:30:00', '2025-03-29 10:30:00', NULL, 'overdue', 'Overdue by 7 days. Third reminder sent on 2025-04-05.'),
(10, 4, '2025-03-16 14:20:00', '2025-03-30 14:20:00', NULL, 'overdue', 'Overdue by 6 days. Second reminder sent on 2025-04-04.'),
(4, 5, '2025-03-17 11:15:00', '2025-03-31 11:15:00', NULL, 'overdue', 'Overdue by 5 days. Second reminder sent on 2025-04-03.'),
-- Recently overdue (past 1-2 days)
(6, 7, '2025-03-19 09:30:00', '2025-04-02 09:30:00', NULL, 'overdue', 'Overdue by 3 days. First reminder sent on 2025-04-04.'),
(7, 8, '2025-03-20 13:15:00', '2025-04-03 13:15:00', NULL, 'overdue', 'Overdue by 2 days. First reminder sent today.'),
(8, 9, '2025-03-21 15:45:00', '2025-04-04 15:45:00', NULL, 'overdue', 'Overdue by 1 day. No reminder sent yet.'),
-- Long overdue
(9, 10, '2025-02-19 11:30:00', '2025-03-05 11:30:00', NULL, 'overdue', 'Overdue by 31 days. Final notice sent. Will be marked as lost on 2025-04-10.'),
(10, 1, '2025-02-25 14:00:00', '2025-03-11 14:00:00', NULL, 'overdue', 'Overdue by 25 days. Phone call made on 2025-04-02. User promised to return.'),
(4, 2, '2025-03-01 10:00:00', '2025-03-15 10:00:00', NULL, 'overdue', 'Overdue by 21 days. User contacted via email on 2025-04-01.'),
-- Lost book
(8, 5, '2025-03-15 10:30:00', '2025-03-29 10:30:00', NULL, 'lost', 'User reported book lost on 2025-04-01, charged replacement fee.'),
(8, 5, '2025-03-10 10:30:00', '2025-03-24 10:30:00', NULL, 'lost', 'User reported book lost on 2025-03-30, charged replacement fee.');

-- Create fines for overdue and lost books
INSERT INTO FINE (transaction_id, amount, fine_date, payment_date, payment_method, payment_status, receipt_number) VALUES
(4, 1.00, '2025-04-01 09:45:00', '2025-04-01 09:50:00', 'credit_card', 'paid', 'FIN00001'),
(8, 5.50, '2025-04-03 10:00:00', NULL, NULL, 'pending', NULL),
(9, 8.00, '2025-03-31 09:00:00', '2025-04-04 14:30:00', 'paypal', 'paid', 'FIN00002'),
(10, 25.99, '2025-03-29 11:30:00', '2025-03-29 11:45:00', 'credit_card', 'paid', 'FIN00003'),
(11, 3.00, '2025-04-02 10:00:00', '2025-04-03 12:00:00', 'credit_card', 'paid', 'FIN00004'),
(12, 7.50, '2025-04-04 09:30:00', NULL, NULL, 'pending', NULL),
(13, 15.00, '2025-03-30 14:00:00', '2025-03-31 10:00:00', 'paypal', 'paid', 'FIN00005');

-- Create reservations
INSERT INTO RESERVATION (user_id, book_id, reservation_date, expiry_date, reservation_status, queue_position) VALUES
(4, 5, '2025-03-15 09:30:00', '2025-03-22 09:30:00', 'pending', 1),
(6, 5, '2025-03-16 14:15:00', '2025-03-23 14:15:00', 'pending', 2),
(5, 10, '2025-03-10 11:00:00', '2025-03-17 11:00:00', 'pending', 1),
(7, 10, '2025-03-12 15:45:00', '2025-03-19 15:45:00', 'pending', 2),
(8, 10, '2025-03-14 10:20:00', '2025-03-21 10:20:00', 'pending', 3),
(4, 8, '2025-02-25 13:10:00', '2025-03-04 13:10:00', 'fulfilled', 1),
(5, 3, '2025-02-10 09:45:00', '2025-02-17 09:45:00', 'expired', 1),
(6, 4, '2025-02-05 16:30:00', '2025-02-12 16:30:00', 'cancelled', 1),
(5, 8, '2025-03-20 09:00:00', '2025-03-27 09:00:00', 'pending', 1),
(6, 9, '2025-03-21 10:00:00', '2025-03-28 10:00:00', 'pending', 2);

-- Create reviews
INSERT INTO REVIEW (user_id, book_id, rating, review_text, review_date, review_status) VALUES
(7, 4, 3, 'Beautifully written but found the characters hard to relate to. The prose is exceptional though.', '2025-02-11 09:20:00', 'approved'),
(4, 6, 4, 'Christie at her best! The twist at the end was unexpected.', '2025-03-07 16:10:00', 'approved'),
(5, 7, 5, 'Hemingway\'s simple yet profound style shines in this novella. A true masterpiece.', '2025-03-10 11:30:00', 'approved'),
(8, 5, 5, 'One of the most important American novels ever written. Scout\'s narrative voice is perfect.', '2025-01-15 13:40:00', 'approved'),
(6, 9, 4, 'Terrifying and suspenseful. King knows how to create psychological horror.', '2025-03-15 17:25:00', 'pending'),
(7, 2, 2, 'Found it too depressing and slow-paced. Not my cup of tea.', '2025-02-25 12:35:00', 'rejected'),
(8, 1, 5, 'Reading this as an adult was just as magical as when I was a kid. Timeless appeal!', '2025-03-05 10:50:00', 'approved'),
(5, 4, 5, 'A masterpiece of the Jazz Age. Fitzgerald\'s prose is stunning.', '2025-03-20 15:00:00', 'approved'),
(6, 6, 4, 'A gripping mystery with an unforgettable twist.', '2025-03-21 10:30:00', 'approved'),
(7, 7, 3, 'A bit slow-paced, but the themes are profound.', '2025-03-22 11:00:00', 'pending');

-- Create audit logs
INSERT INTO AUDIT_LOG (user_id, action, timestamp, ip_address, details) VALUES
(1, 'user_create', '2025-01-15 09:30:15', '192.168.1.100', 'Created new librarian account for Sarah Johnson'),
(1, 'book_add', '2025-01-20 14:23:45', '192.168.1.100', 'Added 5 new books to the system'),
(2, 'transaction_create', '2025-01-25 11:15:30', '192.168.1.101', 'Processed book loan for user John Doe'),
(2, 'transaction_return', '2025-02-10 15:45:20', '192.168.1.101', 'Processed return for transaction ID 4'),
(3, 'fine_collect', '2025-02-15 10:10:05', '192.168.1.102', 'Collected fine payment for lost book'),
(1, 'user_suspend', '2025-02-28 16:30:40', '192.168.1.100', 'Suspended user account for James Wilson due to multiple overdue books'),
(3, 'book_update', '2025-03-05 13:20:15', '192.168.1.102', 'Updated book information for "The Hobbit"'),
(2, 'reservation_process', '2025-03-10 09:45:50', '192.168.1.101', 'Processed book reservation for Jane Smith'),
(NULL, 'system_backup', '2025-03-15 03:00:00', NULL, 'Automated system backup completed'),
(1, 'report_generate', '2025-03-20 14:15:30', '192.168.1.100', 'Generated monthly circulation report'),
(2, 'transaction_create', '2025-03-20 14:00:00', '192.168.1.101', 'Processed book loan for user Jane Smith'),
(3, 'fine_collect', '2025-03-21 10:30:00', '192.168.1.102', 'Collected fine payment for overdue book'),
(1, 'report_generate', '2025-03-22 09:00:00', '192.168.1.100', 'Generated weekly overdue report');

-- Create notifications
INSERT INTO NOTIFICATION (user_id, notification_type, message, created_date, read_date, status) VALUES
(4, 'due_date', 'Your book "Murder on the Orient Express" is due in 3 days.', '2025-04-02 08:00:00', '2025-04-02 10:15:30', 'read'),
(5, 'due_date', 'Your book "The Old Man and the Sea" is due in 3 days.', '2025-04-03 08:00:00', NULL, 'unread'),
(6, 'due_date', 'Your book "The Shining" is due in 3 days.', '2025-04-04 08:00:00', NULL, 'unread'),
(8, 'overdue', 'Your book "Harry Potter and the Philosopher\'s Stone" is overdue. Please return it as soon as possible.', '2025-04-01 08:00:00', '2025-04-01 11:23:45', 'read'),
(7, 'overdue', 'Your book "1984" is now 15 days overdue. Please return it as soon as possible.', '2025-04-05 08:00:00', NULL, 'unread'),
(8, 'fine', 'A fine of $5.50 has been added to your account for overdue book.', '2025-04-02 10:00:00', NULL, 'unread'),
(7, 'fine', 'A fine of $8.00 has been added to your account for overdue book.', '2025-03-31 09:00:00', '2025-03-31 15:40:10', 'read'),
(4, 'reservation', 'The book you reserved "Beloved" is now available. Please collect within 48 hours.', '2025-03-30 13:15:00', '2025-03-30 14:30:20', 'read'),
(5, 'reservation', 'The book you reserved "The Hobbit" is now available. Please collect within 48 hours.', '2025-04-03 11:05:00', NULL, 'unread'),
(4, 'system', 'Welcome to the library management system! Check out our new arrivals section.', '2025-03-29 09:00:00', '2025-03-29 09:05:15', 'read'),
(5, 'reservation', 'Your reserved book "Beloved" is now available for pickup.', '2025-04-04 08:00:00', NULL, 'unread'),
(6, 'fine', 'A fine of $7.50 has been added to your account for overdue book.', '2025-04-03 09:30:00', NULL, 'unread'),
(7, 'system', 'Reminder: The library will be closed on April 15th for maintenance.', '2025-04-05 10:00:00', NULL, 'unread');

-- Update database statistics to reflect the seed data

-- Update transaction status for overdue books
UPDATE TRANSACTION
SET 
    transaction_status = 'overdue',
    fine_amount = DATEDIFF('2025-04-05', due_date) * 0.50 -- $0.50 per day calculated to current date
WHERE 
    return_date IS NULL 
    AND due_date < '2025-04-05'
    AND transaction_status != 'lost';

-- Update fine status in transactions
UPDATE TRANSACTION t
JOIN FINE f ON t.transaction_id = f.transaction_id
SET t.fine_status = f.payment_status
WHERE t.fine_status != f.payment_status;

-- Update last_login for users
UPDATE USER
SET last_login = '2025-04-01 09:30:45'
WHERE user_id = 1;

-- Insert transactions with books due in the next three days (April 6-8, 2025)
INSERT INTO TRANSACTION (user_id, book_id, borrow_date, due_date, return_date, transaction_status, notes) VALUES
(4, 1, '2025-03-23 10:00:00', '2025-04-06 10:00:00', NULL, 'borrowed', 'Due soon for user John Doe.'),
(5, 2, '2025-03-24 11:00:00', '2025-04-07 11:00:00', NULL, 'borrowed', 'Due soon for user Jane Smith.'),
(6, 3, '2025-03-25 12:00:00', '2025-04-08 12:00:00', NULL, 'borrowed', 'Due soon for user Robert Johnson.');

-- SELECT * FROM TRANSACTION;

-- Ensure the corresponding transactions exist for user_id = 7
INSERT INTO TRANSACTION (transaction_id, user_id, book_id, borrow_date, due_date, return_date, transaction_status, notes) VALUES
(33, 7, 4, '2025-03-23 10:00:00', '2025-04-06 10:00:00', '2025-04-05 10:00:00', 'returned', 'Returned just in time, no fine applied.'),
(34, 7, 5, '2025-03-24 11:00:00', '2025-04-07 11:00:00', NULL, 'borrowed', 'Due tomorrow.');

-- Insert notification reminders for books due in next three days
INSERT INTO NOTIFICATION (user_id, notification_type, message, created_date, read_date, status) VALUES
(4, 'due_date', 'Your book "Harry Potter and the Philosopher\'s Stone" is due tomorrow.', '2025-04-05 08:00:00', NULL, 'unread'),
(5, 'due_date', 'Your book "1984" is due in 2 days.', '2025-04-05 08:00:00', NULL, 'unread'),
(6, 'due_date', 'Your book "Pride and Prejudice" is due in 3 days.', '2025-04-05 08:00:00', NULL, 'unread');

-- First, create transactions for user_id = 7 that will have associated fines
INSERT INTO TRANSACTION (transaction_id, user_id, book_id, borrow_date, due_date, return_date, transaction_status, fine_amount, fine_status, notes) VALUES
(101, 7, 2, '2025-03-15 13:20:00', '2025-03-29 13:20:00', NULL, 'overdue', 3.50, 'pending', 'Overdue by 7 days.'),
(102, 7, 4, '2025-03-20 10:15:00', '2025-04-03 10:15:00', NULL, 'overdue', 1.00, 'pending', 'Recently overdue.'),
(103, 7, 6, '2025-03-10 14:30:00', '2025-03-24 14:30:00', '2025-04-01 16:45:00', 'returned', 4.00, 'pending', 'Returned late, fine applied.'),
(104, 7, 9, '2025-03-01 09:45:00', '2025-03-15 09:45:00', '2025-03-30 11:20:00', 'returned', 7.50, 'pending', 'Returned very late, fine to be paid.');

-- Now create the corresponding fine records
INSERT INTO FINE (fine_id, transaction_id, amount, fine_date, payment_date, payment_method, payment_status, receipt_number) VALUES
(201, 101, 3.50, '2025-04-05 00:00:00', NULL, NULL, 'pending', NULL),
(202, 102, 1.00, '2025-04-05 00:00:00', NULL, NULL, 'pending', NULL),
(203, 103, 4.00, '2025-04-01 16:45:00', NULL, NULL, 'pending', NULL),
(204, 104, 7.50, '2025-03-30 11:20:00', NULL, NULL, 'pending', NULL);

-- SELECT * FROM TRANSACTION;

-- Insert reviews for books to meet the query criteria
INSERT INTO REVIEW (user_id, book_id, rating, review_text, review_date, review_status) VALUES
-- Reviews for Book ID 1
(1, 1, 5, 'Amazing book! A must-read for everyone.', '2025-03-01 10:00:00', 'approved'),
(2, 1, 4, 'Great story, but a bit slow in the middle.', '2025-03-02 11:00:00', 'approved'),
(3, 1, 5, 'Loved the characters and the plot!', '2025-03-03 12:00:00', 'approved'),
-- Reviews for Book ID 2
(4, 2, 4, 'A thought-provoking and chilling dystopian novel.', '2025-03-04 13:00:00', 'approved'),
(5, 2, 5, 'An absolute masterpiece of literature.', '2025-03-05 14:00:00', 'approved'),
(6, 2, 4, 'Very relevant to today\'s world.', '2025-03-06 15:00:00', 'approved'),
-- Reviews for Book ID 3
(7, 3, 3, 'A classic, but not my favorite.', '2025-03-07 16:00:00', 'approved'),
(8, 3, 4, 'Enjoyable and well-written.', '2025-03-08 17:00:00', 'approved'),
(9, 3, 4, 'A timeless piece of literature.', '2025-03-09 18:00:00', 'approved');

-- Insert transactions for Book ID 1 (with overdue transactions)
INSERT INTO TRANSACTION (transaction_id, user_id, book_id, borrow_date, due_date, return_date, transaction_status, notes) VALUES
(35, 1, 1, '2025-03-20 10:00:00', '2025-04-03 10:00:00', '2025-04-05 10:00:00', 'returned', 'Returned late.'),
(36, 2, 1, '2025-03-22 11:00:00', '2025-04-05 11:00:00', NULL, 'borrowed', 'Due today.'),
(37, 3, 1, '2025-03-18 12:00:00', '2025-04-01 12:00:00', NULL, 'overdue', 'Still overdue by 4 days.'),
(38, 4, 1, '2025-03-17 13:00:00', '2025-03-31 13:00:00', '2025-04-04 13:00:00', 'returned', 'Returned late.');

-- Insert transactions for Book ID 2 (with overdue transactions)
INSERT INTO TRANSACTION (transaction_id, user_id, book_id, borrow_date, due_date, return_date, transaction_status, notes) VALUES
(39, 6, 2, '2025-03-19 10:00:00', '2025-04-02 10:00:00', '2025-04-03 10:00:00', 'returned', 'Returned late.'),
(40, 7, 2, '2025-03-21 11:00:00', '2025-04-04 11:00:00', '2025-04-05 11:00:00', 'returned', 'Returned late.'),
(41, 8, 2, '2025-03-17 12:00:00', '2025-03-31 12:00:00', NULL, 'overdue', 'Still overdue by 5 days.'),
(42, 9, 2, '2025-03-22 13:00:00', '2025-04-05 13:00:00', NULL, 'borrowed', 'Due today.'),
(43, 10, 2, '2025-03-25 14:00:00', '2025-04-08 14:00:00', NULL, 'borrowed', 'Currently borrowed, due in 3 days.');

-- Insert transactions for Book ID 3 (no overdue transactions)
INSERT INTO TRANSACTION (transaction_id, user_id, book_id, borrow_date, due_date, return_date, transaction_status, notes) VALUES
(44, 1, 3, '2025-03-19 10:00:00', '2025-04-02 10:00:00', '2025-04-01 10:00:00', 'returned', 'Returned on time.'),
(45, 2, 3, '2025-03-21 11:00:00', '2025-04-04 11:00:00', '2025-04-03 11:00:00', 'returned', 'Returned on time.'),
(46, 3, 3, '2025-03-22 12:00:00', '2025-04-05 12:00:00', '2025-04-04 12:00:00', 'returned', 'Returned on time.'),
(47, 4, 3, '2025-03-23 13:00:00', '2025-04-06 13:00:00', NULL, 'borrowed', 'Due tomorrow.'),
(48, 6, 3, '2025-03-16 10:00:00', '2025-03-30 10:00:00', '2025-04-02 10:00:00', 'returned', 'Returned late.'),
(49, 7, 3, '2025-03-15 11:00:00', '2025-03-29 11:00:00', NULL, 'overdue', 'Still overdue by 7 days.'),
(50, 8, 3, '2025-03-20 12:00:00', '2025-04-03 12:00:00', '2025-04-04 12:00:00', 'returned', 'Returned late.');

-- Insert audit logs for suspicious login attempts
INSERT INTO AUDIT_LOG (user_id, action, timestamp, ip_address, details) VALUES
-- Suspicious attempts from IP 192.168.1.101 (last night)
(1, 'login_attempt', '2025-04-04 21:22:00', '192.168.1.101', 'Login failed: Incorrect password'),
(1, 'login_attempt', '2025-04-04 21:24:00', '192.168.1.101', 'Login failed: Incorrect password'),
(1, 'login_attempt', '2025-04-04 21:26:00', '192.168.1.101', 'Login failed: Incorrect password'),
(1, 'login_attempt', '2025-04-04 21:28:00', '192.168.1.101', 'Login failed: Incorrect password'),
(1, 'login_attempt', '2025-04-04 21:30:00', '192.168.1.101', 'Login failed: Incorrect password'),
-- Suspicious attempts from IP 192.168.1.102 (early morning)
(2, 'login_attempt', '2025-04-05 03:12:00', '192.168.1.102', 'Login failed: User does not exist'),
(2, 'login_attempt', '2025-04-05 03:14:00', '192.168.1.102', 'Login failed: User does not exist'),
(2, 'login_attempt', '2025-04-05 03:16:00', '192.168.1.102', 'Login failed: User does not exist'),
(2, 'login_attempt', '2025-04-05 03:18:00', '192.168.1.102', 'Login failed: User does not exist'),
(2, 'login_attempt', '2025-04-05 03:20:00', '192.168.1.102', 'Login failed: User does not exist'),
-- Suspicious attempts from IP 192.168.1.103 (just a few hours ago)
(3, 'login_attempt', '2025-04-05 07:42:00', '192.168.1.103', 'Login failed: Account locked'),
(3, 'login_attempt', '2025-04-05 07:43:00', '192.168.1.103', 'Login failed: Account locked'),
(3, 'login_attempt', '2025-04-05 07:44:00', '192.168.1.103', 'Login failed: Account locked'),
(3, 'login_attempt', '2025-04-05 07:45:00', '192.168.1.103', 'Login failed: Account locked'),
(3, 'login_attempt', '2025-04-05 07:46:00', '192.168.1.103', 'Login failed: Account locked');

UPDATE AUDIT_LOG
SET timestamp = CURRENT_TIMESTAMP
WHERE action = 'login_attempt';