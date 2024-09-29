--TABLES CREATION

CREATE TABLE Address (
    address_id SERIAL PRIMARY KEY,
    country VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    postal_code VARCHAR(30) NOT NULL,
    street VARCHAR(30) NOT NULL,
    number INT NOT NULL
);

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    second_name VARCHAR(30) NOT NULL,
    name VARCHAR(30) NOT NULL,
    email_address VARCHAR(50) NOT NULL,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE Teacher (
    teacher_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Bootcamp (
    bootcamp_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price FLOAT NOT NULL,
    edition INT NOT NULL
);

CREATE TABLE Subject (
    subject_id SERIAL PRIMARY KEY,
    teacher_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Bootcamp_Subject (
    bootcamp_subject_id SERIAL PRIMARY KEY,
    bootcamp_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (bootcamp_id) REFERENCES Bootcamp(bootcamp_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

CREATE TABLE Student (
    student_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    discord_account VARCHAR(30) NOT NULL,
    github_account VARCHAR(30) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    bootcamp_id INT NOT NULL,
    student_id INT NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (bootcamp_id) REFERENCES Bootcamp(bootcamp_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Review (
    review_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(300) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

--INSERTS
-- Inserts para la tabla Address
INSERT INTO Address (country, city, postal_code, street, number) VALUES
('España', 'Madrid', '28001', 'Gran Vía', 1),
('España', 'Barcelona', '08001', 'La Rambla', 2),
('España', 'Valencia', '46001', 'Calle Colón', 3),
('España', 'Sevilla', '41001', 'Avenida de la Constitución', 4),
('España', 'Bilbao', '48001', 'Gran Vía', 5),
('España', 'Málaga', '29001', 'Calle Larios', 6),
('España', 'Zaragoza', '50001', 'Calle Alfonso I', 7),
('España', 'Murcia', '30001', 'Gran Vía', 8),
('España', 'Palma', '07001', 'Calle San Miguel', 9),
('España', 'Las Palmas', '35001', 'Calle Triana', 10);

-- Inserts para la tabla Users
INSERT INTO Users (address_id, first_name, second_name, name, email_address, username, password) VALUES
(1, 'Juan', 'Pérez', 'Juan Pérez', 'juan.perez@example.com', 'juanp', 'password123'),
(2, 'María', 'García', 'María García', 'maria.garcia@example.com', 'mariag', 'password456'),
(3, 'Luis', 'Martínez', 'Luis Martínez', 'luis.martinez@example.com', 'luism', 'password789'),
(4, 'Ana', 'López', 'Ana López', 'ana.lopez@example.com', 'anal', 'password101'),
(5, 'Carlos', 'Sánchez', 'Carlos Sánchez', 'carlos.sanchez@example.com', 'carloss', 'password102'),
(6, 'Elena', 'Gómez', 'Elena Gómez', 'elena.gomez@example.com', 'elenag', 'password103'),
(7, 'Miguel', 'Díaz', 'Miguel Díaz', 'miguel.diaz@example.com', 'migueld', 'password104'),
(8, 'Laura', 'Fernández', 'Laura Fernández', 'laura.fernandez@example.com', 'lauraf', 'password105'),
(9, 'David', 'Ruiz', 'David Ruiz', 'david.ruiz@example.com', 'davidr', 'password106'),
(10, 'Sara', 'Jiménez', 'Sara Jiménez', 'sara.jimenez@example.com', 'saraj', 'password107');

-- Inserts para la tabla Teacher
INSERT INTO Teacher (user_id, hire_date) VALUES
(1, '2022-01-15'),
(2, '2022-02-20'),
(3, '2022-03-25'),
(4, '2022-04-30'),
(5, '2022-05-05'),
(6, '2022-06-10'),
(7, '2022-07-15'),
(8, '2022-08-20'),
(9, '2022-09-25'),
(10, '2022-10-30');

-- Inserts para la tabla Bootcamp
INSERT INTO Bootcamp (name, start_date, end_date, price, edition) VALUES
('Full Stack Development', '2023-01-10', '2023-06-10', 5000.00, 1),
('Data Science', '2023-02-15', '2023-07-15', 6000.00, 1),
('Cybersecurity', '2023-03-20', '2023-08-20', 5500.00, 1),
('UX/UI Design', '2023-04-25', '2023-09-25', 4500.00, 1),
('AI and Machine Learning', '2023-05-30', '2023-10-30', 7000.00, 1),
('Cloud Computing', '2023-06-05', '2023-11-05', 6500.00, 1),
('DevOps', '2023-07-10', '2023-12-10', 6000.00, 1),
('Blockchain', '2023-08-15', '2024-01-15', 7500.00, 1),
('Mobile Development', '2023-09-20', '2024-02-20', 5000.00, 1),
('Game Development', '2023-10-25', '2024-03-25', 5500.00, 1);

-- Inserts para la tabla Subject
INSERT INTO Subject (teacher_id, name) VALUES
(1, 'JavaScript'),
(2, 'Python'),
(3, 'Cybersecurity Fundamentals'),
(4, 'UX Principles'),
(5, 'Machine Learning'),
(6, 'Cloud Architecture'),
(7, 'DevOps Practices'),
(8, 'Blockchain Technology'),
(9, 'Mobile App Development'),
(10, 'Game Design');

-- Inserts para la tabla Bootcamp_Subject
INSERT INTO Bootcamp_Subject (bootcamp_id, subject_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Inserts para la tabla Student
INSERT INTO Student (user_id, discord_account, github_account) VALUES
(3, 'luis_discord', 'luis_github'),
(4, 'ana_discord', 'ana_github'),
(5, 'carlos_discord', 'carlos_github'),
(6, 'elena_discord', 'elena_github'),
(7, 'miguel_discord', 'miguel_github'),
(8, 'laura_discord', 'laura_github'),
(9, 'david_discord', 'david_github'),
(10, 'sara_discord', 'sara_github'),
(1, 'juan_discord', 'juan_github'),
(2, 'maria_discord', 'maria_github');

-- Inserts para la tabla Enrollment
INSERT INTO Enrollment (bootcamp_id, student_id, price) VALUES
(1, 1, 5000),
(2, 2, 6000),
(3, 3, 5500),
(4, 4, 4500),
(5, 5, 7000),
(6, 6, 6500),
(7, 7, 6000),
(8, 8, 7500),
(9, 9, 5000),
(10, 10, 5500);

-- Inserts para la tabla Review
INSERT INTO Review (user_id, rating, comment, date) VALUES
(1, 5, 'Excelente curso, muy recomendable.', '2023-06-11'),
(2, 4, 'Muy buen curso, aunque podría mejorar en algunos aspectos.', '2023-07-16'),
(3, 5, 'Aprendí muchísimo, los profesores son geniales.', '2023-08-21'),
(4, 3, 'El contenido es bueno, pero la organización podría mejorar.', '2023-09-26'),
(5, 4, 'Buena experiencia, aunque algunos temas fueron difíciles.', '2023-10-31'),
(6, 5, 'Curso muy completo y bien estructurado.', '2023-11-05'),
(7, 4, 'Me gustó mucho, pero me hubiera gustado más práctica.', '2023-12-10'),
(8, 5, 'Excelente, superó mis expectativas.', '2024-01-15'),
(9, 3, 'El curso es bueno, pero el ritmo es muy rápido.', '2024-02-20'),
(10, 4, 'Buena formación, aunque algunos profesores no eran muy claros.', '2024-03-25');


-- CONSULTAS
-- Ver todos los valores de la tabla Address
SELECT * FROM Address;

-- Ver todos los valores de la tabla Users
SELECT * FROM Users;

-- Ver todos los valores de la tabla Teacher
SELECT * FROM Teacher;

-- Ver todos los valores de la tabla Bootcamp
SELECT * FROM Bootcamp;

-- Ver todos los valores de la tabla Subject
SELECT * FROM Subject;

-- Ver todos los valores de la tabla Bootcamp_Subject
SELECT * FROM Bootcamp_Subject;

-- Ver todos los valores de la tabla Student
SELECT * FROM Student;

-- Ver todos los valores de la tabla Enrollment
SELECT * FROM Enrollment;

-- Ver todos los valores de la tabla Review
SELECT * FROM Review;

--Obtener información de los usuarios y sus direcciones
SELECT u.user_id, u.first_name, u.second_name, u.email_address, a.city, a.street, a.number
FROM Users u
JOIN Address a ON u.address_id = a.address_id;

--Listar los profesores y las asignaturas que enseñan
SELECT t.teacher_id, u.first_name, u.second_name, s.name AS subject_name
FROM Teacher t
JOIN Users u ON t.user_id = u.user_id
JOIN Subject s ON t.teacher_id = s.teacher_id;

--Mostrar los estudiantes inscritos en cada bootcamp
SELECT b.name AS bootcamp_name, s.first_name, s.second_name, e.price
FROM Enrollment e
JOIN Bootcamp b ON e.bootcamp_id = b.bootcamp_id
JOIN Student st ON e.student_id = st.student_id
JOIN Users s ON st.user_id = s.user_id;

--Obtener las reseñas de los usuarios con sus nombres y correos electrónicos
SELECT r.rating, r.comment, r.date, u.first_name, u.second_name, u.email_address
FROM Review r
JOIN Users u ON r.user_id = u.user_id;

--Listar los bootcamps junto con sus asignaturas y los profesores que las imparten
SELECT b.name AS bootcamp_name, s.name AS subject_name, u.first_name, u.second_name
FROM Bootcamp_Subject bs
JOIN Bootcamp b ON bs.bootcamp_id = b.bootcamp_id
JOIN Subject s ON bs.subject_id = s.subject_id
JOIN Teacher t ON s.teacher_id = t.teacher_id
JOIN Users u ON t.user_id = u.user_id;


--Mostrar los estudiantes con sus cuentas de Discord y GitHub, y los bootcamps en los que están inscritos
SELECT s.first_name, s.second_name, st.discord_account, st.github_account, b.name AS bootcamp_name
FROM Student st
JOIN Users s ON st.user_id = s.user_id
JOIN Enrollment e ON st.student_id = e.student_id
JOIN Bootcamp b ON e.bootcamp_id = b.bootcamp_id;


