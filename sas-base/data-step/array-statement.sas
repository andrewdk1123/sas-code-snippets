/* Iterative DO statements */
/* DO-TO: arithmetical sequence */
DATA MySequence;
    DO i = 1 TO 5;
        x = i * 10;
        OUTPUT;
    END;
RUN;

/* Nested DO-TO: prime number between 2 and 100 */
DATA MyPrimes (DROP=divisor IsPrime);
    DO num = 2 TO 100;
        IsPrime = 1; /* num is prime initially (2) */ 

        /* Check if num is divisible by any number other than 1 and itself */
        DO divisor = 2 TO SQRT(num);
            IF MOD(num, divisor) = 0 THEN DO;
                IsPrime = 0;
                LEAVE; /* Exit the inner loop early if not prime */
            END;
        END;

    /* Output num if it is prime */
    IF IsPrime = 1 THEN OUTPUT;
    END;
RUN;

/* BY clause: systematic sampling */
DATA MySample;
    DO i = 2 TO N BY 10;
        SET MyData.Boston NOBS=N POINT=i;
        IF _ERROR_ THEN ABORT;
        OUTPUT;
    END;
    STOP;
RUN;

/* DO-WHILE */
DATA MyData;

    x = 1;

    /* Increment x while it is less than or equal to 10 */
    DO WHILE(x <= 10);
        y = x ** 2;
        OUTPUT;
        x + 1; /* Increment x by 1 */
    END;
RUN;

/* DO-UNTIL */
DATA MyData;

    x = 1;

    /* Increment x while it is less than or equal to 10 */
    DO UNTIL(x > 10);
        y = x ** 2;
        OUTPUT;
        x + 1; /* Increment x by 1 */
    END;
RUN;

/* Importing data */
DATA WineQuality;
    INFILE '/home/u63368964/source/wine-quality.csv' FIRSTOBS=2 DLM=',';
    INPUT 
    Type $ 
    FixedAcidity VolatileAcidity CriticAcid 
    ResidualSugar Chlorides 
    FreeSulfur TotalSulfur
    Density pH Sulphates Alcohol Quality;
RUN;

/* Data cleaning using ARRAY */
DATA WineQualityCleaned;
    SET WineQuality;
    ARRAY WineAttributes (11) FixedAcidity VolatileAcidity CriticAcid ResidualSugar Chlorides FreeSulfur TotalSulfur Density pH Sulphates Alcohol;
        DO i = 1 TO 11;
            IF WineAttributes[i] = . THEN DELETE;
        END;
RUN;

/* Using shortcuts for variable name listing */
DATA WineQualityCleaned2;
    SET WineQuality;
    ARRAY WineAttributes (11) FixedAcidity -- Alcohol;
        DO i = 1 TO 11;
            IF WineAttributes[i] = . THEN DELETE;
        END;
RUN;