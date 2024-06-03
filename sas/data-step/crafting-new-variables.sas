DATA WorkoutLogs;
    INPUT Timestamp :DATETIME. Excercise $ Reps Sets Weights;
    DATALINES;
27MAR2023:08:00:00 Squats 10 3 100
27MAR2023:08:15:00 Push-ups 15 3 0
27MAR2023:08:30:00 Bench-press 8 4 120
27MAR2023:08:45:00 Deadlifts 12 3 150
27MAR2023:09:00:00 Lunges 10 3 80
27MAR2023:09:15:00 Pull-ups 8 4 0
27MAR2023:09:30:00 Bicep-curls 12 3 40
27MAR2023:09:45:00 Planks . . .
27MAR2023:10:00:00 Shoulder-press 10 3 50
;
RUN;

/* Mathematical operations */
DATA OneRepMax;
    SET WorkoutLogs;
    Epley = Weights * (1 + 0.0333 * Reps);
    Brzycki = Weights / (1.0278 - 0.0278 * Reps);
    Lombardi = Weights * Reps ** 0.1;
    OConner = Weights * (1 + 0.025 * Reps);
    Wathan = Weights * 100 / (48.8 + 53.8 * EXP(-0.075 * Reps));
    MaxRM = MAX(Epley, Brzycki, Lombardi, OConner, Wathan);
    MinRM = MIN(Epley, Brzycki, Lombardi, OConner, Wathan);
    DROP Timestamp Sets;
RUN;

/* MDY function: Construct a SAS date value from separate numbers representing month, day, year */
DATA CarSales;
    INFILE '/home/u63368964/source/car-sales.dat';
    INPUT SalesMonth SalesDate SalesYear Model $ Color $ Quantity Price;
    SasDate = MDY(SalesMonth, SalesDate, SalesYear);
RUN;

/* IF-THEN statements */
/* YYQ function: Returns a SAS date value corresponding to the first day of the specified quarter */
DATA CarSales;
    INFILE '/home/u63368964/source/car-sales.dat';
    INPUT SalesMonth SalesDate SalesYear Model $ Color $ Quantity Price;
    IF SalesMonth LE 3 THEN SalesQuarter = YYQ(SalesYear, 1);
    IF SalesMonth GT 3 AND SalesMonth LE 6 THEN SalesQuarter = YYQ(SalesYear, 2);
    IF SalesMonth GT 6 AND SalesMonth LE 9 THEN SalesQuarter = YYQ(SalesYear, 3);
    IF SalesMonth GT 9 THEN SalesQuarter = YYQ(SalesYear, 4);
RUN;

/* IN operator */
DATA CarSales;
    LENGTH Model $10. CarType $10.;
    INFILE '/home/u63368964/source/car-sales.dat';
    INPUT SalesMonth SalesDate SalesYear Model $ Color $ Quantity Price;
    IF Model IN ('Sedan', 'SUV', 'Hatchback') THEN CarType = 'Passenger';
    ELSE CarType = 'Commercial';
RUN;

/* IF-THEN-DO block */
DATA CarSales;
    LENGTH Model $10. CarType $10.;
    INFILE '/home/u63368964/source/car-sales.dat';
    INPUT SalesMonth SalesDate SalesYear Model $ Color $ Quantity Price;
    IF Model NOT IN ('Sedan', 'SUV', 'Hatchback') THEN DO;
        CarType = 'Commercial';
        SalesTax = Price * 0.06;
        END;
    ELSE DO;
        CarType = 'Passenger';
        SalesTax = Price * 0.1;
        END;
RUN;

/* Subsetting IF */
DATA PassengerVehicleSales;
    INFILE '/home/u63368964/source/car-sales.dat';
    INPUT SalesMonth SalesDate SalesYear Model $ Color $ Quantity Price;
    IF Model = 'Truck' THEN DELETE;
RUN;

/* Date interval functions */
/*
	INTNX('interval', from, n):		Adds n-intervals to the from dates.
	INTCK('interval', from, to):	Counts number of intervals between from and to dates.
*/
DATA Employees;
    INFILE '/home/u63368964/source/employees.csv' FIRSTOBS=2 DLM=',' TRUNCOVER;
    FORMAT
        Dob DATE10. StartDate DATE10. TerminationDate DATE10. TenYearsAnniversary WORDDATE18.;
    INPUT 
        EmployeeID $4. GivenName :$15. SurName :$15. Dob DDMMYY10. 
        JobTitle :$25. StartDate :DATE10. TerminationDate ?:DATE10.;
    Age = INTCK('Year', Dob, TODAY()); 
    IF TerminationDate = '.' THEN DO;
        YearsInOffice = INTCK('Year', StartDate, TODAY());
        TenYearsAnniversary = INTNX('Year', StartDate, 10); 
        NumDaysToAnniversary = INTCK('Day', StartDate, TenYearsAnniversary); 
        END;
    ELSE TenureMonths = INTCK('Month', StartDate, ExitDate);
    DROP EmployeeID JobTitle;
RUN;

/* Character manipulations */
DATA Employees;
    INFILE '/home/u63368964/source/employees.csv' FIRSTOBS=2 DLM=',' TRUNCOVER;
    INPUT 
        EmployeeID $4. GivenName :$15. SurName :$15. Dob DDMMYY10. 
        JobTitle :$25. StartDate :DATE10. TerminationDate ?:DATE10.;
    EmployeeName = TRIM(SurName) || ', ' || GivenName;
/*     KEEP SurName GivenName EmployeeName; */
RUN;

PROC FREQ DATA=Employees;
    TABLES JobTitle;
RUN;

/* Character comparisons */
/*
IBM mainframes (z/OS): 
	- EBCDIC
	- Blank < Lowercase letters < Uppercase letters < Numerals
All others: 
	- ASCII
	- Blank < Numerals < Uppercase letters < Lowercase Letters
*/
DATA Employees;
    INFILE '/home/u63368964/source/employees.csv' FIRSTOBS=2 DLM=',' TRUNCOVER;
    INPUT 
        EmployeeID $4. GivenName :$15. SurName :$15. Dob DDMMYY10. 
        JobTitle :$25. StartDate :DATE10. TerminationDate ?:DATE10.;
    EmployeeName = TRIM(SurName) || ', ' || GivenName;
    IF JobTitle >= 'Area Sales Manager' THEN DELETE;
    KEEP EmployeeName JobTitle;
RUN;