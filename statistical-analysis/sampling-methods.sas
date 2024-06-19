/* Import data */
DATA MyData.WineQuality;
    INFILE '/home/u63368964/source/wine-quality.csv' DLM=',' FIRSTOBS=2;
    INPUT Type $ FixedAcid VolatileAcid CitricAcid
          ResidualSugar Chlorides 
          FreeSulfurDioxide TotalSulfurDioxide
          Density pH Sulphates Alcohol
          Quality;
    Type = PROPCASE(Type);
RUN;

DATA MyData.Wiki4HE;
    INFILE '/home/u63368964/source/wiki4HE.csv' DLM=';' FIRSTOBS=2;
    INPUT 
        AGE GENDER DOMAIN PhD YEARSEXP UNIVERSITY UOC_POSITION OTHER_POSITION OTHERSTATUS 
        USERWIKI 
        PU1 PU2 PU3 
        PEU1 PEU2 PEU3 
        ENJ1 ENJ2 
        Qu1 Qu2 Qu3 Qu4 Qu5 
        Vis1 Vis2 Vis3 
        Im1 Im2 Im3 
        SA1 SA2 SA3 
        Use1 Use2 Use3 Use4 Use5 
        Pf1 Pf2 Pf3 
        JR1 JR2 
        BI1 BI2 
        Inc1 Inc2 Inc3 Inc4 
        Exp1 Exp2 Exp3 Exp4 Exp5
;
RUN;

ODS SELECT Variables;
ODS NOPROCTITLE;
TITLE 'Wine Quality';
PROC CONTENTS DATA=MyData.WineQuality;
RUN;
ODS SELECT ALL;

ODS SELECT Position;
ODS NOPROCTITLE;
TITLE 'Wiki4HE';
PROC CONTENTS DATA=MyData.Wiki4HE VARNUM;
RUN;
ODS SELECT ALL;
    
/* Simple random sampling */
/* Selecting a sample of 2 from a population of 10 */
%LET population_size = 10; /* Number of population members */  
%LET sample_size = 2; /* Number of samples */

PROC FORMAT;
    VALUE SampleCode 1  = "A"
                     2  = "B"
                     3  = "C"
                     4  = "D"
                     5  = "E"
                     6  = "F"
                     7  = "G"
                     8  = "H"
                     9  = "I"
                     10 = "J";
RUN;

/* List of all possible samples */
DATA SampleList_&population_size.C&sample_size(DROP=i j);
    DO i = 1 TO (&population_size - 1);
        DO j = (i + 1) TO &population_size;
            Select1 = PUT(i, SampleCode.);
            Select2 = PUT(j, SampleCode.);
            Sample = CATX("", Select1, Select2);
            OUTPUT;
        END;
    END;
RUN;


PROC PRINT DATA=SampleList_&population_size.C&sample_size;
    TITLE "List of All Possible Samples";
RUN;

/* Sampling with replacement from the list of possible samples */
%LET seed = 36830;
%LET ntrial = 100;

DATA Sampling(DROP=i);
    SelectedSample = INT(RANUNI(&seed) * n) + 1;
    SET SampleList_&population_size.C&sample_size POINT = SelectedSample NOBS = n;
    i + 1;
    Trial = i;
    IF i > &ntrial THEN STOP;
RUN;

PROC PRINT DATA=Sampling;
    TITLE "Selected Samples";
RUN;

/* Count the number of samples including each sampling unit */
%LET sampling_unit = A;

DATA CountSamplingUnit;
    SET SampleList_&population_size.C&sample_size;
    ARRAY k[*] Select1-Select2;
        DO i=1 TO 2;
            IF k[i] = "&sampling_unit" THEN OUTPUT;
        END;
    DROP i;
RUN;

/* Sampling without replacement */
%MACRO sampling_no_rep(dsn, sample_size, seed);
    DATA SelectedSamples (DROP=k n);
        RETAIN k &sample_size n;
        SET &dsn NOBS=pop_size;
        IF _N_=1 THEN n=pop_size;
        IF RANUNI(&seed) <= k/n THEN
            DO;
                OUTPUT;
                k=k-1;
            END;
        n=n-1;
        IF k=0 THEN STOP;
    RUN;
%MEND sampling_no_rep;

%sampling_no_rep(MyData.WineQuality, 50, 7987);

/* Using PROC SURVEYSELECT */
PROC SURVEYSELECT DATA=MyData.WineQuality METHOD=SRS N=50 SEED=1123 OUT=SampleSrs;
    TITLE1 "Randomly selected 50 observations";
    TITLE2 "Systematic Sampling";
RUN;

PROC PRINT DATA=SampleSrs;
RUN;

/* Stratified sampling on MyData.WineQuality */
PROC SORT DATA=MyData.WineQuality OUT=SortByTypeQuality;
    BY Type Quality; 
RUN;

PROC FREQ DATA=SortByTypeQuality;
    TITLE1 "Wine Quality Data set";
    TITLE2 "Strata of Wines";
    TABLES Type * Quality;
RUN;

/* Within each wine group, SRS of 5 */
/* N= must not exceed the number of observations, for any strata*/
PROC SURVEYSELECT DATA=SortByTypeQuality METHOD=SRS N=5 SEED=1123 OUT=SampleStrata;
    TITLE1 "Wine Quality Data";
    TITLE2 "Stratified Sampling";
    STRATA Type Quality;
RUN;

/* Cluster sampling */
PROC SURVEYSELECT DATA=MyData.Wiki4HE METHOD=SRS N=1 SEED=6589 OUT=SampleCluster; 
    CLUSTER University;
RUN;

/* See which cluster is selected and how many observations are in the cluster */
PROC FREQ DATA=SampleCluster;
    TITLE "Selected Cluster";
    TABLES University;
RUN;

/* Compare distribution of YearsExp: Sample vs. Population*/
PROC SGPLOT DATA=SampleCluster;
    TITLE "Years of Experience: Sampled Cluster";
    HISTOGRAM YearsExp;
RUN;

PROC SGPLOT DATA=MyData.Wiki4HE;
    TITLE "Years of Experience: Population";
    HISTOGRAM YearsExp;
RUN;

/* Systematic sampling */
PROC SURVEYSELECT DATA=MyData.Boston METHOD=SYS N=50 SEED=1123 OUT=SampleSys;
    TITLE1 "Boston Housing Data";
    TITLE2 "Systematic Sampling";
RUN;

PROC PRINT DATA=SampleSys;
RUN;



