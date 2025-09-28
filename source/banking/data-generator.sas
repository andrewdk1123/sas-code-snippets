/* ========================================
   BANKING DATABASE SCHEMA FOR SAS PRACTICE
   ======================================== */

/* 1. CUSTOMERS Table */
data customers;
    input customer_id $ customer_name &$30. 
          @26 date_of_birth date9. address &$20. 
          @55 phone $8. city :$10. state $ zip_code $ customer_type $3. 
          @94 account_open_date date9. credit_score;
    format date_of_birth account_open_date date9.;
    datalines;
C001 John Smith          15JAN1985 123 Main St        555-0101 Boston    MA 02101 INDIVIDUAL 01JUN2020 720
C002 Sarah Johnson       22MAR1990 456 Oak Ave        555-0102 Boston    MA 02102 INDIVIDUAL 15JUL2019 680
C003 Mike Brown          08SEP1978 789 Pine St        555-0103 Cambridge MA 02139 INDIVIDUAL 20FEB2021 750
C004 Lisa Davis          14NOV1988 321 Elm Dr         555-0104 Boston    MA 02101 INDIVIDUAL 10APR2018 695
C005 Tech Solutions LLC  .         567 Business Blvd  555-0105 Boston    MA 02108 BUSINESS   25SEP2020 .
C006 Robert Wilson       05DEC1975 890 Maple Ln       555-0106 Quincy    MA 02169 INDIVIDUAL 30JAN2019 710
C007 Global Imports Inc  .         123 Commerce St    555-0107 Cambridge MA 02142 BUSINESS   18MAR2021 .
C008 Jennifer Lee        18JUL1992 654 Cedar Rd       555-0108 Boston    MA 02115 INDIVIDUAL 12NOV2020 665
C009 David Martinez      27APR1983 987 Birch Way      555-0109 Newton    MA 02458 INDIVIDUAL 08AUG2018 735
C010 Mary Thompson       13FEB1987 147 Spruce St      555-0110 Boston    MA 02116 INDIVIDUAL 22OCT2019 690
;
run;

/* 2. ACCOUNTS Table */
data accounts;
    input account_id $ customer_id $ account_type :$12. 
          account_status $ balance interest_rate 
          @47 open_date date9. +1 last_activity_date date9. +1 branch_id $;
    format balance dollar12.2 interest_rate percent8.2 open_date last_activity_date date9.;
    datalines;
A001 C001 CHECKING     ACTIVE 2500.75 0.01    01JUN2020 25SEP2023 BR001
A002 C001 SAVINGS      ACTIVE 15000.00 0.025  01JUN2020 20SEP2023 BR001
A003 C002 CHECKING     ACTIVE 3200.50 0.01    15JUL2019 28SEP2023 BR002
A004 C002 SAVINGS      ACTIVE 8500.25 0.025   15JUL2019 15SEP2023 BR002
A005 C003 CHECKING     ACTIVE 1750.00 0.01    20FEB2021 27SEP2023 BR001
A006 C003 CREDIT_CARD  ACTIVE -850.75 0.189   20FEB2021 26SEP2023 BR001
A007 C004 SAVINGS      ACTIVE 22000.00 0.03   10APR2018 24SEP2023 BR003
A008 C004 CHECKING     CLOSED 0.00 0.01       10APR2018 15JUN2023 BR003
A009 C005 BUSINESS_CHK ACTIVE 45000.00 0.015  25SEP2020 28SEP2023 BR001
A010 C005 BUSINESS_SAV ACTIVE 125000.00 0.035 25SEP2020 25SEP2023 BR001
A011 C006 CHECKING     ACTIVE 4200.80 0.01    30JAN2019 26SEP2023 BR002
A012 C006 SAVINGS      ACTIVE 12500.00 0.025  30JAN2019 22SEP2023 BR002
A013 C007 BUSINESS_CHK ACTIVE 78000.00 0.015  18MAR2021 27SEP2023 BR003
A014 C008 CHECKING     ACTIVE 950.25 0.01     12NOV2020 28SEP2023 BR001
A015 C008 CREDIT_CARD  ACTIVE -1250.00 0.199  12NOV2020 25SEP2023 BR001
A016 C009 SAVINGS      ACTIVE 18750.00 0.03   08AUG2018 23SEP2023 BR002
A017 C009 CHECKING     ACTIVE 2800.50 0.01    08AUG2018 28SEP2023 BR002
A018 C010 CHECKING     ACTIVE 1650.00 0.01    22OCT2019 27SEP2023 BR003
A019 C010 SAVINGS      ACTIVE 7200.75 0.025   22OCT2019 20SEP2023 BR003
A020 C003 MONEY_MARKET ACTIVE 50000.00 0.04   15MAY2022 24SEP2023 BR001
;
run;

/* 3. TRANSACTIONS Table */
data transactions;
    input transaction_id $ account_id $ transaction_date date9. 
          transaction_type :$8. amount description &$40. 
          @63 merchant :$25. category :$15. branch_id $;
    format transaction_date date9. amount dollar10.2;
    datalines;
T001 A001 25SEP2023 DEBIT -45.50      Gas Station Purchase    Shell AUTOMOTIVE BR001
T002 A001 24SEP2023 CREDIT 2500.00    Salary Deposit          ABC_Company INCOME BR001
T003 A002 24SEP2023 CREDIT 25.00      Interest Payment        Bank INTEREST BR001
T004 A003 28SEP2023 DEBIT -125.00     Grocery Store           Stop_and_Shop GROCERY BR002
T005 A003 27SEP2023 DEBIT -75.25      Restaurant Dinner       Italian_Bistro DINING BR002
T006 A004 26SEP2023 TRANSFER 500.00   Transfer from Checking  Internal TRANSFER BR002
T007 A005 27SEP2023 DEBIT -89.99      Online Purchase         Amazon SHOPPING BR001
T008 A006 26SEP2023 PAYMENT 200.00    Credit Card Payment     Internal PAYMENT BR001
T009 A007 24SEP2023 CREDIT 45.00      Interest Payment        Bank INTEREST BR003
T010 A009 28SEP2023 DEBIT -5500.00    Vendor Payment          XYZ_Supplies BUSINESS BR001
T011 A011 26SEP2023 DEBIT -250.00     Rent Payment            Landlord_Corp HOUSING BR002
T012 A013 27SEP2023 CREDIT 12000.00   Customer Payment        ABC_Client BUSINESS BR003
T013 A014 28SEP2023 DEBIT -35.00      ATM Withdrawal          ATM_Network ATM BR001
T014 A015 25SEP2023 PURCHASE -175.00  Department Store        Macys SHOPPING BR001
T015 A016 23SEP2023 CREDIT 38.50      Interest Payment        Bank INTEREST BR002
T016 A017 28SEP2023 DEBIT -95.00      Utility Bill            Electric_Co UTILITIES BR002
T017 A018 27SEP2023 DEBIT -55.75      Gas Station Purchase    Mobil AUTOMOTIVE BR003
T018 A019 26SEP2023 TRANSFER 300.00   Transfer from Checking  Internal TRANSFER BR003
T019 A020 24SEP2023 CREDIT 125.00     Interest Payment        Bank INTEREST BR001
T020 A001 23SEP2023 DEBIT -12.50      Coffee Shop             Starbucks DINING BR001
T021 A003 25SEP2023 DEBIT -200.00     Insurance Payment       State_Farm INSURANCE BR002
T022 A005 26SEP2023 CREDIT 1800.00    Freelance Payment       Client_ABC INCOME BR001
T023 A011 25SEP2023 DEBIT -45.00      Pharmacy                CVS HEALTHCARE BR002
T024 A009 27SEP2023 CREDIT 8500.00    Invoice Payment         Customer_XYZ BUSINESS BR001
T025 A014 26SEP2023 DEBIT -25.00      Subscription            Netflix ENTERTAINMENT BR001
;
run;

/* 4. BRANCHES Table */
data branches;
    input branch_id $ branch_name &$20. 
          @25 address &$40. city :$10. state $ zip_code $ manager_name &$20. 
          @78 phone $12. +1 open_date date9.;
    format open_date date9.;
    datalines;
BR001 Downtown Boston   100 Federal St   Boston    MA 02110 James Wilson     617-555-0001 01JAN2010
BR002 Cambridge Square  200 Harvard Ave  Cambridge MA 02138 Maria Rodriguez  617-555-0002 15MAR2012
BR003 Back Bay          300 Newbury St   Boston    MA 02116 Thomas Anderson  617-555-0003 10JUN2015
BR004 Quincy Center     400 Hancock St   Quincy    MA 02171 Linda Chang      617-555-0004 22SEP2018
;
run;

/* 5. LOANS Table */
data loans;
    input loan_id $ customer_id $ loan_type :$8. 
          principal_amount current_balance interest_rate 
          loan_date date9. +1 maturity_date date9. 
          payment_amount monthly_payment_date 
          loan_status :$8. branch_id $;
    format principal_amount current_balance payment_amount dollar12.2 
           interest_rate percent8.2 loan_date maturity_date date9.;
    datalines;
L001 C001 PERSONAL 15000.00 12500.75 0.085 15JUL2022 15JUL2027 285.50 15 ACTIVE BR001
L002 C003 MORTGAGE 350000.00 342500.00 0.045 01MAR2021 01MAR2051 1875.25 1 ACTIVE BR001
L003 C004 AUTO 25000.00 18750.50 0.055 10JUN2020 10JUN2025 475.85 10 ACTIVE BR003
L004 C006 PERSONAL 8000.00 6200.25 0.095 20SEP2019 20SEP2024 165.75 20 ACTIVE BR002
L005 C007 BUSINESS 500000.00 465000.00 0.065 05NOV2021 05NOV2031 5250.00 5 ACTIVE BR003
L006 C009 MORTGAGE 280000.00 275500.00 0.04 12DEC2018 12DEC2048 1485.75 12 ACTIVE BR002
L007 C002 AUTO 18000.00 8500.25 0.06 25APR2021 25APR2026 375.50 25 ACTIVE BR002
L008 C010 PERSONAL 5000.00 0.00 0.08 15FEB2020 15FEB2025 0.00 15 PAID_OFF BR003
L009 C005 BUSINESS 750000.00 725000.00 0.055 30AUG2020 30AUG2030 7850.00 30 ACTIVE BR001
L010 C008 PERSONAL 3000.00 2750.50 0.105 18JAN2023 18JAN2026 95.25 18 ACTIVE BR001
;
run;

/* 6. EMPLOYEE Table (for branch operations) */
data employees;
    input employee_id $ first_name :$15. last_name :$15. position :$20. 
          @41 branch_id $ salary hire_date date9. 
          manager_id $ department :$15.;
    format salary dollar10.2 hire_date date9.;
    datalines;
E001 James Wilson     Branch_Manager    BR001 85000.00 01JAN2010 . MANAGEMENT
E002 Maria Rodriguez  Branch_Manager    BR002 82000.00 15MAR2012 . MANAGEMENT
E003 Thomas Anderson  Branch_Manager    BR003 87000.00 10JUN2015 . MANAGEMENT
E004 Linda Chang      Branch_Manager    BR004 80000.00 22SEP2018 . MANAGEMENT
E005 Susan Miller     Teller            BR001 45000.00 15MAY2018 E001 OPERATIONS
E006 Robert Taylor    Loan_Officer      BR001 65000.00 20AUG2017 E001 LENDING
E007 Jennifer White   Teller            BR002 42000.00 10OCT2019 E002 OPERATIONS
E008 Michael Davis    Customer_Service  BR002 48000.00 05FEB2020 E002 OPERATIONS
E009 Lisa Brown       Loan_Officer      BR003 68000.00 12JUL2016 E003 LENDING
E010 David Wilson     Teller            BR003 44000.00 25NOV2021 E003 OPERATIONS
;
run;

/* ========================================
   PRACTICE SCENARIOS AND SAMPLE QUERIES
   ======================================== */

/* EXAMPLE 1: Set Operations - Find customers with both checking and savings accounts */
proc sql;
    title "Customers with Both Checking and Savings Accounts (INTERSECT)";
    select distinct customer_id, customer_name
    from customers
    where customer_id in (
        select customer_id from accounts where account_type = 'CHECKING'
        intersect
        select customer_id from accounts where account_type = 'SAVINGS'
    );
quit;

/* EXAMPLE 2: Subquery - Find customers with above-average account balances */
proc sql;
    title "Customers with Above-Average Account Balances";
    select c.customer_name, a.account_type, a.balance
    from customers c, accounts a
    where c.customer_id = a.customer_id
    and a.balance > (select avg(balance) from accounts where balance > 0);
quit;

/* EXAMPLE 3: CTE - Monthly transaction summary with running totals */
proc sql;
    title "Monthly Transaction Summary with Running Totals";
    with monthly_summary as (
        select 
            month(transaction_date) as trans_month,
            year(transaction_date) as trans_year,
            transaction_type,
            sum(amount) as monthly_amount,
            count(*) as transaction_count
        from transactions
        group by calculated trans_month, calculated trans_year, transaction_type
    )
    select 
        trans_month,
        trans_year, 
        transaction_type,
        monthly_amount,
        transaction_count,
        sum(monthly_amount) over (partition by transaction_type 
                                 order by trans_year, trans_month) as running_total
    from monthly_summary
    order by transaction_type, trans_year, trans_month;
quit;

/* ========================================
   ADDITIONAL PRACTICE IDEAS
   ======================================== */

/*
SUGGESTED PRACTICE EXERCISES:

1. SET OPERATIONS:
   - UNION: Combine individual and business customers
   - EXCEPT: Find customers with loans but no credit cards
   - INTERSECT: Find branches serving both individual and business customers

2. SUBQUERIES:
   - Correlated subqueries: Find customers with multiple accounts
   - EXISTS: Find customers who have made transactions in the last 30 days  
   - Scalar subqueries: Compare each customer's total balance to branch average

3. CTEs (Common Table Expressions):
   - Recursive CTEs: Calculate compound interest over time
   - Multiple CTEs: Customer profitability analysis
   - Window functions with CTEs: Ranking customers by transaction volume

4. ADVANCED COMBINATIONS:
   - Risk analysis: Combine loan data with transaction patterns
   - Customer segmentation: Using account balances, transaction history, and demographics
   - Branch performance: Compare metrics across different locations
*/