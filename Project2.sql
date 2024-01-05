--creating join table 
select * from Absenteeism_at_work a
left join compensation b
on a.ID=b.ID
left join Reasons r on
a.Reason_for_absence = r.Number

--finding the healthiest employees
select* from Absenteeism_at_work
where Social_drinker = 0 and social_smoker = 0
and Body_mass_index <25 and 
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

-- compensation rate increase for non-smokers/ budget of 983221
select count(*) from Absenteeism_at_work
where social_smoker = 0

--calculations: 686 non-smokers, total hours worked (40hrs/week *52 weeks = 2080 hrs/employee)
--(2080hrs/employee *686 nonsmokers = 1,426,880 hrs)
--budget of 983,221/1,426,,880 = 0.689 increase per hour
-- 1,414.4 increase in pay per year

--optimize the query (stop using wildcard, getting rid of duplicate colmumns) (makes visualization more straight forward)


select 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 then 'Underweight'
	When Body_mass_index between 18.5 and 24.9 then 'Healthy Weight'
	when Body_mass_index between 25 and 30 then 'Overweight'
	when Body_mass_index >30 then 'Obese'
	Else 'Unknown' end as BMI_Category,
Case when Month_of_absence IN (12,1,2) Then 'Winter'
	When Month_of_absence IN (3,4,5) Then 'Spring'
	When Month_of_absence IN (6,7,8) Then 'Summer'
	When Month_of_absence IN (9,10,11) Then 'Fall'
	Else 'unkown' END as Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense, 
Education, 
Son, 
Social_drinker, 
Social_smoker, 
Pet,
Disciplinary_failure, 
Age, 
Work_load_average_day, 
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
on a.ID=b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;
