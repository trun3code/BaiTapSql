-- question 2: Lấy ra tất cả các phòng ban
SELECT * FROM Department;
-- question 3: Lấy ra ID của phòng ban "Sale"
SELECT DepartmentID FROM Department WHERE DepartmentName = 'Sale';
-- question 4: lấy ra thông tin account có full name dài nhất
SELECT * FROM Account ORDER BY LENGTH(FullName) DESC LIMIT 1;

-- question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
 SELECT * FROM Account 
 where DepartmentID = '3'
 ORDER BY LENGTH(FullName) DESC LIMIT 1 ;

-- question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
Select GroupName from `Group` where CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID FROM Answer 
GROUP BY QuestionID
HAVING COUNT(AnswerID) >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày
SELECT Code FROM Exam WHERE Duration >= 60 AND CreateDate < '2019-12-20';

-- 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `Group` ORDER BY CreateDate desc LIMIT 5;

-- 10:
Select count(*) from Account where DepartmentID=2;

-- 11:
SELECT * FROM Account WHERE FullName LIKE 'U%e';

-- 12: 
delete from Exam where CreateDate < '2019/12/20';

-- 13: 
DELETE FROM Question WHERE Content LIKE 'câu hỏi%';

-- Question 14
UPDATE Account SET FullName = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn' WHERE AccountID = 5;
-- Question 15
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate) VALUES (4, 5, CURDATE());




