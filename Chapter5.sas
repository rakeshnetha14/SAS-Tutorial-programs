PROC TEMPLATE;
	List STYLES;
RUN;

DATA giant;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/GiantTom.dat' DSD;
	INPUT Name :$15. Color $ Days Weight @@;
Run;

*TRACE PROC MEANS;
ODS TRACE ON;
PROC MEANS DATA=giant;
	BY Color;
RUN;
ODS TRACE OFF;

PROC MEANS DATA=giant;
	BY Color;
	ODS SELECT Means.ByGroup1.Summary;
RUN;

ODS TRACE ON;
PROC TABULATE DATA=giant;
	CLASS Color;
	VAR Days Weight;
	TABLE Color ALL, (Days Weight)*MEAN;
Run;
ODS TRACE OFF;

PROC TABULATE DATA=giant;
	CLASS Color;
	VAR Days Weight;
	TABLE Color ALL, (Days Weight)*MEAN;
	Title 'Standard TABULATE Output';
	ODS OUTPUT Table = tabout;
Run;
PROC PRINT DATA=tabout;
	Title 'OUTPUT SAS Data Set from TABULATE';
Run;

ODS LISTING;
ODS NOPROCTITLE;
DATA marine;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Lengths8.dat';
	INPUT Name $ Family $ Length @@;
Run;
PROC MEANS DATA=marine MEAN MIN MAX;
	CLASS Family;
	Title 'Whales and Sharks';
Run;
PROC PRINT DATA=marine;
Run;
	
* Create HTML files and remove procedure names;
ODS HTML STYLE=D3D BODY='/home/u64445632/sasuser.v94/Chapter2/Marine.HTML'
	FRAME='/home/u64445632/sasuser.v94/Chapter2/MarineFrame.HTML'
	ONTENTS='/home/u64445632/sasuser.v94/Chapter2/MarineTOC.HTML';
ODS NOPROCTITLE;
PROC MEANS DATA=marine MEAN MAX MIN;
	CLASS Family;
	Title 'Whales and Sharks';
Run;
PROC PRINT DATA=marine;
Run;
ODS HTML CLOSE;

ODS RTF FILE='/home/u64445632/sasuser.v94/Chapter2/Marine.rtf' BODYTITLE STARTPAGE=No;
ODS NOPROCTITLE;
PROC MEANS DATA=marine MEAN MAX MIN;
	CLASS Family;
	Title 'Whales and Sharks';
Run;
PROC PRINT DATA=marine;
Run;
ODS RTF CLOSE;

ODS PDF FILE='/home/u64445632/sasuser.v94/Chapter2/Marine.pdf' STARTPAGE=No;
ODS NOPROCTITLE;
PROC MEANS DATA=marine MEAN MAX MIN;
	CLASS Family;
	Title 'Whales and Sharks';
Run;
PROC PRINT DATA=marine;
Run;
ODS PDF CLOSE;

