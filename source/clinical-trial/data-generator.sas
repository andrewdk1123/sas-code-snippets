/* ========================================================================= */
/* SEMAGLUTIDE CLINICAL TRIAL DATABASE FOR PROC SQL PRACTICE                 */
/* ========================================================================= */

/* ========================================================================= */
/* Create new library named CT                                               */
/* Replace directory                                                         */
/* ========================================================================= */
LIBNAME CT "/home/u63368964/source/clinical-trial";

/* ========================================================================= */
/* 1. CLINICAL SITES TABLE                                                   */
/* ========================================================================= */
data ct.sites;
   input site_id site_name $ 6-30 city $ 31-42 state $ principal_investigator $ 50-70;
   datalines;
1    Metro Medical Center     New York       NY  Dr. Sarah Johnson
2    Pacific Research Inst    Los Angeles    CA  Dr. Michael Chen
3    Midwest Clinical Trials  Chicago        IL  Dr. Jennifer Davis
4    Southern Health Research Atlanta        GA  Dr. Robert Wilson
5    Mountain View Clinic     Denver         CO  Dr. Lisa Martinez
;
run;

/* ========================================================================= */
/* 2. SUBJECT DEMOGRAPHICS TABLE                                             */
/* ========================================================================= */
data ct.demographics;
   input subject_id site_id treatment_group $ age gender $ race $ baseline_weight baseline_hba1c diabetes_duration;
   datalines;
1001 1 Placebo  45 F White    89.5  8.2  5
1002 1 Placebo  52 M White    95.3  8.7  3
1003 1 Placebo  38 F Black    78.9  9.1  7
1004 1 Placebo  61 M Hispanic 102.1 8.5  4
1005 1 Placebo  49 F Asian    85.6  8.9  6
1006 1 1.0mg    43 M White    91.2  8.4  2
1007 1 1.0mg    55 F Black    88.7  9.3  8
1008 1 1.0mg    41 M Hispanic 96.8  8.1  3
1009 1 1.0mg    37 F White    82.4  8.8  5
1010 1 1.0mg    58 M Asian    99.5  8.6  4
1011 1 2.4mg    46 F White    87.3  8.3  6
1012 1 2.4mg    51 M Black    94.6  9.0  2
1013 1 2.4mg    39 F Hispanic 81.9  8.7  7
1014 1 2.4mg    44 M White    98.2  8.5  3
1015 1 2.4mg    56 F Asian    86.1  9.2  5
2001 2 Placebo  48 F White    92.7  8.6  4
2002 2 Placebo  53 M Black    88.4  8.9  6
2003 2 Placebo  42 F Hispanic 85.9  8.4  3
2004 2 Placebo  59 M White    101.3 8.8  8
2005 2 Placebo  35 F Asian    79.6  9.1  2
2006 2 1.0mg    47 M White    93.8  8.2  5
2007 2 1.0mg    51 F Black    87.5  8.7  4
2008 2 1.0mg    40 M Hispanic 90.2  9.0  6
2009 2 1.0mg    45 F White    84.7  8.5  3
2010 2 1.0mg    57 M Asian    97.9  8.9  7
2011 2 2.4mg    44 F White    89.1  8.3  2
2012 2 2.4mg    49 M Black    95.4  8.6  5
2013 2 2.4mg    36 F Hispanic 82.8  9.2  4
2014 2 2.4mg    52 M White    99.7  8.4  8
2015 2 2.4mg    41 F Asian    86.9  8.8  3
3001 3 Placebo  46 F White    90.5  8.5  6
3002 3 Placebo  54 M Black    96.2  8.7  4
3003 3 Placebo  39 F Hispanic 83.7  9.0  2
3004 3 Placebo  58 M White    103.8 8.3  7
3005 3 Placebo  43 F Asian    81.4  8.9  5
3006 3 1.0mg    41 M White    88.6  8.6  3
3007 3 1.0mg    50 F Black    92.3  8.4  8
3008 3 1.0mg    37 M Hispanic 85.1  9.1  4
3009 3 1.0mg    56 F White    98.7  8.2  6
3010 3 1.0mg    44 M Asian    91.9  8.8  2
3011 3 2.4mg    48 F White    87.8  8.7  5
3012 3 2.4mg    53 M Black    94.1  8.5  7
3013 3 2.4mg    38 F Hispanic 80.6  9.3  3
3014 3 2.4mg    47 M White    97.4  8.1  4
3015 3 2.4mg    55 F Asian    89.7  8.9  6
4001 4 Placebo  45 F White    91.8  8.4  3
4002 4 Placebo  52 M Black    87.9  8.8  5
4003 4 Placebo  40 F Hispanic 84.2  9.2  7
4004 4 Placebo  59 M White    100.5 8.6  4
4005 4 Placebo  36 F Asian    78.3  8.7  2
4006 4 1.0mg    43 M White    93.4  8.3  6
4007 4 1.0mg    48 F Black    89.7  8.9  8
4008 4 1.0mg    41 M Hispanic 86.8  8.5  3
4009 4 1.0mg    54 F White    95.1  8.7  5
4010 4 1.0mg    38 M Asian    82.9  9.0  4
4011 4 2.4mg    46 F White    88.4  8.2  7
4012 4 2.4mg    51 M Black    96.7  8.6  2
4013 4 2.4mg    39 F Hispanic 83.5  8.8  6
4014 4 2.4mg    57 M White    101.2 8.4  3
4015 4 2.4mg    42 F Asian    87.6  9.1  5
5001 5 Placebo  47 F White    89.9  8.7  4
5002 5 Placebo  55 M Black    94.3  8.5  8
5003 5 Placebo  41 F Hispanic 81.7  9.0  2
5004 5 Placebo  60 M White    98.6  8.3  6
5005 5 Placebo  37 F Asian    86.2  8.8  3
5006 5 1.0mg    44 M White    92.1  8.6  5
5007 5 1.0mg    49 F Black    85.8  8.4  7
5008 5 1.0mg    42 M Hispanic 91.5  8.9  4
5009 5 1.0mg    53 F White    97.2  8.2  2
5010 5 1.0mg    39 M Asian    84.6  8.7  6
5011 5 2.4mg    45 F White    90.3  8.5  3
5012 5 2.4mg    50 M Black    93.7  8.8  8
5013 5 2.4mg    38 F Hispanic 82.1  9.2  5
5014 5 2.4mg    56 M White    99.8  8.1  4
5015 5 2.4mg    43 F Asian    88.9  8.6  7
;
run;

/* ========================================================================= */
/* 3. VISIT SCHEDULE TABLE                                                   */
/* ========================================================================= */
data ct.visits;
   input subject_id visit_week visit_date :date9. weight systolic_bp diastolic_bp compliance_pct;
   format visit_date date9.;
   datalines;
1001 0  01JAN2024  89.5  142  89  100
1001 1  08JAN2024  89.7  144  91  98
1001 2  15JAN2024  89.3  141  88  95
1001 3  22JAN2024  89.8  145  90  97
1001 4  29JAN2024  89.4  143  89  100
1001 5  05FEB2024  89.6  142  87  96
1001 6  12FEB2024  89.1  140  88  98
1001 7  19FEB2024  89.9  144  91  94
1001 8  26FEB2024  89.2  141  86  99
1001 9  04MAR2024  89.7  143  89  97
1001 10 11MAR2024  89.0  139  87  100
1001 11 18MAR2024  89.5  142  90  95
1001 12 25MAR2024  88.9  140  88  98
1001 13 01APR2024  89.3  141  89  96
1001 14 08APR2024  89.1  138  86  99
1001 15 15APR2024  89.6  143  90  97
1001 16 22APR2024  89.0  139  87  100
1002 0  01JAN2024  95.3  138  85  100
1002 1  08JAN2024  95.1  140  87  99
1002 2  15JAN2024  95.4  139  86  96
1002 3  22JAN2024  94.9  137  84  98
1002 4  29JAN2024  95.2  141  88  97
1002 5  05FEB2024  94.8  138  85  100
1002 6  12FEB2024  95.0  139  86  95
1002 7  19FEB2024  94.7  136  83  99
1002 8  26FEB2024  95.1  140  87  96
1002 9  04MAR2024  94.6  137  84  98
1002 10 11MAR2024  94.9  138  85  100
1002 11 18MAR2024  94.5  135  82  94
1002 12 25MAR2024  94.8  139  86  97
1002 13 01APR2024  94.3  136  83  99
1002 14 08APR2024  94.7  138  85  96
1002 15 15APR2024  94.4  137  84  98
1002 16 22APR2024  94.2  135  82  100
;
run;

/* Generate remaining visit data programmatically */
data ct.visits_full;
   set ct.visits;
run;

/* Add more visit data for other subjects (sample for demonstration) */
data ct.additional_visits;
   /* Placebo group - minimal weight loss */
   do subject_id = 1003, 1004, 1005, 2001, 2002, 2003, 2004, 2005, 3001, 3002, 3003, 3004, 3005, 
                   4001, 4002, 4003, 4004, 4005, 5001, 5002, 5003, 5004, 5005;
      baseline_wt = 80 + ranuni(123) * 25; /* Random baseline between 80-105 kg */
      do visit_week = 0 to 16;
         visit_date = '01JAN2024'd + 7 * visit_week;
         /* Placebo: minimal change, slight increase over time */
         weight = baseline_wt + ranuni(subject_id + visit_week) * 2 - 1;
         systolic_bp = 135 + round(ranuni(subject_id * 2) * 15);
         diastolic_bp = 82 + round(ranuni(subject_id * 3) * 12);
         compliance_pct = 95 + round(ranuni(subject_id * 4) * 10) - 5;
         output;
      end;
   end;
   
   /* 1.0mg group - moderate weight loss */
   do subject_id = 1006, 1007, 1008, 1009, 1010, 2006, 2007, 2008, 2009, 2010, 3006, 3007, 3008, 3009, 3010,
                   4006, 4007, 4008, 4009, 4010, 5006, 5007, 5008, 5009, 5010;
      baseline_wt = 80 + ranuni(456) * 25;
      do visit_week = 0 to 16;
         visit_date = '01JAN2024'd + 7 * visit_week;
         /* 1.0mg: 5-10% weight loss over 16 weeks */
         weight_loss_factor = (visit_week / 16) * (0.05 + ranuni(subject_id) * 0.05);
         weight = baseline_wt * (1 - weight_loss_factor) + ranuni(subject_id + visit_week) * 1.5 - 0.75;
         systolic_bp = 130 + round(ranuni(subject_id * 2) * 20) - 5;
         diastolic_bp = 80 + round(ranuni(subject_id * 3) * 15) - 3;
         compliance_pct = 93 + round(ranuni(subject_id * 4) * 14) - 7;
         output;
      end;
   end;
   
   /* 2.4mg group - significant weight loss */
   do subject_id = 1011, 1012, 1013, 1014, 1015, 2011, 2012, 2013, 2014, 2015, 3011, 3012, 3013, 3014, 3015,
                   4011, 4012, 4013, 4014, 4015, 5011, 5012, 5013, 5014, 5015;
      baseline_wt = 80 + ranuni(789) * 25;
      do visit_week = 0 to 16;
         visit_date = '01JAN2024'd + 7 * visit_week;
         /* 2.4mg: 10-15% weight loss over 16 weeks */
         weight_loss_factor = (visit_week / 16) * (0.10 + ranuni(subject_id) * 0.05);
         weight = baseline_wt * (1 - weight_loss_factor) + ranuni(subject_id + visit_week) * 2 - 1;
         systolic_bp = 125 + round(ranuni(subject_id * 2) * 25) - 8;
         diastolic_bp = 78 + round(ranuni(subject_id * 3) * 18) - 5;
         compliance_pct = 91 + round(ranuni(subject_id * 4) * 18) - 9;
         output;
      end;
   end;
   format visit_date date9.;
run;

/* Combine all visits */
proc sort data=ct.visits;
    by subject_id visit_week;
run;

proc sort data=ct.additional_visits;
    by subject_id visit_week;
run;

data ct.visits_combined;
   set ct.visits ct.additional_visits;
   by subject_id visit_week;
run;

proc sort data=ct.visits_combined;
   by subject_id visit_week;
run;

/* Keep only the generated data (remove manual entries) */
data ct.visits;
   set additional_visits;
run;

/* ========================================================================= */
/* 4. LAB RESULTS TABLE                                                      */
/* ========================================================================= */
data ct.lab_results;
   set ct.visits;
   /* Generate HbA1c values based on treatment group and visit */
   subject_str = put(subject_id, 4.);
   site_id = input(substr(subject_str, 1, 1), 1.);
   
   /* Determine treatment group based on subject_id pattern */
   if mod(subject_id, 15) in (1,2,3,4,5) then treatment_group = 'Placebo';
   else if mod(subject_id, 15) in (6,7,8,9,10) then treatment_group = '1.0mg';
   else treatment_group = '2.4mg';
   
   /* Generate HbA1c based on treatment response */
   if treatment_group = 'Placebo' then do;
      hba1c = 8.5 + ranuni(subject_id * 100) * 1.0 - 0.5; /* Minimal change */
   end;
   else if treatment_group = '1.0mg' then do;
      reduction = (visit_week / 16) * (0.5 + ranuni(subject_id) * 0.3);
      hba1c = 8.5 - reduction + ranuni(subject_id * 10) * 0.4 - 0.2;
   end;
   else do; /* 2.4mg */
      reduction = (visit_week / 16) * (0.8 + ranuni(subject_id) * 0.4);
      hba1c = 8.5 - reduction + ranuni(subject_id * 20) * 0.3 - 0.15;
   end;
   
   /* Generate other lab values */
   fasting_glucose = 140 + ranuni(subject_id * 30) * 60 - 30;
   if treatment_group ne 'Placebo' then 
      fasting_glucose = fasting_glucose - (visit_week / 16) * (20 + ranuni(subject_id) * 15);
   
   triglycerides = 180 + ranuni(subject_id * 40) * 120 - 60;
   hdl_cholesterol = 45 + ranuni(subject_id * 50) * 25;
   ldl_cholesterol = 120 + ranuni(subject_id * 60) * 60 - 30;
   
   /* Only keep lab results for weeks 0, 4, 8, 12, 16 */
   if visit_week in (0, 4, 8, 12, 16);
   
   keep subject_id visit_week visit_date hba1c fasting_glucose triglycerides hdl_cholesterol ldl_cholesterol;
run;

/* ========================================================================= */
/* 5. ADVERSE EVENTS TABLE                                                   */
/* ========================================================================= */
data ct.adverse_events;
   input subject_id ae_term $ 6-30 severity $ 31-40 start_date :date9. end_date :date9. related_to_drug :$3.;
   format start_date end_date date9.;
   datalines;
1008 Nausea                   Mild      15JAN2024 22JAN2024 Yes
1009 Diarrhea                 Moderate  08FEB2024 15FEB2024 Yes
1011 Nausea                   Mild      08JAN2024 29JAN2024 Yes
1012 Vomiting                 Moderate  22JAN2024 05FEB2024 Yes
1013 Decreased appetite       Mild      05FEB2024 26FEB2024 Yes
1014 Nausea                   Severe    15JAN2024 12FEB2024 Yes
2007 Diarrhea                 Mild      29JAN2024 05FEB2024 Yes
2008 Nausea                   Moderate  12FEB2024 19FEB2024 Yes
2011 Injection site reaction  Mild      08JAN2024 15JAN2024 Yes
2012 Nausea                   Mild      22JAN2024 04MAR2024 Yes
2013 Vomiting                 Moderate  05FEB2024 12FEB2024 Yes
3006 Diarrhea                 Mild      15JAN2024 22JAN2024 Yes
3011 Nausea                   Moderate  08JAN2024 19FEB2024 Yes
3012 Decreased appetite       Mild      29JAN2024 26FEB2024 Yes
3014 Injection site reaction  Mild      12FEB2024 19FEB2024 Yes
4007 Nausea                   Mild      22JAN2024 29JAN2024 Yes
4008 Diarrhea                 Moderate  05FEB2024 19FEB2024 Yes
4011 Vomiting                 Severe    15JAN2024 04MAR2024 Yes
4013 Nausea                   Mild      26FEB2024 11MAR2024 Yes
5006 Diarrhea                 Mild      08FEB2024 15FEB2024 Yes
5011 Nausea                   Moderate  15JAN2024 05FEB2024 Yes
5012 Decreased appetite       Mild      29JAN2024 18MAR2024 Yes
1003 Headache                 Mild      12FEB2024 19FEB2024 No
2004 Upper respiratory inf    Moderate  26FEB2024 11MAR2024 No
3002 Headache                 Mild      05FEB2024 12FEB2024 No
4005 Fatigue                  Mild      18MAR2024 25MAR2024 No
5003 Back pain                Moderate  04MAR2024 18MAR2024 No
;
run;

/* ========================================================================= */
/* 6. SUMMARY STATISTICS AND EXAMPLE QUERIES                               */
/* ========================================================================= */

title "Sample Database Structure and Content Summary";

proc sql;
   title2 "Sites Table";
   select * from ct.sites;
   
   title2 "Subject Count by Site and Treatment";
   select site_id, treatment_group, count(*) as n_subjects
   from ct.demographics
   group by site_id, treatment_group
   order by site_id, treatment_group;
   
   title2 "Demographics Summary";
   select treatment_group, 
          count(*) as n_subjects,
          mean(age) as mean_age format=6.1,
          mean(baseline_weight) as mean_baseline_weight format=6.1,
          mean(baseline_hba1c) as mean_baseline_hba1c format=6.2
   from ct.demographics
   group by treatment_group;
   
   title2 "Visit Completion Rates";
   select visit_week, count(*) as n_visits
   from ct.visits
   group by visit_week
   order by visit_week;
   
   title2 "Adverse Events Summary";
   select related_to_drug, severity, count(*) as n_events
   from ct.adverse_events
   group by related_to_drug, severity
   order by related_to_drug, severity;
quit;

/* ========================================================================= */
/* 7. EXAMPLE PROC SQL PRACTICE QUERIES                                    */
/* ========================================================================= */

title "Example PROC SQL Practice Queries";

proc sql;
   title2 "1. Weight Change from Baseline by Treatment Group";
   select d.treatment_group,
          v1.subject_id,
          v1.weight as baseline_weight,
          v2.weight as final_weight,
          v2.weight - v1.weight as weight_change,
          ((v2.weight - v1.weight) / v1.weight) * 100 as percent_change format=6.1
   from demographics d
   inner join visits v1 on d.subject_id = v1.subject_id and v1.visit_week = 0
   inner join visits v2 on d.subject_id = v2.subject_id and v2.visit_week = 16
   order by d.treatment_group, weight_change;
   
   title2 "2. HbA1c Change by Treatment Group";
   select d.treatment_group,
          count(*) as n_subjects,
          mean(l1.hba1c) as baseline_hba1c format=6.2,
          mean(l2.hba1c) as final_hba1c format=6.2,
          mean(l2.hba1c - l1.hba1c) as mean_change format=6.2
   from ct.demographics d
   inner join ct.lab_results l1 on d.subject_id = l1.subject_id and l1.visit_week = 0
   inner join ct.lab_results l2 on d.subject_id = l2.subject_id and l2.visit_week = 16
   group by d.treatment_group;
   
   title2 "3. Subjects with Significant Weight Loss (>5%)";
   select d.treatment_group,
          d.subject_id,
          s.site_name,
          d.age,
          d.gender,
          ((v2.weight - v1.weight) / v1.weight) * 100 as percent_weight_change format=6.1
   from ct.demographics d
   inner join ct.sites s on d.site_id = s.site_id
   inner join ct.visits v1 on d.subject_id = v1.subject_id and v1.visit_week = 0
   inner join ct.visits v2 on d.subject_id = v2.subject_id and v2.visit_week = 16
   where ((v2.weight - v1.weight) / v1.weight) * 100 < -5
   order by percent_weight_change;
quit;