/* 
PROC SGPIE: Pie chart and donut chart
Available options
	DATALABELDISPLAY = ALL | NONE | (content-options)
		- ALL: 	Display all available information.
		- NONE: Do not display slice labels.
		- (content-options): A space-separated list of one or more of the following options, enclosed in parentheses:
			- CATEGORY: Displays the category value.
			- PERCENT: 	Displays the response or category percentage.
	DATALABELLOC = INSIDE | OUTSIDE | CALLOUT
		- INSIDE:  Locates the slice labels inside the pie slices.
		- OUTSIDE: Locates the slice labels outside of the pie circumference.
		- CALLOUT: Locates the slice labels outside of the pie circumference and draws a line from the label to its slice.
*/

/* Pie chart */
PROC SGPIE DATA=SASHELP.CARS;
    TITLE "Pie Chart: Origin Distribution of Cars";
    PIE Origin / DATALABELDISPLAY=ALL DATALABELLOC=INSIDE;
RUN;

/* Donut chart */
PROC SGPIE DATA=SASHELP.CARS;
    TITLE "Donut Chart: Origin Distribution of Cars";
    DONUT Origin / DATALABELDISPLAY=(CATEGORY PERCENT) DATALABELLOC=CALLOUT;
RUN;

/* PROC SGPLOT: bar chart, histogram, box plot, and scatter plot */

/* 
Bar chart 
Available options
	VBAR | HBAR / options
		- ALPHA=n: Specifies the level for confidence limits. The value of n must be between 0 (100% confidence) and 1 (0 percent confidence). Default is 0.05.
		- BARWIDTH=n: Sets the bar widths. Values range from 0.1 to 1 with a default of 0.8.
		- DATALABEL=var: Displays a label for each bar. If you specify a variable name, then values of that variable will be used. Otherwise, SAS will calculate appropriate values.
		- DISCRETEOFFSET=n: Offsets bars from midpoints which is useful for overlaying bar charts. The value must be between -0.5 (left) and +0.5 (right). The default is 0 (no offset).
		- LIMITSTAT=stat: Specifies the type of limit lines to be shown. Possible values are CLM, STDDEV, or STDERR. This option must be used with the GROUP= option. You must specify a RESPONSE= option and STAT=MEAN.
		- MISSING: Includes a bar for missing values.
		- GROUP=var: Specifies a variable used to group the data.
		- GROUPDISPLAY=type: Specifies how to display grouped bars, either STACK (default) or CLUSTER.
		- RESPONSE=var: Specifies a numeric variable to be summarized.
		- STAT=stat: Specifies a statistic, either FREQ, MEAN, or SUM. FREQ is the default if there is no response. SUM is the default when you specify a response variable.
*/

/* Vertical bars */
PROC SGPLOT DATA=SASHELP.CARS;
    TITLE "Number of Cars by Origins";
    VBAR Origin;
RUN;

/* Bar chart options */
PROC SGPLOT DATA=SASHELP.CARS;
    TITLE "Number of Cars by Origins";
    VBAR Origin / BARWIDTH=0.5 TRANSPARENCY=0.7;
RUN;

PROC SGPLOT DATA=SASHELP.CARS;
    TITLE "Bad Practice 1: Unclear Plot";
    VBAR Origin / GROUP=DriveTrain;
RUN;

PROC FREQ DATA=SASHELP.CARS;
    TABLES Origin * DriveTrain / NOPERCENT NOCOL NOROW;
RUN;

PROC SGPLOT DATA=SASHELP.CARS;
    TITLE "Bad Practice 2: Unlear and Misleading Plot";
    VBAR Origin / GROUP=DriveTrain GROUPDISPLAY=CLUSTER;
RUN;

/* Horizontal bars */
PROC SGPLOT DATA=SASHELP.CARS;
    TITLE "Number of Cars by Manufacturer";
    HBAR Make;
RUN;

/* Bar charts with relative frequency */
PROC FREQ DATA=SASHELP.CARS NOPRINT;
    TABLES DriveTrain / OUT = FreqOut;
RUN;

DATA RelativeFreq;
    SET FreqOut;
    LABEL Pct = 'Percent';
    FORMAT Pct PERCENT.;
    Pct = Percent / 100;
RUN;

PROC SGPLOT DATA=RelativeFreq;
    VBAR DriveTrain / RESPONSE = Pct DATALABEL;
    YAXIS GRID DISPLAY = (NOLABEL);
    XAXIS DISPLAY = (NOLABEL);
RUN;

/* 
Histogram 
Available options
	HISTOGRAM / options
		- BINSTART=n: Specifies the midpoint for the first bin.
		- BARWIDTH=n: Specifies the bin width (in the units of the horizontal axis). SAS determines the number of bins. This option is ignored if you specify the NBINS= option.
		- NBINS=n: Specifies the number of bins. SAS determines the bin width.
		- SCALE=scaling-type: Specifies the scale for the vertical axis, either PERCENT (default), COUNT, or PROPORTION.
		- SHOWBINS: Places tick marks at the midpoints of the bins. By default, tick marks are placed at regular intervals based on minimum and maximum values.
		- TRANSPARENCY=n: Specifies the degree of transparency for the plot. n must be between 0 (default, completely opaque) and 1 (completely transparent).
*/

PROC SGPLOT DATA=SASHELP.CARS;
    TITLE 'Distribution of Car Weights';
    HISTOGRAM Weight / SCALE=COUNT;
RUN;

/* 
Density curves
Available options
	DENSITY / options
		- TYPE=dist-type: Specifies the type of distribution curve, either NORMAL (default, parametric density estimation) or KERNEL (kernel density estimation).
		- TRANSPARENCY=n: Specifies the degree of transparency for the plot. n must be between 0 (default, completely opaque) and 1 (completely transparent).
*/

PROC SGPLOT DATA=SASHELP.CARS;
    TITLE 'Distribution of Car Weights';
    HISTOGRAM Weight / SCALE=COUNT;
    DENSITY Weight;
    DENSITY Weight / TYPE=KERNEL TRANSPARENCY=0.5;
RUN;

/* 
Box plots 
Available options
	VBOX | HBOX / options
		- CATEGORY=var: Specifies a categorical variable. One box plot will be created for each value of this variable.
		- EXTREME: Specifies that the whiskers should extend to the minimum and maximum, so that candidate outliers will be unidentifiable.
		- GROUP=var: Specifies a second categorical variable. One box plot will be created of this variable within the categorical variable.
		- MISSING: Includes a box for missing valeus for the group or category variable.
		- TRANSPARENCY=n: Specifies the degree of transparency for the plot. n must be between 0 (default, completely opaque) and 1 (completely transparent).
*/

PROC SGPLOT DATA=SASHELP.CARS;
    VBOX Weight;
RUN;

/* Box plot by category */
PROC SGPLOT DATA=SASHELP.CARS;
    TITLE "Distribution of Car Weights by Type";
    VBOX Weight / CATEGORY=Type;
RUN;

PROC SGPLOT DATA=SASHELP.CARS;
    TITLE 'MPG (City) Distribution by Manufacturer';
    HBOX MPG_City / CATEGORY=Make;
RUN;

/*
Scatter plots
Available options
	SCATTER / options
		- DATALABEL=var: Displays a label for each data point. Common specification is DATALABEL=ID-variable.
		- GROUP=var: Specifies a variable to be used for grouping data.
		- NOMISSINGGROUP: Specifeis that observations with missing values for the group variable should not be included.
		- TRANSPARENCY=n: Specifies the degree of transparency for the plot. n must be between 0 (default, completely opaque) and 1 (completely transparent).
*/

PROC SGPLOT DATA=SASHELP.CARS;
    TITLE 'MPG City vs. Highway';
    SCATTER X=MPG_City Y=MPG_Highway;
RUN;

PROC SGPLOT DATA=SASHELP.BASEBALL;
    TITLE 'Number of Runs vs. Salary';
    SCATTER X=nRuns Y=Salary / DATALABEL=Name;
RUN;

/* Relationship between three variables */
PROC SGPLOT DATA=SASHELP.IRIS;
    TITLE 'Iris: Sepal Length vs. Sepal Width';
    SCATTER X=SepalLength Y=SepalWidth / GROUP=Species;
RUN;

/* 
PROC SGPANEL: Creates multi-celled graphs.
Available options
	PANELBY / options
		- COLUMNS=n: Specifies the number of columns in the panel.
		- ROWS=n: Specifies the number of rows in the panel.
		- SPACING=n: Specifies the number of pixels between rows and columns in the panel. Defaults to 0.
		- MISSING: Specifeis that observations with missing values for the PANELBY variables should be included.
		- NOVARNAME: Removes the variable name from cell headings.
		- UNISCALE=value: Specifies which axes will share the same range of values. Possible values are COLUMN, ROW, and ALL (default).
*/

PROC SGPANEL DATA=SASHELP.IRIS;
    TITLE1 'Petal Length vs. Petal Width';
    TITLE2 'By Species';
    PANELBY Species / NOVARNAME COLUMNS=3 SPACING=5;
    SCATTER X=PetalLength Y=PetalWidth;
RUN;

PROC SGPANEL DATA=SASHELP.CARS;
    TITLE1 'MPG (City) vs. Drive-train';
    TITLE2 'By Origin';
    PANELBY Origin / NOVARNAME ROWS=3 UNISCALE=ROW SPACING=5;
    HBOX MPG_City / CATEGORY = DriveTrain;
RUN;