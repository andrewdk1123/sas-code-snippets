/* Import data: Seoul Bike Sharing */
PROC FORMAT;
    VALUE Fmt_Binary 0 = "No"
                     1 = "Yes";
RUN;

DATA MyData.BikeSharing;
    INFILE '/home/u63368964/source/seoul-bike-sharing.csv' DLM=',' FIRSTOBS=2;
    INPUT 
        Date :ANYDTDTE10. Hour 
        Temperature Humidity WindSpeed Visibility DewPoint SolarRadiation Rainfall Snowfall 
        Season $
        IsHoliday IsOperatingDay RentedBikes;
    DateTime = DHMS(Date, Hour, 0, 0);
    FORMAT 
        Date DATE9. DateTime DATETIME13. 
        IsHoliday Fmt_Binary. IsOperatingDay Fmt_Binary.;
    LABEL 
        Temperature = "In °C" 
        Humidity = "In %" 
        WindSpeed = "In m/s"
        Visibility = "In 10m"
        DewPoint = "In °C"
        SolarRadiation = "In MJ/m2"
        Rainfall = "In mm"
        Snowfall = "In cm";
RUN;

DATA BikeSharing;
    SET MyData.BikeSharing;
    IF IsOperatingDay = 0 THEN DELETE;
RUN;

/* Suppose that BikeSharing is the population of interest */
PROC SGPLOT DATA=BikeSharing;
    TITLE "Bike Rental Distribution";
    HISTOGRAM RentedBikes;
RUN;

PROC SORT DATA=BikeSharing;
    BY Season IsHoliday;
RUN;

PROC FREQ DATA=BikeSharing;
    TABLES Season * IsHoliday;
RUN;

/* Stratified sampling 0.1% from each group */
PROC SURVEYSELECT DATA=BikeSharing METHOD=SRS SAMPRATE=0.001 SEED=1123 OUT=Sample_0001;
    TITLE1 "Bike Rental Sample";
    TITLE2 "Sampling Rate: 0.001";
    STRATA Season IsHoliday;
RUN;

PROC MEANS DATA=Sample_0001;
    TITLE1;
    TITLE2;
    VAR RentedBikes;
RUN;

/* Select another sample with different seed */
PROC SURVEYSELECT DATA=BikeSharing METHOD=SRS SAMPRATE=0.001 SEED=2234 OUT=Sample_0001_v2;
    TITLE1 "Bike Rental Sample";
    TITLE2 "Sampling Rate: 0.001";
    STRATA Season IsHoliday;
RUN;

PROC MEANS DATA=Sample_0001_v2;
    TITLE1;
    TITLE2;
    VAR RentedBikes;
RUN;

/* Generate 1,000 different samples */
%MACRO seed_generator;
    DATA _NULL_; 
        T=TIME(); 
        X=RANUNI(0); 
        Seed=X*(2**31-1); 
        CALL SYMPUT('sampling_seed', Seed); 
    RUN;
%MEND seed_generator;

%MACRO stratified_sampling(sampling_rate, sampling_seed);
    PROC SURVEYSELECT DATA=BikeSharing 
                      METHOD=SRS SAMPRATE=&sampling_rate SEED=&sampling_seed 
                      OUT=SampleStratified NOPRINT;
        STRATA Season IsHoliday;
    RUN;
%MEND;

%MACRO repeat_sampling(num_samples, sampling_rate);
    DATA SamplingDist;
        ATTRIB
        _FREQ_ LABEL="Sample Size"
        RentedBikes LABEL="Sample Mean";
        STOP;
    RUN;

    %DO i=1 %TO &num_samples;
        %seed_generator;
        %stratified_sampling(&sampling_rate, &sampling_seed);
        PROC MEANS DATA=SampleStratified NOPRINT;
            VAR RentedBikes;
            OUTPUT OUT=SampleMean(WHERE=(_STAT_='MEAN'));
        RUN;
        
        DATA SamplingDist;
            SET SamplingDist SampleMean;
            DROP _STAT_ _TYPE_;
        RUN;
    %END;
%MEND repeat_sampling;

%repeat_sampling(1000, 0.001);

PROC MEANS DATA=SamplingDist MEAN MAXDEC=0;
    TITLE "1,000 Different Sample Means";
RUN;

PROC PRINT DATA=SamplingDist;
    TITLE;
RUN;

/* Distribution of Population */
PROC SGPLOT DATA=BikeSharing;
    HISTOGRAM RentedBikes / SCALE=COUNT;
RUN;

/* Distribution of Sample Means */
PROC SGPLOT DATA=SamplingDist;
    HISTOGRAM RentedBikes / SCALE=COUNT;
    DENSITY RentedBikes / TYPE=NORMAL;
    XAXIS LABEL = "Sample Means";
RUN;

%MACRO sampling_distribution_by_size(sampling_rate);
    %repeat_sampling(1000, &sampling_rate);
    PROC SGPLOT DATA=SamplingDist;
        TITLE "Sampling Rate: &sampling_rate";
        HISTOGRAM RentedBikes / SCALE=COUNT;
        DENSITY RentedBikes / TYPE=NORMAL;
        XAXIS LABEL = "Sample Means" MIN=0 MAX=4000;
    RUN;
%MEND;

%sampling_distribution_by_size(0.001);
%sampling_distribution_by_size(0.01);
%sampling_distribution_by_size(0.1);