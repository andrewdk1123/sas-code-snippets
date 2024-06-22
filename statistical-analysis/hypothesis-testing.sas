/* GRE scores datasets */
/* https://www.openicpsr.org/openicpsr/project/155721/version/V1/view */

PROC CONTENTS DATA=MyData.GreScore1;
PROC CONTENTS DATA=MyData.GreScore2;
RUN;

/* Merge GRE scores from two data sources */
DATA GREScoresFull;
    LENGTH GRE_Q GRE_V GRE_W 8;
    SET MyData.GreScore1 (RENAME=(GREQuantitative = GRE_Q
                                  GREVerbal = GRE_V
                                  GREWriting = GRE_W))
        MyData.GreScore2;
        /* Delete observation with any missing value */
    IF NMISS(OF GRE_Q--GRE_W) > 0 THEN DELETE;
    KEEP GRE_Q GRE_V GRE_W;
RUN;

/* Use only subset of the entire data set */
PROC SURVEYSELECT DATA=GREScoresFull METHOD=SYS N=30 OUT=GREScores;
RUN;

/* Calculate sample mean: GRE_V */
PROC MEANS DATA=GREScores;
    TITLE "GRE Score Sample Statistics";
    VAR GRE_V;
RUN;

/* Z-test statistic: two-sided */
DATA _NULL_;
     Z = (155.8 - 150.94) / (8.48 / SQRT(30));
     CALL SYMPUTX('z_statistic', Z);
RUN;

%PUT &z_statistic;

/* Calculate p-value: two-sided */
DATA _NULL_;
   P = 1 - CDF('NORMAL', &z_statistic) + CDF('NORMAL', -&z_statistic);
   CALL SYMPUTX('p_value', P);
RUN;

%PUT &p_value;

/* Calculate sample mean: GRE_Q */
PROC MEANS DATA=GREScores NOPRINT;
    VAR GRE_Q;
    OUTPUT OUT=SampleStat_GRE_Q(WHERE=(_STAT_='MEAN'));
RUN;

/* Calculate p-value: one-sided */
DATA _NULL_;
    SET SampleStat_GRE_Q;
    Z = (GRE_Q - 155.44) / (9.78 / SQRT(30));
    P = 1 - CDF('NORMAL', Z);
    PUT GRE_Q Z P;
RUN;