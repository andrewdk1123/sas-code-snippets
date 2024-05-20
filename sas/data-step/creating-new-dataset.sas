DATA WorkoutLogs;
    INPUT 
        Timestamp :DATETIME. 
        Exercises $ 
        Reps 
        Sets 
        Weights;
    DATALINES;
27MAR2023:08:00:00 Squats 10 3 100
27MAR2023:08:15:00 Push-ups 15 3 0
27MAR2023:08:30:00 Bench 8 4 120
27MAR2023:08:45:00 Deadlifts 12 3 150
27MAR2023:09:00:00 Lunges 10 3 80
27MAR2023:09:15:00 Pul-ups 8 4 0
27MAR2023:09:30:00 Bicep Curls 12 3 40
27MAR2023:09:45:00 Planks . . .
27MAR2023:10:00:00 Shoulder Press 10 3 50
;
RUN;

DATA PowerConsumption;
    INFILE '/home/u63368964/source/household-power-consumption.txt' DLM=';' FIRSTOBS=2;
    INPUT 
        Date :ANYDTDTE10. 
        Time TIME8. 
        GlobalActivePower 
        GlobalReactivePower 
        Voltage 
        GlobalIntensity 
        SubMetering1 
        SubMetering2 
        SubMetering3;
RUN;

DATA HomeAddress;
    /* Specifying variable length */
   LENGTH ID $3 Name $50 Age 3 Sex $1 Address $100;
   INFILE '/home/u63368964/source/home-address.dat' ENCODING='utf-8' FIRSTOBS=2 OBS=7 DLM=',' TRUNCOVER;
   INPUT ID $ Name $ Age Sex $ Address;
RUN;

DATA NewDataSet;
    SET HomeAddress;
    ZipCode = SUBSTR(Address, 1, 11);
RUN;

DATA StudentGrades;
    INFILE '/home/u63368964/source/student-grades.dat';
    INPUT StudentID $ 1-4 Name $ 6-20 Math Science English;
RUN;

DATA JulyTemperatures;
    INFILE '/home/u63368964/source/temperatures.dat';
    INPUT @'State:' State $ 
          @1 City $ 
          @'State:' +3 
          AvgHigh 2. 
          AvgLow 2. 
          RecordHigh 
          RecordLow;
RUN;

DATA HeightWeights;
    INFILE '/home/u63368964/source/height-weight.dat';
    INPUT FirstName $ LastName $
          / Age
          #3 Height Weight;
RUN;

DATA MyData;
    INPUT Year 1-4 @;
        IF Year=1988 THEN INPUT Day 5-7 Amount 8-10;
        IF Year=1989 THEN INPUT Day 6-8 Amount 10-12;
    CARDS;
19883.2149
19885.7614
1989 7.9 764
1989 6.8 875
;
RUN;

DATA Sales;
    INFILE '/home/u63368964/source/sales.dat';
    INPUT 
        SalesID $4. 
        Product $ 6-16 
        SalesDate MMDDYY10. 
        Amount COMMA8.2 @37 
        ProductWeight 4.2;
RUN;