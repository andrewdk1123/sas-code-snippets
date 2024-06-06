/* List available style templates */
PROC TEMPLATE;
    LIST STYLES;
RUN;

/* Tracing and selcting procedure output */
DATA HeightWeight;
    INFILE '/home/u63368964/source/height-weight-v2.txt' DLM=',' DSD;
    INPUT Name :$15. Age Sex $ Weight Height;
RUN;

PROC SORT DATA=HeightWeight;
    BY Sex;
RUN;

ODS TRACE ON;
PROC MEANS DATA=HeightWeight;
    BY Sex;
RUN;
ODS TRACE OFF;

PROC MEANS DATA=HeightWeight;
    BY Sex;
ODS SELECT Means.ByGroup1.Summary;
RUN;

/* HTML output */
/*
Available options:
	CONTENT = 'path/to/content/file.html': Creates a table of contents with links to the body file.
	PAGE = 'path/to/page/file.html': Creates a table of contents with links by page number.
	FRAME = 'path/to/frame/file.html': Creates a frame that allows you to view the body file and the contents or the page file at the same time. If you do not want either the contents or the page file, then you don't need to create a frame file.
	STYLE = style-name: Specifies a style template. The default setting is STYLE=HTMLBLUE.
*/
ODS HTML STYLE=OCEAN 
    FILE='/home/u63368964/sasuser.v94/height-weight-body.html'
    FRAME='/home/u63368964/sasuser.v94/height-weight-frame.html'
    CONTENTS='/home/u63368964/sasuser.v94/height-weight-contents.html';

PROC MEANS DATA=HeightWeight;
    TITLE "Height and Weight by Sex";
    BY Sex;
RUN;

ODS TEXT='<div align="center">This is text after PROC MEANS output.</div>';
ODS HTML CLOSE;

/* RTF output */
/*
Available options:
	BODYTITLE: Puts title and footnotes in the main part of the RTF document instead of in Word headers or footers.
	COLUMNS = n: Requests columnar output where n is the number of columns.
	SASDATE: By default, the date and time that appear at the top of RTF output indicate when the file was last opened or printed in Word. This option tells SAS to use the date and time when the current SAS session or job started running.
	STARTPAGE = value: Controls page breaks. The default value, YES, inserts a page break between procedures. A value of NO turns off page breaks. A value of NOW inserts a page break at that point.
	STYLE = style-name: Specifies a style template. The default is RTF.
*/
ODS RTF FILE='/home/u63368964/sasuser.v94/height-weight.rtf' BODYTITLE STARTPAGE=NO;
ODS NOPROCTITLE;
PROC MEANS DATA=HeightWeight;
    TITLE 'Height and Weight by Sex';
    CLASS Sex;
RUN;

PROC PRINT DATA=HeightWeight;
RUN;

ODS RTF CLOSE;

/* PDF output */
/*
Available options:
	COLUMNS = n: Requests columnar output where n is the number of columns.
	STARTPAGE = value: Controls page breaks. The default value, YES, inserts a break between procedures. A value of NO turns off breaks. A value of NOW inserts a break at that point.
	STYLE = style-name: Specifies a style template. The default is PRINTER.
*/
ODS PDF FILE = '/home/u63368964/sasuser.v94/height-weight.pdf' STARTPAGE=NO;
ODS NOPROCTITLE;
PROC MEANS DATA=HeightWeight;
    TITLE 'Height and Weight by Sex';
    CLASS Sex;
RUN;

PROC PRINT DATA=HeightWeight;
RUN;

ODS PDF CLOSE;

/* ODS Graphics */
/*
Available options:
	HEIGHT = n: Specifies image height in CM, IN, MM, PT, or PX.
	WIDTH = n: Specifies image height in CM, IN, MM, PT, or PX.
	IMAGENAME = 'filename': Specifies the base image file name. It defaults to the name of its ODS output object.
	OUTPUTFMT = file-type: Specifies the graph format. Possible values include BMP, GIF, JPEG, PDF, PNG, PS, SVG, TIFF, and many others.
	RESET: Reset all options to their defaults.
*/

ODS LISTING GPATH='/home/u63368964/sasuser.v94' STYLE=JOURNAL;
ODS GRAPHICS / RESET
    IMAGENAME = 'HeightWeightScatterPlot'
    OUTPUTFMT=JPEG
    HEIGHT=640PX WIDTH=480PX;
PROC SGPLOT DATA=HeightWeight;
    SCATTER X=Height Y=Weight;
RUN;