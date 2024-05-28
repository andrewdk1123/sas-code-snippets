/* Import data set */
DATA Employees;
    INFILE '/home/u63368964/source/employees.csv' FIRSTOBS=2 DLM=',' TRUNCOVER;
    FORMAT
        Dob DATE10. StartDate DATE10. TerminationDate DATE10.;
    INPUT 
        EmployeeID $4. GivenName :$15. SurName :$15. Dob DDMMYY10. 
        JobTitle :$25. StartDate :DATE10. TerminationDate ?:DATE10.;
    Age = INTCK('Year', Dob, TODAY()); 
    IF TerminationDate = '.' THEN MonthsInOffice = INTCK('Month', StartDate, TODAY());
    ELSE MonthsInOffice = INTCK('Month', StartDate, TerminationDate);
RUN;

/* Sort by JobTitle and MonthsInOffice */
PROC SORT DATA=Employees;
    BY JobTitle MonthsInOffice;
RUN;

/* PROC PRINT DATA=Employees; */
/*     TITLE1 'List of Employees'; */
/*     TITLE2 'Sorted by Title and MonthsInOffice (ASC)'; */
/* RUN; */

PROC SORT DATA=Employees;
    BY JobTitle DESCENDING MonthsInOffice;
RUN;

/* PROC PRINT DATA=Employees; */
/*     TITLE1 'List of Employees'; */
/*     TITLE2 'Sorted by Title (ASC) and MonthsInOffice (DESC)'; */
/* RUN; */

/* OUT option */
/* Import data set */
DATA HeightWeight;
    INFILE '/home/u63368964/source/height-weight-v2.txt' DSD DLM=',';
    INPUT Name $ Age Sex $ Weight Height;
RUN;

PROC SORT DATA=HeightWeight OUT=SortedData;
    BY Weight;
RUN;

/* Print original data */
/* PROC PRINT DATA=HeightWeight; */
/*     TITLE 'Height and Weight Data (Original)'; */
/* RUN; */

/* Print sorted data */
/* PROC PRINT DATA=SortedData; */
/*     TITLE 'Height and Weight Data (Sorted)'; */
/* RUN;  */

/* NODUPKEY option */
PROC SORT DATA=MyData.Boston OUT=SortedBostonNoDupKey NODUPKEY DUPOUT=DupObs;
    BY ZN;
RUN;

/* Print the first 15 observations of the original data */
/* PROC PRINT DATA=MyData.Boston (OBS=15); */
/*     TITLE1 "Boston Housing Data"; */
/*     TITLE2 "Unsorted"; */
/* RUN; */
/*  */
/* Print the first 15 observations of the modified data */
/* PROC PRINT DATA=SortedBostonNoDupKey (OBS=15); */
/*     TITLE1 "Boston Housing Data"; */
/*     TITLE2 "Sorted by ZN with NODUPKEY Option"; */
/* RUN; */

/* Print the first 15 observations of the duplicated data */
/* PROC PRINT DATA=DupObs (OBS=15); */
/*     TITLE "Duplicated Data"; */
/* RUN;  */

/* Create example data set */
DATA MyData;
    INPUT Name $;
    CARDS;
eva
amanda
Zenobia
ANNA
;
RUN;

PROC SORT DATA=MyData SORTSEQ=LINGUISTIC (STRENGTH=PRIMARY);
    BY Name;
RUN;

/* PROC PRINT DATA=MyData; */
/*     TITLE "Sorted by Name (Case insensitive)"; */
/* RUN; */

/* Create example data set */
DATA MyData2;
    INPUT Name $ 1-8 Competitions $ 9-26;
    CARDS;
eva     1500m freestyle
amanda  200m breaststroke
Zenobia 100m backstroke
ANNA    50m freestyle
;
RUN;

/* Sorts data without suboption */
PROC SORT DATA=MyData2 OUT=SortByDefault;
    BY Competitions;
RUN;

/* Sorts data with numeric collation option */
PROC SORT DATA=MyData2 OUT=SortWithSuboption SORTSEQ=LINGUISTIC (NUMERIC_COLLATION=ON);
    BY Competitions;
RUN;

/* Print original data */
PROC PRINT DATA=MyData2;
    TITLE "Unsorted Data";
RUN;

/* Print sorted data (default) */
PROC PRINT DATA=SortByDefault;
    TITLE "Sorted by Competitions (Default)";
RUN;

/* Print sorted data (numeric collation) */
PROC PRINT DATA=SortWithSuboption;
    TITLE "Sorted by Competitions (Numeric collation)";
RUN;