/* Create example data set */
DATA ChicagoDetroit;
    SET SASHELP.BASEBALL;
    IF Team NOT IN ('Chicago', 'Detroit') THEN DELETE;
    KEEP Name Team Position Salary;
RUN;

PROC SORT DATA=ChicagoDetroit;
    BY Position Name;
RUN;

PROC TRANSPOSE DATA=ChicagoDetroit OUT=TransposedData;
    BY Position Name;
    ID Team;
    VAR Salary;
RUN;

PROC PRINT DATA=TransposedData;
    TITLE "Transposed Data";
RUN;