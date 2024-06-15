/* Import data: wine quality */
DATA WineQuality;
    INFILE '/home/u63368964/source/wine-quality.csv' DLM=',' FIRSTOBS=2;
    INPUT Type $ FixedAcid VolatileAcid CitricAcid
          ResidualSugar Chlorides 
          FreeSulfurDioxide TotalSulfurDioxide
          Density pH Sulphates Alcohol
          Quality;
RUN;

/* Defining and using macro variables */
%LET dsn = WineQuality;
%LET nobs = 20;

PROC PRINT DATA=&dsn (OBS=&nobs);
    TITLE "First &nobs Rows of &dsn Data";
RUN;

/* Adding text before and after macro variables */
%LET wine_type = White;

DATA WineQuality;
    INFILE '/home/u63368964/source/wine-quality.csv' DLM=',' FIRSTOBS=2;
    INPUT Type $ FixedAcid VolatileAcid CitricAcid
          ResidualSugar Chlorides 
          FreeSulfurDioxide TotalSulfurDioxide
          Density pH Sulphates Alcohol
          Quality;
    Type = PROPCASE(Type);
RUN;

DATA Only&wine_type;
    SET WineQuality;
    WHERE Type="&wine_type";
RUN;

/* Period (.) marks the end of macro variable name */
DATA &wine_type.Wines;
    SET WineQuality;
    WHERE Type="&wine_type";
RUN;

PROC FREQ DATA=&wine_type.Wines;
    TABLES Type;
RUN;

/* Double period to escape */
%LET libref = MyData;
%LET dsn = WineQuality;
%LET batch = White;

DATA &libref..&dsn.&batch;
    SET &dsn;
    WHERE Type = "&batch";
RUN;

DATA &libref..&dsn.Red;
    SET &dsn;
    WHERE Type <> "&batch";
RUN;

/* Appending Two Macro Variables to Each Other */
%LET libref = SASHELP;
%LET dsn = NVST;
%LET n = 5;

PROC PRINT DATA=&libref..&dsn.&n;
    TITLE "&libref..&dsn.&n";
RUN;

/* && will be resolved into & */
%LET NVST5 = SASHELP.NVST5;

PROC PRINT DATA=&&&dsn&n;
    TITLE "&&&dsn&n";
RUN;

/* Printing Macro Variables in the Log */
%PUT Libref: &libref;
%PUT Dataset: &dsn;
%PUT Batch: &n;

/*
Reserved words:
	_ALL_: List all macro variables in all referencing environments.
	_AUTOMATIC_: List all of automatic macro variables.
	_GLOBAL_: List all global macro variables.
	_LOCAL_: List all macro variables that are accessible only in the current referencing environment.
	_USER_: List all user-defined macro variables in each referencing environment.
*/
%PUT _USER_;

/* Defining and using macros */
%LET libref = SASHELP;
%LET dsn = RETAIL;
%LET nobs = 20;

%MACRO head;
    PROC PRINT DATA=&libref..&dsn (OBS=&nobs);
        TITLE "First &nobs observations of &libref..&dsn";
    RUN;
%MEND head;

%head;

/* Macro variable scope */
%LET global_var = global;

%MACRO show_scope;
    %LET local_var = local;
    
    %PUT ***** Inside the macro *****;
    %PUT Global Variable: &global_var;
    %PUT Local Variable: &local_var;
%MEND show_scope;

%show_scope;

%PUT ***** Outside the macro *****;
%PUT Global Variable: &global_var;
%PUT Local Variable: &local_var;

/* Creating macros with parameters */
/* Positional parameters */
%MACRO stacking_two_datasets(dsn1, dsn2);
    DATA Output;
        SET &dsn1 &dsn2;
    RUN;
    
    PROC PRINT DATA=Output;
        TITLE "Dataset: &dsn1 + &dsn2";
    RUN;
%MEND stacking_two_datasets;

%stacking_two_datasets(SASHELP.NVST1, SASHELP.NVST2);

/* Macros with undetermined positional parameters */
%MACRO stacking_datasets(ds_list);
    DATA Output;
        SET &ds_list;
    RUN;
    
    PROC PRINT DATA=Output;
        TITLE "Dataset: &ds_list";
    RUN;
%MEND stacking_datasets;

%stacking_datasets(SASHELP.NVST1 SASHELP.NVST2 SASHELP.NVST3);
%stacking_datasets(SASHELP.NVST1 SASHELP.NVST2 SASHELP.NVST3 SASHELP.NVST4 SASHELP.NVST5);

/* Keyword parameters */
%MACRO head(libref=, dsn=, nobs=5, var_format_pair=);
    PROC PRINT DATA=&libref..&dsn (OBS=&nobs);
        TITLE "First &nobs observations of &libref..&dsn";
        FORMAT &var_format_pair;
    RUN;
%MEND head;

%head(libref=SASHELP, dsn=RENT, var_format_pair=Date EURDFDD10. Amount EUROX12.2);

/* Defining a macro with both positional and keyword parameters */
/* Note: positional parameters must precede keyword parameter */
%MACRO stock_chart(ticker, period, int, open=*, high=*, low=*, close=*);
/*
ticker  Ticker symbol of the SP500 company of interest.
period  Desired time period for analysis.
int     Unit of time interval. Available options are: Year | Month | Day
open=*  To plot open price on the chart, pass open= 
high=*  To plot high price on the chart, pass high= 
low=*   To plot low price on the chart, pass low= 
close=* To plot close price on the chart, pass close= 
*/
    DATA StockSubset;
        SET MyData.SP500;
        WHERE Ticker = "&ticker" AND Date >= INTNX("&int", MAX(Date), -&period);
    RUN;
    
    PROC SGPLOT DATA=StockSubset;
        TITLE "&ticker Stock";
        FOOTNOTE "Last &period &int";
        &open  SERIES X = Date Y = Open;
        &high  SERIES X = Date Y = High;
        &low   SERIES X = Date Y = Low;
        &close SERIES X = Date Y = Close;
        YAXIS LABEL = 'USD';
    RUN;
%MEND stock_chart;    

%stock_chart(ABT, 5, Year, high=, low=);

/* Macros invoking macros */
%MACRO interleaving_two_datasets(dsn1, dsn2, by_var_list);
    %sorting_obs(&dsn1, out_dsn1, &by_var_list);
    %sorting_obs(&dsn2, out_dsn2, &by_var_list);
    
    DATA Output;
        SET out_dsn1 out_dsn2;
        BY &by_var_list;
    RUN;
%MEND interleaving_two_datasets;

%MACRO sorting_obs(input_dsn, output_dsn, by_var_list);
    PROC SORT DATA=&input_dsn OUT=&output_dsn;
        BY &by_var_list;
    RUN;
%MEND sorting_obs;

%interleaving_two_datasets(SASHELP.NVST1, SASHELP.NVST2, Date);

/* Bad practice: nesting macro definitions */
%MACRO interleaving_two_datasets(dsn1, dsn2, by_var_list);

    %MACRO sorting_obs(input_dsn, output_dsn, by_var_list);
        PROC SORT DATA=&input_dsn OUT=&output_dsn;
            BY &by_var_list;
        RUN;
    %MEND sorting_obs;
    
    %sorting_obs(&dsn1, out_dsn1, &by_var_list);
    %sorting_obs(&dsn2, out_dsn2, &by_var_list);
    
    DATA Output;
        SET out_dsn1 out_dsn2;
        BY &by_var_list;
    RUN;
    
%MEND interleaving_two_datasets;

%interleaving_two_datasets(SASHELP.NVST1, SASHELP.NVST2, Date);