CREATE TABLE events (
    id int,
    event_name VARCHAR(50),
    start_date TIMESTAMP
);

INSERT INTO events (id, event_name, start_date) VALUES 
(1, 'Event A', '2024-01-01'),
(2, 'Event B', '2024-01-05'),
(3, 'Event C', '2024-01-10');


SELECT e1.event_name, COALESCE(STRING_AGG(e2.event_name,', '), 'No next event') AS next_event, e1.start_date
FROM events e1
LEFT JOIN events e2 ON e1.id < e2.id
GROUP BY e1.event_name, e1.start_date
ORDER BY event_name ASC;


CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    referred_by int
);

INSERT INTO customers (name, referred_by) VALUES
('Alice', NULL),
('Bob', 1),
('Charlie',1),
('David', 2),
('Eva', 2),
('Frank', 3);

SELECT c1.name AS customer_name, COALESCE(c2.name, 'Not Reffered') AS referrer_name
FROM customers c1
LEFT JOIN customers c2 ON c1.referred_by = c2.id;

SELECT name FROM customers
WHERE referred_by IS NULL;

SELECT c1.name AS customer_name, COUNT(c2.id) AS count_reffered
FROM customers c1 
LEFT JOIN customers c2 ON c2.referred_by = c1.id
GROUP BY c1.name
ORDER BY c1.name ASC;


SELECT c1.name AS customer_name, COUNT(c2.id) AS count_reffered
FROM customers c1 
LEFT JOIN customers c2 ON c2.referred_by = c1.id
GROUP BY c1.name
-- WHERE c2.referred_by = 2
HAVING COUNT(c2.id) > 0;
-- GROUP BY c1.name
-- ORDER BY c1.name ASC;


