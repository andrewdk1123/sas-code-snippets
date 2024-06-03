/* Creating a new SAS data set by manually entering values */
DATA WorkoutLogs;
    INPUT Timestamp :DATETIME. Exercise $ Reps Sets Weights;
    DATALINES;
27MAR2023:08:00:00 Squats 10 3 100
27MAR2023:08:15:00 Push-ups 15 3 0
27MAR2023:08:30:00 Bench 8 4 120
27MAR2023:08:45:00 Deadlifts 12 3 150
27MAR2023:09:00:00 Lunges 10 3 80
27MAR2023:09:15:00 Pull-ups 8 4 0
27MAR2023:09:30:00 Bicep-curls 12 3 40
27MAR2023:09:45:00 Planks . . .
27MAR2023:10:00:00 Shoulder-press 10 3 50
;
RUN;

/* Creating a new SAS data set by referencing an external file */
DATA PowerConsumption;
    INFILE '/home/u63368964/source/household-power-consumption.txt' DLM=';' FIRSTOBS=2;
    INPUT 
        Date :ANYDTDTE10. Time TIME8. 
        GlobalActivePower GlobalReactivePower Voltage GlobalIntensity 
        SubMetering1 SubMetering2 SubMetering3;
RUN;

/* 
INFILE options 
	FIRSTOBS:	Specifies the row number from which SAS begins to read data
	OBS:		Specifies the row number at which SAS finishes reading data
	ENCODING:	Specifies the character encoding of the file
	DLM:		Specifies the delimiter
	DSD:		Recognizes quoted string with a delimiter as a single value
	MISSOVER:	Assign missing values to the remaining variables, if data line runs out of the value
	TRUNCOVER:	Treat truncated values as missing values
*/

DATA HomeAddress;
   /* Specifying variable lengths */
   LENGTH ID $3 Name $50 Age 3 Sex $1 Address $100;
   INFILE '/home/u63368964/source/home-address.dat' ENCODING='utf-8' FIRSTOBS=2 OBS=7 DLM=',' TRUNCOVER;
   INPUT ID $ Name $ Age Sex $ Address;
RUN;

/* Creating new data set, referencing from another data set */
/* 
	DROP:	Excludes variables from the output dataset
	RENAME: Rename variables in the output dataset
	KEEP:	Retain specific variables in the output dataset
*/

DATA JapaneseAddress;
    SET HomeAddress;
    PostalCode = SUBSTR(Address, 1, 11);
    DROP ID Age Sex;
    RENAME Name = HouseholderName;
RUN;

/* INPUT statement with column indicators */
DATA StudentGrades;
    INFILE '/home/u63368964/source/student-grades.dat';
    INPUT StudentID $ 1-4 Name $ 6-20 Math Science English;
RUN;

DATA StudentGrades2;
    INFILE '/home/u63368964/source/student-grades.dat';
    INPUT Name $ 6-20 Math Science StudentID $ 1-4 MathScore 21-22;
RUN;

/* INPUT statement with pointer controls */
/*
	@n:		Relocates cursor to the n-th column
	@'chr': Relocates cursor right after the character string.
	+n:		Moves the cursor to the n-th column after the current position.
	/: 		Moves the cursor to the next line.
	#n: 	Moves the cursor to the n-th line.
*/
DATA JulyTemperatures;
    INFILE '/home/u63368964/source/temperatures.dat';
    INPUT @'State:' State $ 
          @1 City $ 
          @'State:' +3 
          AvgHigh 2. AvgLow 2. 
          RecordHigh RecordLow;
RUN;

DATA HeightWeights;
    INFILE '/home/u63368964/source/height-weight.dat';
    INPUT FirstName $ LastName $
          / Age
          #3 Height Weight;
RUN;

/* Reading data based on conditions */
DATA MyData;
    INPUT Year 1-4 @;
        IF Year=1988 THEN INPUT Day 5-7 Amount 8-10;
        IF Year=1989 THEN INPUT Day 6-8 Amount 10-12;
    DATALINES;
19883.2149
19885.7614
1989 7.9 764
1989 6.8 875
;
RUN;

/* Data informats */
DATA Sales;
    INFILE '/home/u63368964/source/sales.dat';
    INPUT 
        SalesID $4. 
        Product $ 6-16 
        SalesDate MMDDYY10. 
        Amount COMMA8.2 
        @37 ProductWeight 4.2;
RUN;

/* Colon modifier */
DATA CarSales;
    INFILE '/home/u63368964/source/car-sales.dat';
    INPUT Month Day Year Model :$15. Color :$15. NumSales Price;
RUN;

/* Ampersand modifier */
DATA DogBreeds;
    INFILE '/home/u63368964/source/dog-breeds.dat';
    INPUT Breed &$50. AvgHeight AvgWeight Temper $;
RUN;

/* Tilde modifier */
DATA HeightWeights2;
    INFILE '/home/u63368964/source/height-weight-v2.txt' DLM=',' DSD;
    INPUT Name :$15. Age Sex $ Weight Height;
RUN;