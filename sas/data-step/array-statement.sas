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