use sqlproject;

/*question on 2*/
select CustomerId, Surname,sum(Balance) as total_salary from 
spreadsheet
where BankDOJ >= '2019-10-01' and BankDOJ<='2019-12-31'
group by CustomerId, Surname
order by total_salary desc
limit 5;

/* question no 3 */
select avg(num_products) as avg_products_used
from (
select CustomerId , count(distinct NumOfProducts) as num_products
from spreadsheet
where HasCrCard=1
group by CustomerId) as avg_pro;

/* question no 4*/
select Exited, avg(CreditScore) as avg_credit_score
from spreadsheet 
where Exited=0
group by Exited;


select Exited, avg(CreditScore) as avg_credit_score
from spreadsheet 
where Exited=1
group by Exited;

/*question no 6*/

with gender_avg_salary as(
select genderID ,
avg(EstimatedSalary) as avg_salary
from spreadsheet group by GenderID
),
gender_active_accounts as(
select GenderID, count(*) as active_accounts
from spreadsheet where IsActiveMember=1 group by GenderID
)
select gs.GenderID, gs.avg_salary, ga.active_accounts
from gender_avg_salary gs
join gender_active_accounts ga on gs.GenderID=ga.GenderID

/* question on 7*/

WITH credit_score_segments AS (
    SELECT CASE
            WHEN CreditScore >= 800 THEN 'Excellent'
            WHEN CreditScore >= 740  THEN 'Very Good'
            WHEN CreditScore >= 670  THEN 'Good'
            WHEN CreditScore >= 580 THEN 'Fair'
	   ELSE 'poor'
        END AS credit_score_segment,
        Exited
    FROM spreadsheet
)
SELECT
    credit_score_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)/ COUNT(*)) AS exit_rate
FROM
    credit_score_segments
GROUP BY
    credit_score_segment
ORDER BY
    exit_rate DESC
LIMIT 1;


/* question no 8*/
select GeographyID, count(*) as num_active_customers
from spreadsheet where IsActiveMember=1
and Tenure>5
group by GeographyID 
order by num_active_customers desc
limit 1;

/* question no 11*/
select year(BankDOJ) as join_year,
count(CustomerId) as total_customers
from spreadsheet
group by year(BankDOJ)
order by join_year;

/* question no 16*/

select case 
when Age between 18 and 30 then '18-30'
when Age between 31 and 50 then '30-50'
else '50+'
end as age_bracket , avg(Tenure) as avg_tenure
from spreadsheet
where exited=1
group by age_bracket;


/* question no 23*/
select bc.*,
(select Exited from spreadsheet ec where ec.CustomerId
=bc.CustomerId) as ExitCategory
from spreadsheet bc;

/*question no 25*/

SELECT CustomerId, Surname, IsActiveMember
FROM spreadsheet
WHERE Surname LIKE '%on';





