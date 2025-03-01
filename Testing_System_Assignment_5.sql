
-- -- Question 1: Tạo view danh sách nhân viên thuộc phòng ban sale
CREATE VIEW View_SaleEmployees AS
WITH SaleDept AS (
    SELECT DepartmentID FROM Department WHERE DepartmentName = 'Sale'
)
select *
from account 
where account.departmentid in(select departmentid from saledept);

-- -- Question 2: Tạo view chứa thông tin account tham gia nhiều group nhất
CREATE VIEW View_MostActiveAccounts AS
SELECT a.AccountID, a.FullName, COUNT(ga.GroupID) AS GroupCount
FROM Account a	
JOIN GroupAccount ga ON a.AccountID = ga.AccountID
GROUP BY a.AccountID, a.FullName
ORDER BY GroupCount DESC
LIMIT 1;

-- Question 3: Tạo view chứa câu hỏi có content quá dài (> 300 từ) và xóa nó đi
create view view_longquestion as
select * from question
where length() >300;
delete from question where length(Content)>300;

-- Question 4: Tạo view danh sách các phòng ban có nhiều nhân viên nhất
create view view_lagestdeparntment as
select d.departmentid, d.departmentname, count(a.accountID) as employeecount
from department d
join account a on d.DepartmentID = a.DepartmentID
group by d.departmentid, d.departmentname
order by EmployeeCount DESC;

-- Question 5: Tạo view chứa tất cả các câu hỏi do user họ Nguyễn tạo
CREATE VIEW View_NguyenQuestions AS
select q.*
from question q
join answer a on q.QuestionID=a.QuestionID
where a.fullname like 'User%';


