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

/* Customizing titles and footnotes */
/*
Available options
	COLOR=: Specifies a color for the text.
			Colors can be specified either by name (e.g. BLUE) or hexadecimal codes (e.g., '#0000FF')
			Commonly specifications are: AQUA, BLACK, BLUE, FUCHIA, GREEN, GRAY, LIME, MMAROON, NAVY, OLIVE, PURPLE, RED, SILVER, TEAL, WHITE, YELLOW.
	BCOLOR=: Specifies a background color for the text. The same color ranges available in the COLOR= option applies.
	HEIGHT=: Specifies the height of the text. HEIGHT value should be a number with units of PT, IN, or CM. 
			 E.g., TITLE HEIGHT=12PT 'small ' HEIGHT=.25IN 'Medium ' HEIGHT=1CM 'Large';
	JUSTTIFY=: Control justification of text strings, which can be either LEFT, CENTER, or RIGHT.
			   E.g., TITLE JUSTIFY=LEFT 'Left ' JUSTIFY=CENTER 'vs. ' JUSTIFY=RIGHT 'Right';
	FONT=: Specifies a font for the text. The font specification should be enclosed by quotation marks. The particular set of available fonts depends on your your operating environment. 'Times', 'Arial', 'Helvetica', and 'Courier' works for most cases.
	BOLD: Makes text bold.
	ITALIC: Makes text italic.
*/
PROC MEANS DATA=WineQuality;
    TITLE COLOR=RED "This is " ITALIC "my " COLOR=BLUE "title";
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