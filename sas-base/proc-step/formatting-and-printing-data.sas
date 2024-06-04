/* PROC PRINT options */
PROC PRINT DATA=MyData.Boston (OBS=20) NOOBS LABEL;
    TITLE1 'Boston Housing Dataset';
    TITLE2 'First 20 Obs';
    FOOTNOTE 'http://lib.stat.cmu.edu/datasets/boston';
    LABEL CRIM = 'Crime rate'
          ZN = '% residential area'
          INDUS = '% non-retail business area'
          CHAS = 'Riverside'
          NOX = 'Nitric oxides'
          RM = 'Rooms per dwelling'
          AGE = '% old units'
          DIS = 'Distance to business centers'
          RAD = 'Radial highway accessibility'
          TAX = 'Tax per $10,000'
          PTRATIO = 'Pupil-teacher ratio'
          LSTAT = '% lower status of the population';
RUN;

/* Optional statements for PROC PRINT */
PROC SORT DATA=SASHELP.BASEBALL OUT=SortedByTeam;
    BY Team;
RUN;

PROC PRINT DATA=SortedByTeam;
    TITLE "86's MLB Players";
    BY Team;
    SUM nAtBat nHits nHome nRuns nRBI nBB nOuts nAssts nError;
    VAR Name nAtBat nHits nHome nRuns nRBI nBB nOuts nAssts nError Salary;
    FORMAT Salary DOLLAR13.2;
RUN;

/* PROC FORMAT */
/* Please import Wiki4HE by running wiki4HE.ctl */
PROC FORMAT;
    VALUE Fmt_AgeGroup LOW - 40 = "Under 40"
                       40 -< 65 = "40 to 65"
                       65 - High = "Over 65";
    VALUE Fmt_BinaryAnswer 0 = "No"
                           1 = "Yes";
    VALUE Fmt_Gender 0 = "Male"
                     2 = "Female";
    VALUE Fmt_Likert 1 = "Strongly disagree / Never"
                     2 = "Disagree / Rarely"
                     3 = "Neither agree or disagree / Sometimes"
                     4 = "Agree / Often"
                     5 = "Strongly agree / Always";
     VALUE Fmt_Domain 1 = "Arts & Humanities"
                      2 = "Science"
                      3 = "Health Science"
                      4 = "Engineering & Architecture"
                      5 = "Law & Politics"
                      OTHER = "Others";
RUN;

PROC PRINT DATA=MyData.Wiki4HE;
    TITLE "Wiki4HE";
    FORMAT AGE Fmt_AgeGroup. GENDER Fmt_Gender. DOMAIN Fmt_Domain. 
           PhD Fmt_BinaryAnswer. USERWIKI Fmt_BinaryAnswer.
           PU1 -- Exp5 Fmt_Likert.;
RUN;