-- Question 1: Lấy danh sách nhân viên và thông tin phòng ban
select a.*, d.DepartmentName
from account a
join department d on a.DepartmentID=d.DepartmentID;

-- Question 2: Lấy thông tin các account được tạo sau ngày 20/12/2010
select * from account where CreateDate >'2010-12-20';

-- Question 3: Lấy tất cả các developer
SELECT * FROM Account WHERE PositionID = 1;

-- Question 4: Lấy danh sách các phòng ban có >3 nhân viên
SELECT DepartmentID, COUNT(*) as EmployeeCount 
FROM Account
GROUP BY DepartmentID
HAVING COUNT(*) > 0;

-- Question 5: Lấy danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT QuestionID, COUNT(ExamID) AS ExamCount
from examquestion
group by questionid
order by examcount desc;

-- Question 6: Thống kê mỗi category question được sử dụng trong bao nhiêu câu hỏi
SELECT CategoryID, COUNT(*) AS QuestionCount 
from question
group by categoryid;

-- Question 7: Thống kê mỗi question được sử dụng trong bao nhiêu exam
select questionid, count(*) as ExamUseCount
from ExamQuestion
group by questionid;

-- Question 8: Lấy ra question có nhiều câu trả lời nhất
SELECT QuestionID, COUNT(AnswerID) AS AnswerCount 
FROM Answer 
GROUP BY QuestionID 
order by answercount desc
limit 1;

-- Question 9: Thống kê số lượng account trong mỗi group
select groupid, count(*) as AccountCount
from GroupAccount
group by GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT PositionID, COUNT(*) AS EmployeeCount 
FROM Account 
group by positionid
order by EmployeeCount
limit 1;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu Dev, Test, Scrum Master, PM
SELECT d.DepartmentName, p.PositionName, COUNT(a.AccountID) AS EmployeeCount 
FROM Account a 
JOIN Department d ON a.DepartmentID = d.DepartmentID 
JOIN Position p ON a.PositionID = p.PositionID 
GROUP BY d.DepartmentName, p.PositionName;

  -- Question 12: Lấy thông tin chi tiết của câu hỏi
SELECT q.*, t.TypeName, a.FullName AS CreatorName, an.Content AS AnswerContent, an.isCorrect 
FROM Question q 
JOIN TypeQuestion t ON q.TypeID = t.TypeID
JOIN Account a ON q.CreatorID = a.AccountID 
LEFT JOIN Answer an ON q.QuestionID = an.QuestionID;

-- Question 13: Lấy số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select t.TypeName, count(q.QuestionID) as questioncount
from question q
join typequestion t on q.typeid=t.typeid
group by t.typename;

-- Question 14: Lấy ra group không có account nào
SELECT g.GroupID, g.GroupName 
FROM `Group` g 
left join GroupAccount ga on g.GroupID = ga.GroupID 
where ga.AccountID IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT q.QuestionID, q.Content 
FROM Question q 
left JOIN Answer a ON q.QuestionID = a.QuestionID 
WHERE a.AnswerID IS NULL;

-- Question 17a:
SELECT AccountID 
FROM GroupAccount WHERE GroupID = 1;
-- Question 17b: 
SELECT AccountID 
FROM GroupAccount WHERE GroupID = 2;
-- Question 17: 
SELECT AccountID 
FROM GroupAccount WHERE GroupID = 1
union
SELECT AccountID 
FROM GroupAccount WHERE GroupID = 2;

-- Question 18a
SELECT GroupID FROM GroupAccount GROUP BY GroupID HAVING COUNT(AccountID) > 5;

-- Question 18b: 
SELECT GroupID FROM GroupAccount GROUP BY GroupID HAVING COUNT(AccountID) < 7;

-- Question 18c: 
SELECT GroupID FROM GroupAccount GROUP BY GroupID HAVING COUNT(AccountID) > 5
UNION
SELECT GroupID FROM GroupAccount GROUP BY GroupID HAVING COUNT(AccountID) < 7;



