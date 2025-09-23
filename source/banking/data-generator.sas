/* Advanced Banking Practice Datasets for SAS PROC SQL */
/* Focus: Subqueries, ETL Operations, and Multiple Joins */

/* 1. CUSTOMERS Table - Customer information */
data customers;
    input customer_id $ customer_name $ 30. date_opened date9. account_type $ credit_score branch_id city $ 15. state $ phone $ 15. age income;
    format date_opened date9. income dollar12.0;
    datalines;
CUST001 John Smith 01JAN2020 Premium 750 101 New_York NY 555-123-4567 35 85000
CUST002 Sarah Johnson 15MAR2019 Standard 680 102 Los_Angeles CA 555-234-5678 28 62000
CUST003 Michael Brown 22JUN2021 Premium 820 101 New_York NY 555-345-6789 42 125000
CUST004 Emily Davis 08NOV2018 Standard 720 103 Chicago IL 555-456-7890 31 58000
CUST005 Robert Wilson 12SEP2020 Business 780 104 Houston TX 555-567-8901 45 95000
CUST006 Jennifer Garcia 05FEB2019 Premium 690 102 Los_Angeles CA 555-678-9012 29 78000
CUST007 David Martinez 18DEC2021 Standard 640 105 Phoenix AZ 555-789-0123 26 45000
CUST008 Lisa Anderson 30APR2020 Business 760 103 Chicago IL 555-890-1234 38 110000
CUST009 Christopher Lee 14JUL2019 Premium 800 106 Philadelphia PA 555-901-2345 33 135000
CUST010 Amanda White 25AUG2021 Standard 710 101 New_York NY 555-012-3456 27 52000
CUST011 James Taylor 03OCT2018 Business 730 104 Houston TX 555-111-2222 48 88000
CUST012 Michelle Thomas 17JAN2020 Premium 770 107 San_Antonio TX 555-222-3333 36 92000
CUST013 William Jackson 29MAY2019 Standard 650 108 San_Diego CA 555-333-4444 24 41000
CUST014 Jessica Harris 11SEP2021 Business 790 109 Dallas TX 555-444-5555 41 156000
CUST015 Daniel Clark 06DEC2020 Premium 740 110 San_Jose CA 555-555-6666 39 98000
CUST016 Maria Rodriguez 15JAN2019 Standard 665 102 Los_Angeles CA 555-666-7777 32 67000
CUST017 Kevin Wong 22APR2020 Premium 785 110 San_Jose CA 555-777-8888 44 142000
CUST018 Rachel Kim 08SEP2021 Business 755 101 New_York NY 555-888-9999 37 103000
CUST019 Steven Chen 14FEB2020 Standard 695 106 Philadelphia PA 555-999-0000 30 59000
CUST020 Lisa Thompson 03JUN2019 Premium 715 103 Chicago IL 555-000-1111 34 86000
;
run;

/* 2. ACCOUNTS Table - Account details */
data accounts;
    input account_number $ customer_id $ account_type $ 15. balance interest_rate open_date date9. status $ 10. last_activity date9.;
    format balance dollar12.2 open_date last_activity date9. interest_rate percent8.2;
    datalines;
ACC2001 CUST001 Checking 15420.50 0.0025 01JAN2020 Active 28JAN2024
ACC2002 CUST001 Savings 45300.75 0.0150 01JAN2020 Active 24JAN2024
ACC2003 CUST002 Checking 8750.25 0.0025 15MAR2019 Active 29JAN2024
ACC2004 CUST002 Credit_Card -2340.80 0.1899 15MAR2019 Active 25JAN2024
ACC2005 CUST003 Checking 25680.90 0.0025 22JUN2021 Active 30JAN2024
ACC2006 CUST003 Savings 78450.20 0.0175 22JUN2021 Active 30JAN2024
ACC2007 CUST003 Investment 125000.00 0.0650 22JUN2021 Active 22JAN2024
ACC2008 CUST004 Checking 12890.35 0.0025 08NOV2018 Active 22JAN2024
ACC2009 CUST004 Savings 34570.60 0.0150 08NOV2018 Active 20JAN2024
ACC2010 CUST005 Business_Check 67890.45 0.0035 12SEP2020 Active 19JAN2024
ACC2011 CUST005 Business_Save 156780.30 0.0200 12SEP2020 Active 18JAN2024
ACC2012 CUST006 Checking 6780.15 0.0025 05FEB2019 Active 31JAN2024
ACC2013 CUST006 Credit_Card -1850.75 0.1799 05FEB2019 Active 20JAN2024
ACC2014 CUST007 Checking 4560.80 0.0025 18DEC2021 Active 26JAN2024
ACC2015 CUST008 Business_Check 89340.20 0.0035 30APR2020 Active 26JAN2024
ACC2016 CUST008 Business_Save 198760.55 0.0200 30APR2020 Active 19JAN2024
ACC2017 CUST009 Checking 18920.40 0.0025 14JUL2019 Active 21JAN2024
ACC2018 CUST009 Savings 92340.80 0.0175 14JUL2019 Active 21JAN2024
ACC2019 CUST009 Investment 245000.00 0.0680 14JUL2019 Active 27JAN2024
ACC2020 CUST010 Checking 9870.25 0.0025 25AUG2021 Active 23JAN2024
ACC2021 CUST011 Business_Check 123450.70 0.0035 03OCT2018 Active 22JAN2024
ACC2022 CUST012 Checking 16540.30 0.0025 17JAN2020 Active 28JAN2024
ACC2023 CUST012 Savings 67890.45 0.0175 17JAN2020 Active 23JAN2024
ACC2024 CUST013 Checking 3420.60 0.0025 29MAY2019 Dormant 15DEC2023
ACC2025 CUST013 Credit_Card -890.25 0.1999 29MAY2019 Active 15JAN2024
ACC2026 CUST014 Business_Check 234560.80 0.0035 11SEP2021 Active 23JAN2024
ACC2027 CUST015 Checking 21340.95 0.0025 06DEC2020 Active 29JAN2024
ACC2028 CUST015 Investment 187650.40 0.0620 06DEC2020 Active 27JAN2024
ACC2029 CUST016 Checking 12450.30 0.0025 15JAN2019 Active 25JAN2024
ACC2030 CUST016 Savings 28750.85 0.0150 15JAN2019 Active 23JAN2024
ACC2031 CUST017 Checking 34890.60 0.0025 22APR2020 Active 30JAN2024
ACC2032 CUST017 Investment 295000.00 0.0675 22APR2020 Active 28JAN2024
ACC2033 CUST018 Business_Check 145670.25 0.0035 08SEP2021 Active 29JAN2024
ACC2034 CUST019 Checking 8960.45 0.0025 14FEB2020 Active 26JAN2024
ACC2035 CUST020 Checking 19780.30 0.0025 03JUN2019 Active 31JAN2024
ACC2036 CUST020 Savings 56890.70 0.0175 03JUN2019 Active 24JAN2024
;
run;

/* 3. TRANSACTIONS Table - Enhanced transaction history */
data transactions;
    input transaction_id $ account_number $ transaction_date date9. transaction_type $ 15. amount description $ 30. channel $ 10. fee;
    format transaction_date date9. amount fee dollar10.2;
    datalines;
TXN001 ACC2001 15JAN2024 Deposit 2500.00 Salary_Direct_Deposit Online 0.00
TXN002 ACC2001 16JAN2024 Withdrawal -120.50 ATM_Withdrawal ATM 2.50
TXN003 ACC2001 17JAN2024 Payment -89.99 Online_Purchase Online 0.00
TXN004 ACC2003 15JAN2024 Deposit 3200.00 Salary_Direct_Deposit Online 0.00
TXN005 ACC2003 16JAN2024 Payment -450.75 Rent_Payment Online 0.00
TXN006 ACC2005 18JAN2024 Deposit 5000.00 Business_Revenue Wire 15.00
TXN007 ACC2006 18JAN2024 Transfer 1000.00 From_Checking Online 0.00
TXN008 ACC2010 19JAN2024 Deposit 12500.00 Client_Payment Wire 25.00
TXN009 ACC2010 19JAN2024 Payment -3450.80 Vendor_Payment Wire 30.00
TXN010 ACC2012 20JAN2024 Deposit 1800.00 Freelance_Payment Online 0.00
TXN011 ACC2012 20JAN2024 Withdrawal -200.00 ATM_Withdrawal ATM 2.50
TXN012 ACC2017 21JAN2024 Deposit 4200.00 Salary_Direct_Deposit Online 0.00
TXN013 ACC2018 21JAN2024 Interest 145.60 Monthly_Interest System 0.00
TXN014 ACC2019 22JAN2024 Dividend 1875.00 Investment_Dividend System 0.00
TXN015 ACC2021 22JAN2024 Deposit 8750.00 Business_Revenue ACH 5.00
TXN016 ACC2026 23JAN2024 Deposit 15600.00 Contract_Payment Wire 25.00
TXN017 ACC2002 24JAN2024 Interest 67.95 Monthly_Interest System 0.00
TXN018 ACC2004 25JAN2024 Payment -150.00 Credit_Card_Payment Online 0.00
TXN019 ACC2015 26JAN2024 Deposit 6800.00 Service_Revenue ACH 5.00
TXN020 ACC2028 27JAN2024 Dividend 1150.00 Investment_Dividend System 0.00
TXN021 ACC2001 28JAN2024 Payment -1200.00 Mortgage_Payment Online 0.00
TXN022 ACC2003 29JAN2024 Payment -350.25 Utilities Online 0.00
TXN023 ACC2005 30JAN2024 Transfer -2000.00 To_Savings Online 0.00
TXN024 ACC2006 30JAN2024 Transfer 2000.00 From_Checking Online 0.00
TXN025 ACC2012 31JAN2024 Payment -75.50 Phone_Bill Online 0.00
TXN026 ACC2029 25JAN2024 Deposit 2100.00 Salary_Direct_Deposit Online 0.00
TXN027 ACC2031 30JAN2024 Deposit 7500.00 Bonus_Payment Online 0.00
TXN028 ACC2032 28JAN2024 Dividend 2250.00 Investment_Dividend System 0.00
TXN029 ACC2033 29JAN2024 Deposit 18900.00 Project_Payment Wire 30.00
TXN030 ACC2034 26JAN2024 Withdrawal -150.00 ATM_Withdrawal ATM 2.50
TXN031 ACC2035 31JAN2024 Deposit 3800.00 Salary_Direct_Deposit Online 0.00
TXN032 ACC2036 24JAN2024 Interest 89.25 Monthly_Interest System 0.00
TXN033 ACC2014 26JAN2024 Deposit 1950.00 Part_Time_Job Online 0.00
TXN034 ACC2020 23JAN2024 Payment -89.99 Subscription Online 0.00
TXN035 ACC2022 28JAN2024 Deposit 4100.00 Consulting_Fee Online 0.00
;
run;

/* 4. BRANCHES Table - Enhanced branch information */
data branches;
    input branch_id branch_name $ 20. manager_name $ 20. city $ 15. state $ assets dollar15.2 employees region $ 10. opened_date date9.;
    format assets dollar15.2 opened_date date9.;
    datalines;
101 Manhattan_Main John_Anderson New_York NY 450000000.00 45 Northeast 15JAN1985
102 Beverly_Hills Sarah_Martinez Los_Angeles CA 380000000.00 38 West 22MAR1990
103 Loop_Central Michael_Johnson Chicago IL 420000000.00 42 Midwest 08JUL1988
104 Downtown_Houston Lisa_Williams Houston TX 350000000.00 35 South 12OCT1992
105 Central_Phoenix David_Brown Phoenix AZ 280000000.00 28 Southwest 18NOV1995
106 Center_City Jennifer_Davis Philadelphia PA 320000000.00 32 Northeast 25FEB1987
107 Riverwalk Robert_Garcia San_Antonio TX 290000000.00 29 South 14AUG1993
108 Gaslamp_Quarter Amanda_Wilson San_Diego CA 310000000.00 31 West 30SEP1991
109 Uptown_Dallas Christopher_Lee Dallas TX 340000000.00 34 South 17JUN1989
110 Silicon_Valley Emily_Taylor San_Jose CA 520000000.00 52 West 05APR1994
;
run;

/* 5. LOANS Table - Enhanced loan information */
data loans;
    input loan_id $ customer_id $ loan_type $ 15. principal_amount outstanding_balance interest_rate loan_date date9. term_months status $ 10. loan_officer $ 15.;
    format principal_amount outstanding_balance dollar12.2 loan_date date9. interest_rate percent8.2;
    datalines;
LOAN001 CUST001 Mortgage 350000.00 298450.75 0.0325 15FEB2020 360 Active Smith_J
LOAN002 CUST003 Auto 45000.00 32180.90 0.0425 10JUL2021 60 Active Johnson_M
LOAN003 CUST005 Business 500000.00 423680.25 0.0575 20SEP2020 84 Active Williams_L
LOAN004 CUST008 Business 750000.00 685920.40 0.0550 05MAY2020 120 Active Brown_D
LOAN005 CUST009 Mortgage 680000.00 634580.15 0.0295 22AUG2019 360 Active Davis_J
LOAN006 CUST011 Business 300000.00 187650.80 0.0600 10NOV2018 60 Current Garcia_R
LOAN007 CUST012 Auto 28000.00 18920.45 0.0475 25JAN2020 48 Active Wilson_A
LOAN008 CUST014 Business 1200000.00 1156780.90 0.0525 15SEP2021 180 Active Lee_C
LOAN009 CUST004 Personal 15000.00 8750.60 0.0875 12MAR2019 36 Active Taylor_E
LOAN010 CUST006 Auto 32000.00 24560.30 0.0450 18APR2019 60 Active Smith_J
LOAN011 CUST017 Mortgage 580000.00 562340.85 0.0315 12JUN2020 360 Active Johnson_M
LOAN012 CUST018 Business 650000.00 598750.45 0.0565 28NOV2021 96 Active Williams_L
LOAN013 CUST020 Auto 35000.00 28950.70 0.0440 15SEP2019 60 Active Brown_D
;
run;

/* 6. CREDIT_CARDS Table - Enhanced credit card information */
data credit_cards;
    input card_id $ customer_id $ card_type $ 15. credit_limit current_balance interest_rate issue_date date9. status $ 10. payment_due_date date9.;
    format credit_limit current_balance dollar10.2 issue_date payment_due_date date9. interest_rate percent8.2;
    datalines;
CC001 CUST002 Standard 5000.00 2340.80 0.1899 15MAR2019 Active 15FEB2024
CC002 CUST003 Platinum 25000.00 4560.25 0.1599 22JUN2021 Active 22FEB2024
CC003 CUST006 Standard 8000.00 1850.75 0.1799 05FEB2019 Active 05FEB2024
CC004 CUST007 Basic 3000.00 890.50 0.2199 18DEC2021 Active 18FEB2024
CC005 CUST009 Platinum 30000.00 6780.90 0.1499 14JUL2019 Active 14FEB2024
CC006 CUST010 Standard 7500.00 3240.65 0.1899 25AUG2021 Active 25FEB2024
CC007 CUST013 Basic 2500.00 890.25 0.1999 29MAY2019 Active 28FEB2024
CC008 CUST015 Gold 15000.00 5670.40 0.1699 06DEC2020 Active 06FEB2024
CC009 CUST001 Gold 20000.00 8920.15 0.1649 01JAN2020 Active 01FEB2024
CC010 CUST004 Standard 6000.00 2180.30 0.1849 08NOV2018 Active 08FEB2024
CC011 CUST016 Standard 6500.00 2890.45 0.1879 15JAN2019 Active 15FEB2024
CC012 CUST019 Basic 3500.00 1250.80 0.2099 14FEB2020 Active 14FEB2024
;
run;

/* 7. LOAN_PAYMENTS Table - For ETL practice */
data loan_payments;
    input payment_id $ loan_id $ payment_date date9. payment_amount principal_payment interest_payment remaining_balance;
    format payment_date date9. payment_amount principal_payment interest_payment remaining_balance dollar12.2;
    datalines;
PAY001 LOAN001 15JAN2024 1789.95 865.42 924.53 297585.33
PAY002 LOAN001 15DEC2023 1789.95 862.08 927.87 298450.75
PAY003 LOAN002 10JAN2024 890.45 756.32 134.13 31424.58
PAY004 LOAN002 10DEC2023 890.45 752.84 137.61 32180.90
PAY005 LOAN003 20JAN2024 6875.50 4542.25 2333.25 419138.00
PAY006 LOAN004 05JAN2024 8234.75 5123.40 3111.35 680797.00
PAY007 LOAN005 22JAN2024 3456.78 1892.45 1564.33 632687.70
PAY008 LOAN006 10JAN2024 5678.90 4234.56 1444.34 183416.24
PAY009 LOAN007 25JAN2024 634.50 556.78 77.72 18363.67
PAY010 LOAN008 15JAN2024 8967.45 6234.78 2732.67 1150546.12
PAY011 LOAN011 12JAN2024 2950.85 1456.23 1494.62 560884.62
PAY012 LOAN012 28JAN2024 7845.60 5123.45 2722.15 593626.00
PAY013 LOAN013 15JAN2024 678.95 589.45 89.50 28361.25
;
run;

/* 8. EMPLOYEE Table - For practice with HR data */
data employees;
    input emp_id $ emp_name $ 25. position $ 20. branch_id salary hire_date date9. manager_id $ department $ 15.;
    format salary dollar10.0 hire_date date9.;
    datalines;
EMP001 John Anderson Branch_Manager 101 125000 15JAN1995 . Management
EMP002 Sarah Martinez Branch_Manager 102 120000 22MAR1998 . Management
EMP003 Michael Johnson Branch_Manager 103 123000 08JUL1996 . Management
EMP004 Lisa Williams Branch_Manager 104 118000 12OCT2000 . Management
EMP005 David Brown Branch_Manager 105 115000 18NOV2003 . Management
EMP006 Jennifer Davis Branch_Manager 106 121000 25FEB1999 . Management
EMP007 Robert Garcia Branch_Manager 107 117000 14AUG2001 . Management
EMP008 Amanda Wilson Branch_Manager 108 119000 30SEP1999 . Management
EMP009 Christopher Lee Branch_Manager 109 122000 17JUN1997 . Management
EMP010 Emily Taylor Branch_Manager 110 135000 05APR2002 . Management
EMP011 James Smith Loan_Officer 101 75000 10MAR2010 EMP001 Lending
EMP012 Mary Johnson Loan_Officer 102 73000 15JUN2012 EMP002 Lending
EMP013 Linda Williams Loan_Officer 103 74000 20SEP2011 EMP003 Lending
EMP014 David Brown Loan_Officer 104 72000 08DEC2013 EMP004 Lending
EMP015 Jennifer Davis Loan_Officer 105 71000 12FEB2014 EMP005 Lending
EMP016 Robert Garcia Loan_Officer 106 73500 25MAY2012 EMP006 Lending
EMP017 Amanda Wilson Loan_Officer 107 72500 18AUG2013 EMP007 Lending
EMP018 Christopher Lee Loan_Officer 108 74500 30NOV2011 EMP008 Lending
EMP019 Emily Taylor Loan_Officer 109 75500 14APR2010 EMP009 Lending
EMP020 Michael Brown Loan_Officer 110 78000 22JUL2009 EMP010 Lending
EMP021 Susan Davis Teller 101 45000 15JAN2018 EMP001 Operations
EMP022 Kevin Wong Teller 101 46000 20MAR2017 EMP001 Operations
EMP023 Rachel Kim Teller 102 44500 25JUN2019 EMP002 Operations
EMP024 Steven Chen Teller 103 45500 10SEP2018 EMP003 Operations
EMP025 Lisa Thompson Customer_Service 104 48000 12NOV2016 EMP004 Operations
;
run;

/* 9. ACCOUNT_SUMMARY Table - Monthly aggregated data for ETL practice */
data account_summary_raw;
    input account_number $ summary_month date9. opening_balance closing_balance total_deposits total_withdrawals num_transactions avg_daily_balance;
    format summary_month date9. opening_balance closing_balance total_deposits total_withdrawals avg_daily_balance dollar12.2;
    datalines;
ACC2001 01JAN2024 14320.50 15420.50 2500.00 1410.49 4 14850.25
ACC2002 01JAN2024 45232.80 45300.75 0.00 0.00 1 45266.78
ACC2003 01JAN2024 6100.00 8750.25 3200.00 801.00 3 7425.13
ACC2005 01JAN2024 22680.90 25680.90 5000.00 2000.00 3 24180.90
ACC2010 01JAN2024 58840.25 67890.45 12500.00 3450.80 2 63365.35
ACC2012 01JAN2024 5055.65 6780.15 1800.00 275.50 3 5917.90
ACC2017 01JAN2024 14720.40 18920.40 4200.00 0.00 1 16820.40
ACC2021 01JAN2024 114700.70 123450.70 8750.00 0.00 1 119075.70
ACC2029 01JAN2024 10350.30 12450.30 2100.00 0.00 1 11400.30
ACC2031 01JAN2024 27390.60 34890.60 7500.00 0.00 1 31140.60
ACC2033 01JAN2024 126770.25 145670.25 18900.00 0.00 1 136220.25
ACC2034 01JAN2024 9113.95 8960.45 0.00 152.50 1 9037.20
ACC2035 01JAN2024 15980.30 19780.30 3800.00 0.00 1 17880.30
;
run;

/****************************/
/* PRACTICE EXAMPLES        */
/****************************/

title "PRACTICE EXERCISES FOR SUBQUERIES, ETL, AND MULTIPLE JOINS";

/* ===== SUBQUERY EXAMPLES ===== */

title2 "1. SUBQUERY EXAMPLES";

/* Example 1: Find customers with above-average total account balances */
proc sql;
title3 "Customers with Above-Average Total Balances (Correlated Subquery)";
   select c.customer_name, c.city, sum(a.balance) as total_balance format=dollar12.2
   from customers c
   inner join accounts a on c.customer_id = a.customer_id
   group by c.customer_id, c.customer_name, c.city
   having sum(a.balance) > (
      select avg(account_total) 
      from (
         select sum(balance) as account_total
         from accounts
         where status = 'Active'
         group by customer_id
      )
   );
quit;

/* Example 2: Find customers who have both loans and credit cards */
proc sql;
title3 "Customers with Both Loans and Credit Cards (EXISTS Subquery)";
   select c.customer_name, c.credit_score, c.income format=dollar10.0
   from customers c
   where exists (select 1 from loans l where l.customer_id = c.customer_id)
     and exists (select 1 from credit_cards cc where cc.customer_id = c.customer_id);
quit;

/* Example 3: Find branches with highest performing loan officers */
proc sql;
title3 "Branches with Top-Performing Loan Officers (Nested Subquery)";
   select b.branch_name, b.city, count(*) as num_top_officers
   from branches b
   inner join employees e on b.branch_id = e.branch_id
   where e.position = 'Loan_Officer' 
     and e.emp_id in (
        select loan_officer
        from loans
        group by loan_officer
        having count(*) > (
           select avg(loan_count)
           from (
              select count(*) as loan_count
              from loans
              group by loan_officer
           )
        )
     )
   group by b.branch_id, b.branch_name, b.city;
quit;

/* ===== MULTIPLE JOINS EXAMPLES ===== */

title2 "2. MULTIPLE JOINS EXAMPLES";

/* Example 1: Customer 360 View - 5 table join */
proc sql;
title3 "Customer 360 Degree View (5-Table Join)";
   select c.customer_name,
          c.city,
          c.credit_score,
          b.branch_name,
          a.account_type,
          a.balance format=dollar12.2,
          t.transaction_date,
          t.amount format=dollar10.2,
          t.description
   from customers c
   inner join branches b on c.branch_id = b.branch_id
   inner join accounts a on c.customer_id = a.customer_id
   inner join transactions t on a.account_number = t.account_number
   inner join employees e on b.branch_id = e.branch_id
   where e.position = 'Branch_Manager'
     and t.transaction_date >= '15JAN2024'd
     and a.balance > 10000
   order by c.customer_name, t.transaction_date;
quit;

/* Example 2: Loan Portfolio Analysis with Multiple Joins */
proc sql;
title3 "Comprehensive Loan Portfolio Analysis (6-Table Join)";
   select c.customer_name,
          c.income format=dollar10.0,
          c.credit_score,
          b.branch_name,
          b.region,
          l.loan_type,
          l.principal_amount format=dollar12.2,
          l.outstanding_balance format=dollar12.2,
          lp.payment_amount format=dollar10.2 as last_payment,
          lp.payment_date as last_payment_date format=date9.,
          e.emp_name as loan_officer_name
   from customers c
   inner join branches b on c.branch_id = b.branch_id
   inner join loans l on c.customer_id = l.customer_id
   left join loan_payments lp on l.loan_id = lp.loan_id
   inner join employees e on b.branch_id = e.branch_id and l.loan_officer = e.emp_id
   inner join (
      select loan_id, max(payment_date) as max_payment_date
      from loan_payments
      group by loan_id
   ) latest_payment on l.loan_id = latest_payment.loan_id 
                    and lp.payment_date = latest_payment.max_payment_date
   where l.status = 'Active'
   order by l.outstanding_balance desc;
quit;

/* Example 3: Branch Performance with Employee Metrics */
proc sql;
title3 "Branch Performance with Employee Analysis (4-Table Join)";
   select b.branch_name,
          b.region,
          b.assets format=dollar15.0,
          count(distinct c.customer_id) as total_customers,
          sum(a.balance) format=dollar15.2 as total_deposits,
          count(distinct e.emp_id) as total_employees,
          avg(e.salary) format=dollar10.0 as avg_employee_salary,
          calculated total_deposits / calculated total_employees as deposits_per_employee format=dollar12.0
   from branches b
   left join customers c on b.branch_id = c.branch_id
   left join accounts a on c.customer_id = a.customer_id and a.status = 'Active'
   inner join employees e on b.branch_id = e.branch_id
   group by b.branch_id, b.branch_name, b.region, b.assets
   order by calculated deposits_per_employee desc;
quit;

/* ===== ETL EXAMPLES ===== */

title2 "3. ETL OPERATION EXAMPLES";

/* ETL Example 1: Create Customer Risk Profile Table */
proc sql;
title3 "ETL: Creating Customer Risk Profile Table";
   create table customer_risk_profile as
   select c.customer_id,
          c.customer_name,
          c.age,
          c.income,
          c.credit_score,
          
          /* Calculate total account balances */
          coalesce(sum(case when a.account_type in ('Checking', 'Savings', 'Business_Check', 'Business_Save') 
                           then a.balance else 0 end), 0) as liquid_assets format=dollar12.2,
          
          /* Calculate investment balances */
          coalesce(sum(case when a.account_type = 'Investment' 
                           then a.balance else 0 end), 0) as investment_assets format=dollar12.2,
          
          /* Calculate total debt */
          coalesce(sum(case when a.account_type = 'Credit_Card' and a.balance < 0 
                           then abs(a.balance) else 0 end), 0) + 
          coalesce(sum(l.outstanding_balance), 0) as total_debt format=dollar12.2,
          
          /* Calculate debt-to-income ratio */
          case when c.income > 0 then
             (coalesce(sum(case when a.account_type = 'Credit_Card' and a.balance < 0 
                              then abs(a.balance) else 0 end), 0) + 
              coalesce(sum(l.outstanding_balance), 0)) / c.income
          else 0 end as debt_to_income_ratio format=percent8.2,
          
          /* Risk category */
          case 
             when c.credit_score >= 800 then 'Low Risk'
             when c.credit_score >= 700 then 'Medium Risk'  
             when c.credit_score >= 600 then 'High Risk'
             else 'Very High Risk'
          end as risk_category,
          
          /* Customer value tier */
          case
             when calculated liquid_assets + calculated investment_assets >= 500000 then 'Platinum'
             when calculated liquid_assets + calculated investment_assets >= 100000 then 'Gold'
             when calculated liquid_assets + calculated investment_assets >= 25000 then 'Silver'
             else 'Bronze'
          end as customer_tier,
          
          today() as analysis_date format=date9.
          
   from customers c
   left join accounts a on c.customer_id = a.customer_id and a.status = 'Active'
   left join loans l on c.customer_id = l.customer_id and l.status in ('Active', 'Current')
   group by c.customer_id, c.customer_name, c.age, c.income, c.credit_score;
quit;

/* ETL Example 2: Monthly Account Summary Transformation */
proc sql;
title3 "ETL: Transform Raw Account Data to Monthly Summary";
   create table monthly_account_metrics as
   select a.customer_id,
          a.account_number,
          a.account_type,
          
          /* Calculate monthly metrics */
          year(ars.summary_month) as summary_year,
          month(ars.summary_month) as summary_month,
          ars.opening_balance,
          ars.closing_balance,
          ars.total_deposits,
          ars.total_withdrawals,
          ars.num_transactions,
          
          /* Calculate derived metrics */
          ars.closing_balance - ars.opening_balance as net_change format=dollar12.2,
          case when ars.opening_balance > 0 then
             (ars.closing_balance - ars.opening_balance) / ars.opening_balance
          else 0 end as growth_rate format=percent8.2,
          
          /* Transaction intensity */
          case when ars.closing_balance > 0 then
             ars.num_transactions / (ars.closing_balance / 1000)
          else 0 end as transaction_intensity format=8.2,
          
          /* Account activity classification */
          case 
             when ars.num_transactions = 0 then 'Dormant'
             when ars.num_transactions <= 2 then 'Low Activity'
             when ars.num_transactions <= 5 then 'Medium Activity'
             else 'High Activity'
          end as activity_level,
          
          /* Fee potential */
          case when a.account_type in ('Checking', 'Business_Check') then
             ars.num_transactions * 0.50
          else 0 end as potential_fee_income format=dollar8.2
          
   from accounts a
   inner join account_summary_raw ars on a.account_number = ars.account_number
   where a.status = 'Active';
quit;

/* ETL Example 3: Branch Performance Dashboard Data */
proc sql;
title3 "ETL: Creating Branch Performance Dashboard";
   create table branch_dashboard as
   select b.branch_id,
          b.branch_name,
          b.city,
          b.state,
          b.region,
          b.manager_name,
          
          /* Customer metrics */
          count(distinct c.customer_id) as total_customers,
          count(distinct case when c.account_type = 'Premium' then c.customer_id end) as premium_customers,
          
          /* Account metrics */
          count(distinct a.account_number) as total_accounts,
          sum(case when a.status = 'Active' then a.balance else 0 end) as total_deposits format=dollar15.2,
          avg(case when a.status = 'Active' then a.balance end) as avg_account_balance format=dollar12.2,
          
          /* Loan metrics */
          count(distinct l.loan_id) as total_loans,
          sum(l.outstanding_balance) as total_loan_balance format=dollar15.2,
          avg(l.interest_rate) as avg_loan_rate format=percent8.3,
          
          /* Employee metrics */
          count(distinct e.emp_id) as total_employees,
          sum(e.salary) as total_payroll format=dollar12.0,
          avg(e.salary) as avg_salary format=dollar10.0,
          
          /* Performance ratios */
          calculated total_deposits / calculated total_employees as deposits_per_employee format=dollar12.0,
          calculated total_customers / calculated total_employees as customers_per_employee format=8.1,
          calculated total_loan_balance / calculated total_deposits as loan_to_deposit_ratio format=percent8.2,
          
          /* Branch efficiency score (composite metric) */
          (calculated deposits_per_employee / 100000 * 0.4) +
          (calculated customers_per_employee / 10 * 0.3) +
          (calculated total_customers / 100 * 0.3) as efficiency_score format=8.2,
          
          today() as report_date format=date9.
          
   from branches b
   left join customers c on b.branch_id = c.branch_id
   left join accounts a on c.customer_id = a.customer_id
   left join loans l on c.customer_id = l.customer_id and l.status in ('Active', 'Current')
   inner join employees e on b.branch_id = e.branch_id
   group by b.branch_id, b.branch_name, b.city, b.state, b.region, b.manager_name
   order by calculated efficiency_score desc;
quit;

/* Advanced Subquery Example: Window Functions Simulation */
proc sql;
title3 "Advanced: Customer Ranking Within Branch (Subquery Alternative to Window Functions)";
   create table customer_rankings as
   select c.customer_id,
          c.customer_name,
          c.city,
          b.branch_name,
          sum(a.balance) as total_balance format=dollar12.2,
          
          /* Rank within branch using correlated subquery */
          (select count(*) + 1
           from customers c2
           inner join accounts a2 on c2.customer_id = a2.customer_id
           inner join branches b2 on c2.branch_id = b2.branch_id
           where b2.branch_id = b.branch_id
             and a2.status = 'Active'
           group by c2.customer_id
           having sum(a2.balance) > calculated total_balance
          ) as branch_rank,
          
          /* Calculate percentile within branch */
          case 
             when calculated branch_rank <= 
                (select count(distinct c3.customer_id) * 0.25
                 from customers c3 
                 inner join accounts a3 on c3.customer_id = a3.customer_id
                 where c3.branch_id = c.branch_id and a3.status = 'Active')
             then 'Top 25%'
             when calculated branch_rank <= 
                (select count(distinct c3.customer_id) * 0.50
                 from customers c3 
                 inner join accounts a3 on c3.customer_id = a3.customer_id
                 where c3.branch_id = c.branch_id and a3.status = 'Active')
             then 'Top 50%'
             else 'Bottom 50%'
          end as performance_quartile
          
   from customers c
   inner join branches b on c.branch_id = b.branch_id
   inner join accounts a on c.customer_id = a.customer_id
   where a.status = 'Active'
   group by c.customer_id, c.customer_name, c.city, b.branch_name, b.branch_id
   order by b.branch_name, calculated branch_rank;
quit;

/* Complex ETL with Data Quality Checks */
proc sql;
title3 "ETL with Data Quality: Customer Data Cleansing and Standardization";
   create table customers_clean as
   select customer_id,
          
          /* Clean customer name - proper case */
          propcase(strip(customer_name)) as customer_name_clean,
          
          /* Standardize phone numbers */
          case 
             when length(compress(phone, '-')) = 10 then
                cats(substr(compress(phone, '-'), 1, 3), '-',
                     substr(compress(phone, '-'), 4, 3), '-',
                     substr(compress(phone, '-'), 7, 4))
             else phone
          end as phone_standardized,
          
          /* Age validation and categorization */
          case 
             when age < 18 or age > 100 then .
             else age
          end as age_validated,
          
          case 
             when calculated age_validated < 25 then 'Gen Z'
             when calculated age_validated < 40 then 'Millennial'
             when calculated age_validated < 55 then 'Gen X'
             else 'Baby Boomer'
          end as generation,
          
          /* Income validation */
          case 
             when income <= 0 or income > 1000000 then .
             else income
          end as income_validated,
          
          /* Credit score validation */
          case 
             when credit_score < 300 or credit_score > 850 then .
             else credit_score
          end as credit_score_validated,
          
          /* Data quality flags */
          case when age < 18 or age > 100 then 'Y' else 'N' end as age_flag,
          case when income <= 0 or income > 1000000 then 'Y' else 'N' end as income_flag,
          case when credit_score < 300 or credit_score > 850 then 'Y' else 'N' end as credit_flag,
          
          /* Record completeness score */
          (case when age is not missing then 1 else 0 end +
           case when income is not missing then 1 else 0 end +
           case when credit_score is not missing then 1 else 0 end +
           case when phone is not missing then 1 else 0 end) / 4 as completeness_score format=percent8.1,
           
          date_opened,
          account_type,
          branch_id,
          city,
          state,
          today() as cleansing_date format=date9.
          
   from customers;
quit;

/* Print sample results */
title3 "Sample: Customer Risk Profiles";
proc print data=customer_risk_profile(obs=10) noobs;
   var customer_name risk_category customer_tier liquid_assets investment_assets total_debt debt_to_income_ratio;
run;

title3 "Sample: Branch Performance Dashboard";
proc print data=branch_dashboard(obs=5) noobs;
   var branch_name region total_customers total_deposits efficiency_score;
run;

title3 "Sample: Customer Rankings Within Branch";
proc print data=customer_rankings(obs=10) noobs;
   var customer_name branch_name total_balance branch_rank performance_quartile;
run;

/****************************/
/* PRACTICE CHALLENGES      */
/****************************/

title "PRACTICE CHALLENGES - Try These!";

/* 
CHALLENGE 1 (Subqueries): 
Find customers who have transaction amounts in the top 10% of all transactions,
but whose average account balance is below the median account balance.

CHALLENGE 2 (Multiple Joins):
Create a report showing customer name, all their account types, 
total loan amounts, credit card utilization, branch performance rank,
and their loan officer's name (if they have loans).

CHALLENGE 3 (ETL):
Create a data mart table that combines customer demographics, 
account summaries, transaction patterns, and creates a customer 
lifetime value score based on balances, transaction frequency,
loan relationships, and tenure.

CHALLENGE 4 (Advanced Subqueries):
Find branches where the average customer balance is higher than 
the average customer balance of all branches in the same region,
and list the top 3 customers in each of these branches.

CHALLENGE 5 (Complex ETL):
Create a monthly cohort analysis table showing customer acquisition 
by month, their average balances over time, retention rates,
and product adoption patterns.
*/

proc sql;
   describe table customers;
   describe table accounts; 
   describe table transactions;
   describe table branches;
   describe table loans;
   describe table credit_cards;
   describe table loan_payments;
   describe table employees;
quit;