CREATE DATABASE ExamManagement;
USE ExamManagement;

-- Table: Department
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

INSERT INTO Department (DepartmentName) VALUES
('Sales'), ('Marketing'), ('HR'), ('Finance'), ('IT'), ('Admin'), ('Support'), ('Development'), ('QA'), ('Operations');

-- Table: Position
CREATE TABLE `Position` (
    PositionID INT AUTO_INCREMENT PRIMARY KEY,
    PositionName VARCHAR(50) NOT NULL
);

INSERT INTO Position (PositionName) VALUES
('Dev'), ('Test'), ('Scrum Master'), ('PM'), ('HR'), ('Support'), ('Admin'), ('Finance'), ('QA'), ('Marketing');

-- Table: Account
CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    PositionID INT,
    CreateDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID, CreateDate) VALUES
('user1@example.com', 'user1', 'User One', 1, 1, '2024-01-01'),
('user2@example.com', 'user2', 'User Two', 2, 2, '2024-01-02'),
('user3@example.com', 'user3', 'User Three', 3, 3, '2024-01-03'),
('user4@example.com', 'user4', 'User Four', 4, 4, '2024-01-04'),
('user5@example.com', 'user5', 'User Five', 5, 5, '2024-01-05'),
('user6@example.com', 'user6', 'User Six', 6, 6, '2024-01-06'),
('user7@example.com', 'user7', 'User Seven', 7, 7, '2024-01-07'),
('user8@example.com', 'user8', 'User Eight', 8, 8, '2024-01-08'),
('user9@example.com', 'user9', 'User Nine', 9, 9, '2024-01-09'),
('user10@example.com', 'user10', 'User Ten', 10, 10, '2024-01-10');

-- Table: Group
CREATE TABLE `Group` (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(100) NOT NULL,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

INSERT INTO `Group` (GroupName, CreatorID, CreateDate) VALUES
('Group A', 1, '2024-01-01'),
('Group B', 2, '2024-01-02'),
('Group C', 3, '2024-01-03'),
('Group D', 4, '2024-01-04'),
('Group E', 5, '2024-01-05'),
('Group F', 6, '2024-01-06'),
('Group G', 7, '2024-01-07'),
('Group H', 8, '2024-01-08'),
('Group I', 9, '2024-01-09'),
('Group J', 10, '2024-01-10');

-- Table: GroupAccount
CREATE TABLE GroupAccount (
    GroupID INT,
    AccountID INT,
    JoinDate DATE,
    PRIMARY KEY (GroupID, AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

INSERT INTO GroupAccount (GroupID, AccountID, JoinDate) VALUES
(1, 1, '2024-01-01'), (2, 2, '2024-01-02'), (3, 3, '2024-01-03'),
(4, 4, '2024-01-04'), (5, 5, '2024-01-05'), (6, 6, '2024-01-06'),
(7, 7, '2024-01-07'), (8, 8, '2024-01-08'), (9, 9, '2024-01-09'), (10, 10, '2024-01-10');

-- Table: TypeQuestion
CREATE TABLE TypeQuestion (
    TypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL
);

INSERT INTO TypeQuestion (TypeName) VALUES ('Essay'), ('Multiple-Choice');

-- Table: CategoryQuestion
CREATE TABLE CategoryQuestion (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

INSERT INTO CategoryQuestion (CategoryName) VALUES ('Java'), ('.NET'), ('SQL'), ('Postman'), ('Ruby'), ('Python'), ('C++'), ('JavaScript'), ('HTML'), ('CSS');

-- Table: Question
CREATE TABLE Question (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES
('What is Java?', 1, 1, 1, '2024-01-10'),
('What is .NET?', 2, 2, 2, '2024-01-11'),
('What is SQL?', 3, 1, 3, '2024-01-12'),
('What is Postman used for?', 4, 2, 4, '2024-01-13'),
('What is Ruby?', 5, 1, 5, '2024-01-14'),
('What is Python?', 6, 2, 6, '2024-01-15'),
('What is C++?', 7, 1, 7, '2024-01-16'),
('What is JavaScript?', 8, 2, 8, '2024-01-17'),
('What is HTML?', 9, 1, 9, '2024-01-18'),
('What is CSS?', 10, 2, 10, '2024-01-19');

-- Table: Answer
CREATE TABLE Answer (
    AnswerID INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    QuestionID INT,
    isCorrect BOOLEAN,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES
('Java is a programming language.', 1, TRUE),
('Java is a database system.', 1, FALSE),
('.NET is a framework by Microsoft.', 2, TRUE),
('.NET is a type of operating system.', 2, FALSE),
('SQL is used for managing databases.', 3, TRUE),
('Postman is an API testing tool.', 4, TRUE),
('Python is a snake.', 6, FALSE),
('C++ is an updated version of C.', 7, TRUE),
('HTML stands for HyperText Markup Language.', 9, TRUE),
('CSS is used for styling websites.', 10, TRUE);

-- Table: Exam
CREATE TABLE Exam (
    ExamID INT AUTO_INCREMENT PRIMARY KEY,
    Code VARCHAR(50) NOT NULL UNIQUE,
    Title VARCHAR(100) NOT NULL,
    CategoryID INT,
    Duration INT NOT NULL,
    CreatorID INT,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES Account(AccountID)
);

INSERT INTO Exam (Code, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES
('EX001', 'Java Basics', 1, 60, 1, '2024-01-20'),
('EX002', '.NET Fundamentals', 2, 45, 2, '2024-01-21'),
('EX003', 'SQL Queries', 3, 50, 3, '2024-01-22'),
('EX004', 'Postman API Testing', 4, 40, 4, '2024-01-23'),
('EX005', 'Ruby Programming', 5, 55, 5, '2024-01-24'),
('EX006', 'Python Basics', 6, 60, 6, '2024-01-25'),
('EX007', 'C++ Advanced', 7, 70, 7, '2024-01-26'),
('EX008', 'JavaScript Essentials', 8, 50, 8, '2024-01-27'),
('EX009', 'HTML & CSS', 9, 30, 9, '2024-01-28'),
('EX010', 'CSS Styling Techniques', 10, 35, 10, '2024-01-29');

-- Table: ExamQuestion
CREATE TABLE ExamQuestion (
    ExamID INT,
    QuestionID INT,
    PRIMARY KEY (ExamID, QuestionID),
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

INSERT INTO Department (DepartmentName) VALUES
('Research'), ('Legal'), ('Engineering'), ('Customer Relations'), ('Logistics'),
('Product Management'), ('Training'), ('Public Relations'), ('Business Development'), ('Manufacturing');

-- Additional 10 rows for Position
INSERT INTO Position (PositionName) VALUES
('Team Lead'), ('Senior Developer'), ('Junior Developer'), ('Tester'), ('Database Administrator'),
('System Analyst'), ('UX Designer'), ('UI Developer'), ('DevOps Engineer'), ('Product Owner');

-- Additional 10 rows for Account
INSERT INTO Account (Email, Username, FullName, DepartmentID, PositionID, CreateDate) VALUES
('john.doe@example.com', 'jdoe', 'John Doe', 2, 3, '2024-02-05'),
('mary.smith@example.com', 'msmith', 'Mary Smith', 3, 1, '2024-02-10'),
('robert.johnson@example.com', 'rjohnson', 'Robert Johnson', 5, 5, '2024-02-15'),
('lisa.wong@example.com', 'lwong', 'Lisa Wong', 1, 7, '2024-02-20'),
('david.kim@example.com', 'dkim', 'David Kim', 8, 4, '2024-02-25'),
('sarah.patel@example.com', 'spatel', 'Sarah Patel', 9, 10, '2024-03-01'),
('michael.nguyen@example.com', 'mnguyen', 'Michael Nguyen', 6, 8, '2024-03-05'),
('jennifer.garcia@example.com', 'jgarcia', 'Jennifer Garcia', 4, 6, '2024-03-10'),
('james.wilson@example.com', 'jwilson', 'James Wilson', 7, 2, '2024-03-15'),
('emily.taylor@example.com', 'etaylor', 'Emily Taylor', 10, 9, '2024-03-20');

-- Additional 10 rows for Group
INSERT INTO `Group` (GroupName, CreatorID, CreateDate) VALUES
('Frontend Team', 3, '2024-02-01'),
('Backend Team', 1, '2024-02-10'),
('Testing Team', 5, '2024-02-15'),
('DevOps Team', 7, '2024-02-20'),
('Mobile Team', 9, '2024-02-25'),
('UX/UI Team', 11, '2024-03-01'),
('Data Science Team', 13, '2024-03-05'),
('Product Team', 15, '2024-03-10'),
('Support Team', 17, '2024-03-15'),
('Security Team', 19, '2024-03-20');

-- Additional 10 rows for GroupAccount
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate) VALUES
(3, 2, '2024-02-05'), (5, 4, '2024-02-10'), (7, 6, '2024-02-15'),
(9, 8, '2024-02-20'), (2, 10, '2024-02-25'), (4, 12, '2024-03-01'),
(6, 14, '2024-03-05'), (8, 16, '2024-03-10'), (10, 18, '2024-03-15'), (1, 20, '2024-03-20');

-- Additional TypeQuestion rows (only adding 1 more since there are only 2 in the initial data)
INSERT INTO TypeQuestion (TypeName) VALUES ('Mixed');

-- Additional 10 rows for CategoryQuestion
INSERT INTO CategoryQuestion (CategoryName) VALUES 
('Angular'), ('React'), ('Vue.js'), ('Node.js'), ('Docker'),
('Kubernetes'), ('AWS'), ('Azure'), ('Machine Learning'), ('Data Analysis');

-- Additional 10 rows for Question
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate) VALUES
('What are Angular directives?', 11, 1, 2, '2024-02-01'),
('Explain React hooks.', 12, 2, 4, '2024-02-05'),
('What is Vue.js component lifecycle?', 13, 1, 6, '2024-02-10'),
('Describe Node.js event loop.', 14, 2, 8, '2024-02-15'),
('What are Docker containers?', 15, 1, 10, '2024-02-20'),
('Explain Kubernetes pods.', 16, 2, 1, '2024-02-25'),
('What are AWS EC2 instances?', 17, 1, 3, '2024-03-01'),
('Describe Azure App Services.', 18, 2, 5, '2024-03-05'),
('What is supervised learning?', 19, 1, 7, '2024-03-10'),
('Explain data normalization.', 20, 2, 9, '2024-03-15');

-- Additional 10 rows for Answer
INSERT INTO Answer (Content, QuestionID, isCorrect) VALUES
('Angular directives are markers on DOM elements that tell Angular to attach a specified behavior.', 11, TRUE),
('React hooks are functions that let you use state and lifecycle features in functional components.', 12, TRUE),
('Vue.js component lifecycle includes creation, mounting, updating, and destruction phases.', 13, TRUE),
('Node.js event loop is what allows Node.js to perform non-blocking I/O operations.', 14, TRUE),
('Docker containers are lightweight, standalone, executable packages that include everything needed to run an application.', 15, TRUE),
('Kubernetes pods are the smallest deployable units that can be created and managed in Kubernetes.', 16, TRUE),
('AWS EC2 instances are virtual servers in Amazon\'s Elastic Compute Cloud for running applications.', 17, TRUE),
('Azure App Services is a fully managed platform for building, deploying, and scaling web apps.', 18, TRUE),
('Supervised learning is a machine learning approach where the model is trained on labeled data.', 19, TRUE),
('Data normalization scales values to a specific range, usually 0 to 1, to improve model performance.', 20, TRUE);

-- Additional 10 rows for Exam
INSERT INTO Exam (Code, Title, CategoryID, Duration, CreatorID, CreateDate) VALUES
('EX011', 'Angular Fundamentals', 11, 60, 2, '2024-02-01'),
('EX012', 'React Mastery', 12, 75, 4, '2024-02-05'),
('EX013', 'Vue.js Essentials', 13, 55, 6, '2024-02-10'),
('EX014', 'Node.js Backend', 14, 90, 8, '2024-02-15'),
('EX015', 'Docker Basics', 15, 45, 10, '2024-02-20'),
('EX016', 'Kubernetes for Beginners', 16, 60, 1, '2024-02-25'),
('EX017', 'AWS Cloud Services', 17, 120, 3, '2024-03-01'),
('EX018', 'Azure Fundamentals', 18, 90, 5, '2024-03-05'),
('EX019', 'Machine Learning Intro', 19, 75, 7, '2024-03-10'),
('EX020', 'Data Analysis Techniques', 20, 60, 9, '2024-03-15');

-- Additional 10 rows for ExamQuestion
INSERT INTO ExamQuestion (ExamID, QuestionID) VALUES
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 16), (17, 17), (18, 18), (19, 19), (20, 20);
