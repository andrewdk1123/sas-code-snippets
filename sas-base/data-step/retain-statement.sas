/* Automatic variables */
/*
_N_: The current observation number 
_ERROR_: If there was any error for the current iteration, stores 1. Otherwise 0.
*/
DATA One;
    INPUT VarA;
    DATALINES;
1
2
3
;

DATA Two;
    INPUT VarB;
    DATALINES;
11
12
13
14
;

DATA Three;
    INPUT VarC;
    DATALINES;
31
32
33
34
35
;

DATA Combine;
    SET One;
    IF _N_ = 2 THEN SET Two;
    IF _N_ = 3 THEN SET Three;
RUN;

DATA Combine2;
    SET One;
    IF _N_ = 2 THEN SET Two;
    IF _N_ = 3 THEN SET Three;
    Nobs = _N_;
    Error = _ERROR_;
RUN;

/*
FIRST.BY and LAST.BY: Created for each BY variable. 
					  1 for the first observation in a BY group. Otherwise 0.
*/
DATA One;
    INPUT VarA $ VarB;
    DATALINES;
A 1
B 2
D 3
C 5
C 4
C 6
D 7
;

DATA Two;
    SET One;
    BY VarA NOTSORTED;
    First = FIRST.VarA;
    Last = LAST.VarA;
RUN;

/* Update record high */
DATA EnergyConsumption;
    INFILE '/home/u63368964/source/household-power-consumption.txt' DLM=';' FIRSTOBS=2;
    INPUT 
        Date :ANYDTDTE10. Time TIME8. 
        GlobalActivePower GlobalReactivePower Voltage GlobalIntensity 
        SubMetering1 SubMetering2 SubMetering3;
        
    /* Calculate active energy consumption */
    ActiveEnergyConsumption = GlobalActivePower * 1000 / 60 - SUM(SubMetering1, SubMetering2, SubMetering3);
    
    /* Keep track of record high of the active energy consumption */
    RETAIN RecordHigh;
    RecordHigh = MAX(RecordHigh, ActiveEnergyConsumption);
RUN;

/* Calculate running total */
/* Using RETAIN statement */
DATA EnergyConsumption2;
    SET EnergyConsumption;
    RETAIN RunningTotal -10;
    RunningTotal = SUM(RunningTotal, ActiveEnergyConsumption);
RUN;

/* Using sum statement */
DATA EnergyConsumption3;
    SET EnergyConsumption;
    RunningTotal + ActiveEnergyConsumption;
RUN;

/* Carry-over calculations */
DATA EnergyConsumption4;
    SET EnergyConsumption;
    RETAIN PreviousConsumption;
    CurrentDifference = ActiveEnergyConsumption - PreviousConsumption;
    PreviousConsumption = ActiveEnergyConsumption;
RUN;