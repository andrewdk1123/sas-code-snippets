/* Data preps */
DATA DaycareFines;
    SET MyData.DaycareFines;
    IF study_period_3 = 'with fine' THEN DELETE;
    study_period_3 = TRIM(SUBSTR(study_period_3, 1, 6));
    LatePickupRate = late_pickups / children;
    DROP study_period_4 children late_pickups;
RUN;

/* Calculate average late pickups per each center (before vs after) */
PROC SORT DATA=DaycareFines;
    BY group center study_period_3;
RUN;

DATA DaycareFines;
    SET DaycareFines;
    BY group center study_period_3;
 
    RETAIN n_weeks sum AvgLateRate;
	IF FIRST.center THEN DO;
	    n_weeks = 1;
		sum = LatePickupRate;
		AvgLateRate = LatePickupRate;
    END;
    ELSE DO;
        n_weeks = n_weeks + 1;
        sum = sum + LatePickupRate;
        AvgLateRate = sum / n_weeks;		
	END;
 
	IF LAST.study_period_3 THEN OUTPUT;
RUN;

/* Transpose study_period_3 into columns */
PROC SORT DATA=DaycareFines;
    BY group center;
RUN;

PROC TRANSPOSE DATA=DaycareFines OUT=DaycareFines_BeforeAfter;
    BY group center;
    ID study_period_3;
    VAR AvgLateRate;
RUN;

PROC PRINT DATA=DaycareFines_BeforeAfter;
    TITLE "Average late pickup rates of daycare centers";
    VAR group center before after;
RUN;

/* One sample t-test: central location */
PROC TTEST DATA=DaycareFines_BeforeAfter H0=0.2 SIDES=2 ALPHA=0.1;
    VAR before;
RUN;

/* Paired sample t-test */
PROC PRINT DATA=DaycareFines_BeforeAfter;
    TITLE "DaycareFines Data: BY group";
    BY group;
    VAR center before after;
RUN;

/* Test group */
DATA DaycareFines_Test;
    SET DaycareFines_BeforeAfter;
    WHERE group = 'test';
    Effect = after - before;
RUN;

PROC TTEST DATA=DaycareFines_Test;
    VAR Effect;
RUN;

PROC TTEST DATA=DaycareFines_Test;
    PAIRED before * after;
RUN;

/* Two sample t-test */
PROC SGPLOT DATA=DaycareFines_BeforeAfter;
    TITLE "Late pickup rates after imposing fines";
    VBOX after / CATEGORY = group;
    YAXIS LABEL = 'Late pickup rate';
RUN;

PROC TTEST DATA=DaycareFines_BeforeAfter;
    CLASS group;
    VAR after;
RUN;