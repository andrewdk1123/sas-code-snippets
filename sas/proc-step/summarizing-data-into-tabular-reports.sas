/* PROC MEANS basics */
DATA MyData;
    INPUT X;
    CARDS;
1
2
3
.
4
5
;

/* Observe: 
	PROC MEANS ignores all missing values.
	Std Dev is the sample standard deviation, not population!
*/
PROC MEANS DATA=MyData;
RUN;

/* PROC MEANS options */
/*
	MAX:	Max value
	MIN:	Min value
	MEAN:	Mean
	MEDIAN:	Median
	MODE:	Mode
	N:		Number of non-missing values
	NMISS:	Number of missing values
	RANGE:	Max - Min
	STDDEV:	Sample standard deviation
	SUM:	Sum
*/
DATA MyData2;
    INPUT X Y Z;
    CARDS;
1 1 1
2 2 1
3 3 1
. 4 4
4 5 4
5 6 9
;
RUN;

PROC MEANS DATA=MyData2 MAXDEC=3 MEDIAN MODE N NMISS RANGE SUM;
RUN;

/* Optional statements: BY, CLASS, VAR */
DATA MyData3;
    INPUT X $ Y Z;
    CARDS;
a 1 1
b 2 1
a 3 1
b 4 4
a 5 4
b 6 9
;
RUN;

PROC MEANS DATA=MyData3;
    TITLE "CLASS X";
    CLASS X; 
RUN;

PROC SORT DATA=MyData3;
    BY X;
RUN;

PROC MEANS DATA=MyData3;
    TITLE "BY X";
    BY X;
RUN;

PROC MEANS DATA=MyData3;
    TITLE "VAR Y";
    VAR Y;
RUN;

/* PROC FREQ basics */
PROC FREQ DATA=SASHELP.CARS;
    TABLES DriveTrain;
RUN;

PROC FREQ DATA=SASHELP.CARS;
    TABLES DriveTrain * Type;
RUN;

PROC FREQ DATA=SASHELP.CARS;
    TITLE "Two Contingency Tables";
    TABLES DriveTrain * Type;
    TABLES Origin;
RUN;

PROC FREQ DATA=SASHELP.CARS;
    TITLE "Contingency table without percentages";
    TABLES DriveTrain * Type / NOROW NOCOL NOPERCENT;
RUN;


PROC FREQ DATA=SASHELP.CARS;
    TABLES Cylinders;
RUN;

PROC FORMAT;
    VALUE Price
          LOW - 30000 = '$'
          30001 - 60000 = '$$'
          60001 - 90000 = '$$$'
          90001 - HIGH = '$$$$';
RUN;

PROC FREQ DATA=SASHELP.CARS;
    TABLES MSRP;
    FORMAT MSRP Price.;
RUN;

/* PROC TABULATE */
/* One dimension is defined */
PROC TABULATE DATA=SASHELP.CARS;
    TITLE "Col-dimension: DriveTrain";
    CLASS DriveTrain;
    TABLES DriveTrain;
RUN;

/* Two dimensions are defined */
PROC TABULATE DATA=SASHELP.CARS;
    TITLE1 "Row-dimension: Type";
    TITLE2 "Col-dimension: DriveTrain";
    CLASS Type DriveTrain;
    TABLE Type, DriveTrain;
RUN;

/* All three dimensions are defined */
PROC TABULATE DATA=SASHELP.CARS;
    TITLE1 "Page-dimension: Origin";
    TITLE2 "Row-dimension: Type";
    TITLE3 "Col-dimension: DriveTrain";
    CLASS Origin Type DriveTrain;
    TABLE Origin, Type, DriveTrain;
RUN;

/* Create example data with missing values */
DATA MyData4;
    /* X: row Y: col Z: page */
    INPUT X $ Y $ Z $;
    CARDS;
.   121 131
211 221 231
311 321 331

112 122 132
212 .   232
312 322 332

113 123 .
213 223 233
313 323 333
;
RUN;

/* Excluding all observations with a missing value, 
six tables, one for each Z value, 
will be created */ 
PROC TABULATE DATA=MyData4;
    Page, row, col
    CLASS Z X Y;
    TABLE Z, X, Y;
RUN;

PROC TABULATE DATA=MyData4 MISSING;
    Page, row, col
    CLASS Z X Y;
    TABLE Z, X, Y;
RUN;

/* Adding statistics */
PROC TABULATE DATA=SASHELP.CARS;
    TITLE "Mean MSRP for each DriveTrain and Type";
    VAR MSRP;
    CLASS DriveTrain Type;
    TABLE DriveTrain * Type, MEAN * MSRP; 
RUN;

PROC TABULATE DATA=SASHELP.CARS;
    TITLE "Mean MSRP by DriveTrain and Type";
    VAR MSRP;
    CLASS DriveTrain Type;
    TABLE DriveTrain ALL, MEAN * MSRP * (Type ALL); 
RUN;

Formatting data cells
PROC TABULATE DATA=SASHELP.CARS FORMAT=DOLLAR9.2;
    TITLE "Mean MSRP by DriveTrain and Type";
    VAR MSRP;
    CLASS DriveTrain Type;
    TABLE DriveTrain ALL, MEAN * MSRP * (Type ALL); 
RUN;

PROC TABULATE DATA=SASHELP.CARS;
    TITLE "Mean MSRP and MPG (City) by DriveTrain and Type";
    VAR MSRP MPG_City;
    CLASS DriveTrain Type;
    TABLE DriveTrain ALL, MEAN * (MSRP*FORMAT=DOLLAR9.2 MPG_City*FORMAT=4.1) * (Type ALL); 
RUN;