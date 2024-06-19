/* %IF-%THEN/%ELSE statements */   
%IF &SYSDAY = Sunday OR &SYSDAY = Wednesday %THEN %DO; 
    %LET workout_routine = Leg;
    %PUT Today is &workout_routine. day!;
    %END;
%IF &SYSDAY = Monday OR &SYSDAY = Thursday %THEN %DO; 
    %LET workout_routine = Push;
    %PUT Today is &workout_routine. day!;
    %END;
%ELSE %DO;
    %LET workout_routine = Pull;
    %PUT Today is &workout_routine. day!;
    %END;

/* Iterative %DO-%END block */
%MACRO names(name, first, last);
    %DO i = &first %TO &last;
        &name._&i
    %END;
%MEND names;

%PUT %names(MyData, 1, 5);

/* This won't work! */
/* %MACRO names(name, first, last); */
/*     %DO i = &first %TO &last; */
/*         &name._&i; */
/*     %END; */
/* %MEND names; */
/*  */
/* %PUT %names(MyData, 1, 5); */

/* Creates five empty data sets from scratch */
DATA %names(MyData, 1, 5);
    ATTRIB
        VarA LENGTH=8 FORMAT=BEST12. LABEL="Dummy variable A"
        VarB LENGTH=8 FORMAT=BEST12. LABEL="Dummy variable B"
        VarC LENGTH=8 FORMAT=BEST12. LABEL="Dummy variable C"
        ;
    STOP;
RUN;

/* %DO-%WHILE statement */
%MACRO count_while(n);
    %PUT Count starts at: &n;
    %DO %WHILE(&n < 3);
        %PUT *** &n ***;
        %LET n = %EVAL(&n + 1);
    %END;
    %PUT Count ends at: &n;
%MEND count_while;

%count_while(1);
%count_while(5);

/* %DO-%UNTIL statement */
%MACRO count_until(n);
    %PUT Count starts at: &n;
    %DO %UNTIL(&n >= 3);
        %PUT *** &n ***;
        %LET n = %EVAL(&n + 1);
    %END;
    %PUT Count ends at: &n;
%MEND count_until;

%count_until(1);
%count_until(5);

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
/* %MACRO interleaving_two_datasets(dsn1, dsn2, by_var_list); */
/*  */
/*     %MACRO sorting_obs(input_dsn, output_dsn, by_var_list); */
/*         PROC SORT DATA=&input_dsn OUT=&output_dsn; */
/*             BY &by_var_list; */
/*         RUN; */
/*     %MEND sorting_obs; */
/*      */
/*     %sorting_obs(&dsn1, out_dsn1, &by_var_list); */
/*     %sorting_obs(&dsn2, out_dsn2, &by_var_list); */
/*      */
/*     DATA Output; */
/*         SET out_dsn1 out_dsn2; */
/*         BY &by_var_list; */
/*     RUN; */
/*      */
/* %MEND interleaving_two_datasets; */
/*  */
/* %interleaving_two_datasets(SASHELP.NVST1, SASHELP.NVST2, Date); */

/* MLOGIC and MPRINT options */

OPTIONS MLOGIC MPRINT;

%interleaving_two_datasets(SASHELP.NVST1, SASHELP.NVST2, Date);

OPTIONS NOMLOGIC NOMPRINT;