/* Import data: wine quality */
DATA WineQuality;
    INFILE '/home/u63368964/source/wine-quality.csv' DLM=',' FIRSTOBS=2;
    INPUT Type $ FixedAcid VolatileAcid CitricAcid
          ResidualSugar Chlorides 
          FreeSulfurDioxide TotalSulfurDioxide
          Density pH Sulphates Alcohol
          Quality;
RUN;

/* PROC MEANS basics */
PROC MEANS DATA=WineQuality;
RUN;

/* TITLE and FOOTNOTE */
PROC MEANS DATA=WineQuality;
    TITLE 'Descriptive Statistics of the Wine Quality Data Set';
    FOOTNOTE 'Cortez et al., 2009';
RUN;

PROC MEANS DATA=WineQuality;
    TITLE1 'Here''s a title';
    TITLE2 "Here's another title";
    FOOTNOTE 'Cortez et al., 2009';
RUN;

PROC MEANS DATA=WineQuality;
    TITLE1 "This is title1";
    TITLE3 "This is title3";
    TITLE2 "This is title2";
    FOOTNOTE1 "This is footnote1";
    FOOTNOTE3 "This is footnote3";
    FOOTNOTE2 "This is footnote2";
RUN;

PROC MEANS DATA=WineQuality;
    TITLE "This is title";
    FOOTNOTE "This is footnote";
    TITLE;
    FOOTNOTE;
RUN;

/* LABEL statement */
PROC MEANS DATA=WineQuality;
    TITLE "Descriptive Statistics of the Wine Quality Data Set";
    FOOTNOTE "Cortez et al., 2009";
    LABEL FixedAcid = "Fixed Acidity"
          VolatileAcid = "Volatile Acidity"
          CitricAcid = "Citric Acidity";
RUN;

/* BY statement */
PROC SORT DATA=WineQuality;
    BY Type;
RUN;

PROC MEANS DATA=WineQuality;
    TITLE "Descriptive Statistics of the Wine Quality Data Set";
    FOOTNOTE "Cortez et al., 2009";
    LABEL FixedAcid = "Fixed Acidity"
          VolatileAcid = "Volatile Acidity"
          CitricAcid = "Citric Acidity";
    BY Type;
RUN;

/* WHERE statement */
PROC MEANS DATA=WineQuality;
    TITLE "Descriptive Statistics of the Wine Quality Data Set";
    TITLE2 "Type='red' only";
    FOOTNOTE "Cortez et al., 2009";
    LABEL FixedAcid = "Fixed Acidity"
          VolatileAcid = "Volatile Acidity"
          CitricAcid = "Citric Acidity";
    WHERE Type = 'red';
RUN;