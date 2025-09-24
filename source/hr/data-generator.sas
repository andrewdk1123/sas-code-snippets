/* Create sample database for SAS PROC SQL practice */

/* Create DEPARTMENTS table */
data departments;
    input dept_id dept_name $ location $ budget;
    datalines;
101 Sales Chicago 500000
102 Marketing NewYork 350000
103 IT Houston 750000
104 HR Atlanta 200000
105 Finance Boston 400000
;
run;

/* Create EMPLOYEES table */
data employees;
    input emp_id first_name $ last_name $ dept_id salary hire_date :date9. quit_date :date9.;
    format hire_date date9. quit_date date9.;
    datalines;
1001 John Smith 101 65000 15JAN2020 .
1002 Mary Johnson 102 58000 22MAR2021 15AUG2023
1003 James Williams 101 72000 10JUL2019 .
1004 Robert Brown 103 85000 05NOV2020 .
1005 Patricia Davis 104 52000 18SEP2021 22JUN2023
1006 Michael Miller 103 78000 12FEB2020 .
1007 Linda Wilson 102 61000 30APR2021 .
1008 William Moore 105 69000 25AUG2019 10NOV2022
1009 Elizabeth Taylor 101 71000 14DEC2020 .
1010 David Anderson 103 82000 07JUN2021 .
;
run;

/* Display the tables */
proc print data=departments;
    title "DEPARTMENTS Table";
run;

proc print data=employees;
    title "EMPLOYEES Table";
run;

/* ===== PRACTICE EXERCISES ===== */

/* Exercise 1: Basic SELECT */
proc sql;
    title "All Employees";
    select * from employees;
quit;

/* Exercise 2: SELECT with WHERE clause */
proc sql;
    title "Employees in IT Department (dept_id = 103)";
    select emp_id, first_name, last_name, salary 
    from employees 
    where dept_id = 103;
quit;

/* Exercise 3: INNER JOIN */
proc sql;
    title "Employee Names with Department Names";
    select e.emp_id, e.first_name, e.last_name, d.dept_name, e.salary
    from employees e
    inner join departments d
    on e.dept_id = d.dept_id;
quit;

/* Exercise 4: Aggregate functions */
proc sql;
    title "Average Salary by Department";
    select d.dept_name, 
           count(*) as num_employees,
           avg(e.salary) as avg_salary format=dollar10.
    from employees e
    inner join departments d
    on e.dept_id = d.dept_id
    group by d.dept_name;
quit;

/* Exercise 5: LEFT JOIN to show all departments */
proc sql;
    title "All Departments with Employee Count";
    select d.dept_name, 
           d.location,
           count(e.emp_id) as num_employees
    from departments d
    left join employees e
    on d.dept_id = e.dept_id
    group by d.dept_name, d.location;
quit;

/* Exercise 6: Subquery example */
proc sql;
    title "Employees earning above average salary";
    select first_name, last_name, salary format=dollar10.
    from employees
    where salary > (select avg(salary) from employees);
quit;

/* Exercise 7: CASE statement */
proc sql;
    title "Employee Salary Categories";
    select first_name, last_name, 
           salary format=dollar10.,
           case 
               when salary >= 80000 then 'High'
               when salary >= 65000 then 'Medium'
               else 'Low'
           end as salary_category
    from employees
    order by salary desc;
quit;