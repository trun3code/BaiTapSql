-- Question 1: Tạo trigger không cho phép nhập Group có ngày tạo trước 1 năm trước
DELIMITER //
CREATE TRIGGER PreventOldGroupInsert
BEFORE INSERT ON `Group`
FOR EACH ROW
BEGIN
    IF NEW.CreateDate < DATE_SUB(CURDATE(), INTERVAL 1 YEAR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert a group created before 1 year ago';
    END IF;
END //
DELIMITER ;

-- Question 2: Tạo trigger không cho phép thêm user vào department "Sale"
delimiter //
create trigger PreventUserInSaleDepartment
before insert on account
for each row
begin
	IF (NEW.DepartmentID = (SELECT DepartmentID 
							FROM Department WHERE DepartmentName = 'Sale')) 
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department "Sale" cannot add more users';
    END IF;
end //
DELIMITER ;

-- Question 3: Giới hạn số user trong một group tối đa 5
DELIMITER //
CREATE TRIGGER LimitUsersInGroup
BEFORE INSERT ON GroupAccount
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM GroupAccount WHERE GroupID = NEW.GroupID) >= 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A group can have at most 5 users';
    END IF;
END //
DELIMITER ;

-- Question 4: Giới hạn số question trong một bài thi tối đa 10
DELIMITER //
CREATE TRIGGER LimitQuestionsInExam
BEFORE INSERT ON ExamQuestion
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM ExamQuestion WHERE ExamID = NEW.ExamID) >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'An exam can have at most 10 questions';
    END IF;
END //
DELIMITER ;

-- Question 5: Không cho phép xóa tài khoản admin@gmail.com
DELIMITER //
CREATE TRIGGER PreventAdminDeletion
BEFORE DELETE ON Account
FOR EACH ROW
BEGIN
    IF OLD.Email = 'admin@gmail.com' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete admin account';
    END IF;
END //
DELIMITER ;

-- Question 6: Tự động phân vào phòng ban "Waiting Department" nếu không nhập DepartmentID
DELIMITER //
CREATE TRIGGER DefaultDepartmentOnInsert
BEFORE INSERT ON Account
FOR EACH ROW
BEGIN
    IF NEW.DepartmentID IS NULL THEN
        SET NEW.DepartmentID = (SELECT DepartmentID FROM Department 
								WHERE DepartmentName = 'Waiting Department');
    END IF;
END //
DELIMITER ;

-- Question 7: Giới hạn số đáp án và số đáp án đúng trong một câu hỏi
DELIMITER //
CREATE TRIGGER LimitAnswersPerQuestion
BEFORE INSERT ON Answer
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM Answer WHERE QuestionID = NEW.QuestionID) >= 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A question can have at most 4 answers';
    END IF;
    
    IF NEW.isCorrect = TRUE AND (SELECT COUNT(*) FROM Answer WHERE QuestionID = NEW.QuestionID AND isCorrect = TRUE) >= 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A question can have at most 2 correct answers';
    END IF;
END //
DELIMITER ;

-- Question 8: Chuẩn hóa giá trị gender
DELIMITER //
CREATE TRIGGER NormalizeGender
BEFORE INSERT ON Account
FOR EACH ROW
BEGIN
    IF NEW.Gender = 'nam' THEN
        SET NEW.Gender = 'M';
    ELSEIF NEW.Gender = 'nữ' THEN
        SET NEW.Gender = 'F';
    ELSEIF NEW.Gender = 'chưa xác định' THEN
        SET NEW.Gender = 'U';
    END IF;
END //
DELIMITER ;

-- Question 9: Không cho phép xóa bài thi mới tạo trong vòng 2 ngày
DELIMITER //
CREATE TRIGGER PreventRecentExamDeletion
BEFORE DELETE ON Exam
FOR EACH ROW
BEGIN
    IF DATEDIFF(CURDATE(), OLD.CreateDate) <= 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete an exam created within the last 2 days';
    END IF;
END //
DELIMITER ;

-- Question 10: Chỉ cho phép update hoặc delete question chưa nằm trong exam nào
DELIMITER //
CREATE TRIGGER RestrictQuestionModification
BEFORE UPDATE ON Question
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM ExamQuestion WHERE QuestionID = OLD.QuestionID) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot modify a question that is part of an exam';
    END IF;
END //
DELIMITER ;

-- Question 12: Định dạng thời gian của exam
SELECT ExamID, 
    CASE 
        WHEN Duration <= 30 THEN 'Short time'
        WHEN Duration > 30 AND Duration <= 60 THEN 'Medium time'
        ELSE 'Long time'
    END AS TimeCategory
FROM Exam;

-- Question 13: Thống kê số lượng account trong group và gán category
SELECT GroupID, COUNT(AccountID) AS UserCount, 
    CASE 
        WHEN COUNT(AccountID) <= 5 THEN 'few'
        WHEN COUNT(AccountID) > 5 AND COUNT(AccountID) <= 20 THEN 'normal'
        ELSE 'higher'
    END AS TheNumberUserAmount
FROM GroupAccount
GROUP BY GroupID;

-- Question 14: Thống kê số user trong mỗi phòng ban, nếu không có thì hiển thị "Không có User"
SELECT d.DepartmentID, d.DepartmentName, 
    IFNULL(COUNT(a.AccountID), 'Không có User') AS UserCount
FROM Department d
LEFT JOIN Account a ON d.DepartmentID = a.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;