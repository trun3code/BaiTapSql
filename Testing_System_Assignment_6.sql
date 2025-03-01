-- Question 1: Tạo store lấy danh sách account thuộc phòng ban
DELIMITER //
create procedure getaccountsbydepartment(in deptname varchar(50))
begin
	select a.*
    from account a
    join department d on a.DepartmentID=d.DepartmentID
    where d.DepartmentName = deptname;
end //
DELIMITER ;

-- Question 2: Tạo store thống kê số lượng account trong mỗi group
DELIMITER //
create procedure AccountByGroup()
begin
	select groupid, count(accountid) as AccountCount
    from groupaccount
    group by groupid;
end //
DELIMITER ;

-- Question 3: Tạo store thống kê số lượng câu hỏi theo type question trong tháng hiện tại
DELIMITER //
create procedure CountQuestionsByType()
begin
		select typeid, count(*) as questioncount
        from question
        where month(createdate)=month(current_date()) and YEAR(CreateDate) = YEAR(CURRENT_DATE())
        group by typeid;
end //
DELIMITER ;

-- Question 4: Tạo store lấy ID của type question có nhiều câu hỏi nhất
DELIMITER //
CREATE PROCEDURE GetMostUsedTypeQuestion()
BEGIN
    SELECT TypeID
    FROM Question
    GROUP BY TypeID
    ORDER BY COUNT(*) DESC
    LIMIT 1;
END //
DELIMITER ;

-- Question 6:Tạo store tìm group hoặc user chứa chuỗi nhập vào
DELIMITER //
CREATE PROCEDURE SearchGroupOrUser(IN searchString VARCHAR(255))
BEGIN
    SELECT 'Group' AS Type, GroupID AS ID, GroupName AS Name 
    FROM `Group` WHERE GroupName LIKE CONCAT('%', searchString, '%')
    UNION
    SELECT 'User' AS Type, AccountID AS ID, Username AS Name 
    FROM Account WHERE Username LIKE CONCAT('%', searchString, '%');
END //
DELIMITER ;

-- Question 7: Store tạo account với thông tin nhập vào
DELIMITER //
CREATE PROCEDURE CreateAccount(
    IN fullName VARCHAR(255),
    IN email VARCHAR(255)
)
BEGIN
    DECLARE username VARCHAR(255);
    SET username = SUBSTRING_INDEX(email, '@', 1);
    INSERT INTO Account (FullName, Email, Username, PositionID, DepartmentID)
    VALUES (fullName, email, username, (SELECT PositionID FROM Position WHERE PositionName = 'Developer'), (SELECT DepartmentID FROM Department WHERE DepartmentName = 'Waiting Room'));
    SELECT 'Account created successfully' AS Message;
END //
DELIMITER ;

-- Question 8: Tạo store lấy content dài nhất của câu hỏi Essay hoặc Multiple-Choice
delimiter //
create procedure GetLongestTypeQuestion(in typename varchar(255))
begin
	select *
	from question q
	join typequestion tq on q.typeid = tq.TypeID
	order by length(q.content) desc
	limit 1;
	end //
delimiter ;

-- Question 9: Store xóa exam theo ID
DELIMITER //
CREATE PROCEDURE DeleteExam(IN examID INT)
BEGIN
    DELETE FROM Exam WHERE ExamID = examID;
    SELECT 'Exam deleted successfully' AS Message;
END //
DELIMITER ;

-- Question 10: Store xóa exam từ 3 năm trước và log số record bị xóa
DELIMITER //
CREATE PROCEDURE DeleteOldExams()
BEGIN
    DECLARE rowCount INT;
    DELETE FROM Exam WHERE YEAR(CreateDate) <= YEAR(CURRENT_DATE()) - 3;
    SET rowCount = ROW_COUNT();
    SELECT CONCAT(rowCount, ' exams deleted.') AS Message;
END //
DELIMITER ;

-- Question 11: Store xóa phòng ban và chuyển account về phòng ban chờ
DELIMITER //
CREATE PROCEDURE DeleteDepartment(IN deptName VARCHAR(255))
BEGIN
    DECLARE defaultDept INT;
    SET defaultDept = (SELECT DepartmentID FROM Department 
						WHERE DepartmentName = 'Waiting Room');
    UPDATE Account SET DepartmentID = defaultDept 
    WHERE DepartmentID = (SELECT DepartmentID FROM Department WHERE DepartmentName = deptName);
    DELETE FROM Department 
    WHERE DepartmentName = deptName;
    SELECT 'Department deleted and accounts moved to Waiting Room' AS Message;
END //
DELIMITER ;

-- Question 12: Store đếm số câu hỏi theo tháng trong năm nay
DELIMITER //
CREATE PROCEDURE CountQuestionsByMonth()
BEGIN
    SELECT MONTH(CreateDate) AS Month, COUNT(*) AS QuestionCount
    FROM Question
    WHERE YEAR(CreateDate) = YEAR(CURRENT_DATE())
    GROUP BY MONTH(CreateDate);
END //
DELIMITER ;

-- Question 13: Store đếm số câu hỏi trong 6 tháng gần đây
DELIMITER //
CREATE PROCEDURE CountQuestionsLast6Months()
BEGIN
    SELECT 
        MONTH(CreateDate) AS Month,
        IFNULL(COUNT(*), 'Không có câu hỏi nào trong tháng') AS QuestionCount
    FROM Question
    WHERE CreateDate >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
    GROUP BY MONTH(CreateDate);
END //
DELIMITER ;

