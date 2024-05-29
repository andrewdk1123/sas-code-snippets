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
/* PROC MEANS DATA=MyData; */
/* RUN; */

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

/* PROC MEANS DATA=MyData2 MAXDEC=3 MEDIAN MODE N NMISS RANGE SUM; */
/* RUN; */

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