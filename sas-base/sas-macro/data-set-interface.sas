/* SYMPUT routine */

/* Example scenario: Count JobTitle of Employees data set
                	 and calculate the average YearsInOffice of the most frequent JobTitle */
DATA Employees;
    INFILE '/home/u63368964/source/employees.csv' FIRSTOBS=2 DLM=',' TRUNCOVER;
    FORMAT
        Dob DATE10. StartDate DATE10. EndDate DATE10.;
    INPUT 
        EmployeeID $4. GivenName :$15. SurName :$15. Dob DDMMYY10. 
        JobTitle :$25. StartDate :DATE10. EndDate ?:DATE10.;
    IF EndDate = '.' THEN YearsInOffice = INTCK('Year', StartDate, TODAY());
    ELSE YearsInOffice = INTCK('Year', StartDate, EndDate);
RUN;

PROC FREQ DATA=Employees NOPRINT;
    TABLES JobTitle / OUT=JobTitles_Freq;
RUN;

PROC SORT DATA=JobTitles_Freq;
    BY DESCENDING COUNT;
RUN;

DATA MostFreqJobTitle;
    SET JobTitles_Freq(OBS=1);
    CALL SYMPUT('job_title', JobTitle);
RUN;

PROC MEANS DATA=Employees;
    VAR YearsInOffice;
    WHERE JobTitle = "&job_title";
RUN;

/* CAUTION: CALL SYMPUT is a DATA step routine, not macro level statement!
			Thus, CALL SYMPUT will be executed AFTER resolving macro references! */

DATA Employees2;
    SET Employees;
    CALL SYMPUT('first_name', GivenName);
    NickName = "&first_name";
RUN;

/* Using a SAS data set as a control file */
DATA Control;
    Libref = 'MyData';
    Dataset = 'Boston';
    NumObs = '20';
RUN;

%MACRO macro_resolution;
    DATA _NULL_;
        SET Control;
        CALL SYMPUT('libref', Libref);
        CALL SYMPUT('dsn', Dataset);
        CALL SYMPUT('nobs', NumObs);
    RUN;
%MEND macro_resolution;

%MACRO my_print;
    PROC PRINT DATA=&libref..&dsn (OBS=&nobs);
        TITLE "First &nobs of &libref..&dsn";
    RUN;
%MEND my_print;

%macro_resolution;
%my_print;