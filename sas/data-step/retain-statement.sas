/* Update records high */
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
    RETAIN RunningTotal 0;
    RunningTotal = SUM(RunningTotal, ActiveEnergyConsumption);
RUN;

/* Using sum statement */
DATA EnergyConsumption3;
    SET EnergyConsumption;
    RunningTotal + ActiveEnergyConsumption;
RUN;