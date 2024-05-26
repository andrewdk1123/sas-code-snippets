/* Create example data sets */
DATA SetOne;
    INPUT VarA VarB;
    CARDS;
1 5
2 6
3 7
4 8
;

DATA SetTwo;
    INPUT VarC VarD;
    CARDS;
9  15
10 16
11 17
12 18
13 19
14 20
;

DATA SetThree;
    INPUT VarA VarB VarE;
    CARDS;
21 24 29
22 25 30
23 26 31
1  27 32
2  28 33
;

/* Vertical concatenation of two data sets */
DATA VerticalConcat;
    SET SetOne SetTwo;
RUN;

DATA VerticalConcat2;
    SET SetOne SetThree;
RUN;

/* Horizontal concatenation of two data sets */
DATA HorizontalConcat;
    SET SetOne;
    SET SetTwo;
RUN;

DATA HorizontalConcat2;
    SET SetOne;
    SET SetThree;
RUN;

/* Interleaving */
PROC SORT DATA=SetThree;
    BY VarA;
RUN;

DATA Interleaving;
    SET SetOne SetThree;
    BY VarA;
RUN;

/* Match-merging by SET */
DATA MatchMergeBySet;
    SET SetOne;
    SET SetThree;
    BY VarA;
RUN;

/* One-to-one merge */
DATA OneToOneMerge;
    MERGE SetOne SetTwo;
RUN;

/* Match-merging by MERGE */
DATA MatchMerge;
    MERGE SetOne SetThree;
    BY VarA;
RUN;

/* UPDATE statement */
DATA MasterSet;
    INPUT VarA VarB VarC $;
    CARDS;
1 11 C1
2 12 C2
3 13 C3
4 14 C4
;

DATA TransactSet;
    INPUT VarA VarB VarE VarC $;
    CARDS;
5 15 21 C5 
6 .  22 C6
7 17 23 C7
8 18 .  C8
1 .  24 .
2 19 25 .
3 20 26 C3
;

PROC SORT DATA=TransactSet;
    BY VarA;
RUN;

/* Update by VarA */
DATA UpdateMaster;
    UPDATE MasterSet TransactSet;
    BY VarA;
RUN;