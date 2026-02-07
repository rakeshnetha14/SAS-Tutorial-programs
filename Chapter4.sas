* The little SAS book - Primer, Chapter4;

Data artists;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Artists.csv' DLM=',' Dsd MISSOVER FIRSTOBS=2;
	INPUT Name :$25. Genre :$20. Origin :$2. ;
Run;

Proc Print Data=artists;
	WHERE Genre= 'Impressionism';
	FOOTNOTE 'F=France N=Netherlands U=US';
Run;

Data marine;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Lengths.dat';
	INPUT Name $ Family $ Length @@;
Run;

Proc sort data=marine OUT=seasort NODUPKEY;
	BY Family DESCENDING Length;
Proc Print Data=seasort;
Title 'Whales and Sharks';
Run;

Data addresses;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Mail.txt' DLM='09'X DSD FIRSTOBS=2;
	INPUT Name :$6. Street :$18. City :$9. State :$6.;
Run;

Proc Sort Data=addresses out=sortone SORTSEQ=LINGUISTIC (NUMERIC_COLLATION=ON);
	BY Street;
Proc print data=sortone;
Run;

Proc sort Data=addresses OUT=sorttwo SORTSEQ=LINGUISTIC (STRENGTH=PRIMARY);
	BY State;
PROC PRint DATA=sorttwo;
Run;

Data Sales;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/CookieSales.dat';
	INPUT Name $ Class DateReturned MMDDYY10. CandyType $ Quantity @@;
	Profit = Quantity * 1.25;
Run;

Proc print data=sales;
	VAR Name DateReturned CandyTYpe Profit;
	FORMAT DateReturned DATE9. Profit DOLLAR6.2;
	Title 'Cookie Sales Data Using Formats';
Run;

Data cars_format;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Cars.csv' DLM=',' DSD FIRSTOBS=2;
	INPUT Age :3. Sex :2. Income :10. Color :$3. ;
Run;

Proc Format;
	VALUE gender 1 = 'Male'
				2 = 'Female';
	VALUE agegroup 13 -< 20 = 'Teen'
					20 <- 65 = 'Adult'
					65 - HIGH = 'Senior';
	VALUE $col 'W' = 'Moon White'
				'B' = 'Sky Blue'
				'Y' = 'Sunburst Yellow'
				'G' = 'Rain Cloud Gray';

Proc print data=cars_format;
	FORMAT Sex gender. Age agegroup. Color $col. Income DOLLAR8.;
	Title 'Car Survey with user defined Formats';
Run;

Data _NULL_;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/CookieSales.dat';
	INPUT Name $ Class DateReturned MMDDYY10. CandyType $ Quantity @@;
	Profit = Quantity * 1.25;
	FILE '/home/u64445632/sasuser.v94/Chapter2/Student.txt' PRINT;
	TITLE;
	
	PUT @5 'Cookie sales report for ' Name 'from classroom' Class
	// @5 'Congratulations! You sold' Quantity 'boxes of candy' 
	/ @5 'and earned' Profit DOLLAR6.2 'for our field trip.';
	PUT _PAGE_;
Run;

Data flowers;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Flowers.dat';
	INPUT CustID $ @9 SalesDate MMDDYY10. Petunia SnapDragon Marigold;
	Month = MONTH(SalesDate);

PROC SORT DATA=flowers;
	By Month;
* Claculate means by Month for flower sales;
PROC MEANS DATA=flowers MAXDEC=0;
	By Month;
	VAR Petunia SnapDragon Marigold;
	Title 'Summary of Flower Sales by Month';
Run;

Data flowers;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Flowers.dat';
	INPUT CustID $ @9 SalesDate MMDDYY10. Petunia SnapDragon Marigold;
PROC SORT DATA=flowers;
	By CustID;

PROC MEANS NOPRINT DATA=flowers;
	BY CustID;
	VAR Petunia SnapDragon Marigold;
	OUTPUT OUT = totals
		MEAN(Petunia SnapDragon Marigold) = MeanP MeanSD MeanM
		SUM(Petunia SnapDragon Marigold) = Petunia SnapDragon Marigold;

PROC PRINT DATA=totals;
	FORMAT MeanP MeanSD MEanM 3.;
Run;

Data orders;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Coffee.dat';
	INPUT Coffee $ Window $ @@;
* Print tables for window and window by coffee;
PROC FREQ DATA=orders;
	TABLES Window Window * Coffee;
Run;

DATA boats;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Boats.txt' DLM='09'X DSD FIRSTOBS=2;
	INPUT Name :$13. Port :$10. Locomotion :$5. Type :$4. Price :5. Length :5. ;
Run;
*Tabulation with three dimensions;
PROC TABULATE DATA=boats;
	CLASS Port Locomotion Type;
	TABLE Port, Locomotion, Type;
	TITLE 'Number of Boats by Port, Locomotion, and Type';
Run;

PROC TABULATE DATA=boats;
	CLASS Locomotion Type;
	VAR Price;
	TABLE Locomotion ALL, MEAN*Price*(Type ALL);
Run;

PROC TABULATE DATA=boats FORMAT=DOLLAR9.2;
	CLASS Locomotion Type;
	VAR Price;
	TABLE Locomotion ALL, MEAN*Price*(Type ALL)
	/BOX='Full Day Excursions' MISSTEXT='none' ;
Run;

PROC FORMAT;
	VALUE $typ 'cat'='catamaran'
				'sch'='schooner'
				'yac'='yacht';

PROC TABULATE Data=boats FORMAT=DOLLAR9.2;
	CLASS Locomotion Type;
	VAR Price;
	FORMAT Type $typ.;
	TABLE Locomotion='' ALL, 
		MEAN=''*Price='Mean Price by Type'*(Type='' ALL)
		/BOX ='Full Day Excursions' MISSTEXT='none';
Run;

* USing the FORMAT= option in TABLE statement;
PROC TABULATE Data=boats;
	CLASS Locomotion Type;
	VAR Price Length;
	*FORMAT Type $typ.;
	TABLE Locomotion= ALL, 
		MEAN*(Price*FORMAT=DOLLAR7.2 Length*FORMAT=2.0) * (Type='' ALL);
Run;

DATA natparks;
	INFILE '/home/u64445632/sasuser.v94/Chapter2/Parks.dat';
	INPUT Name $ 1-21 Type $ Region $ Museums Camping;
Run;

PROC REPORT DATA=natparks NOWINDOWS;
	Title 'Report with character and numeric variables';
Run;
PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Museums Camping;
	TITLE 'Report with only Numeric variables'
Run;

* PROC REPORT with ORDER variable, MISSING option, and Column header;

PROC REPORT DATA=natparks NOWINDOWS MISSING;
	COLUMNS Region Name Museums Camping;
	DEFINE Region / ORDER;
	DEFINE Camping / ANALYSIS 'Campgrounds';
	Title 'National parks and monuments arranged by region';
Run;

* Region and Type as GROUP variables;
PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Region Type Museums Camping;
	DEFINE Region / GROUP;
	DEFINE Type / GROUP;
Run;

PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Region Type,(Museums Camping);
	DEFINE Region / Group;
	DEFINE Type / ACROSS;
Run;

* PROC REPORT with breaks;
PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Region Type Museums Camping;
	DEFINE Region / ORDER;
	BREAK AFTER Region / SUMMARIZE;
	RBREAK AFTER / SUMMARIZE;
	TITLE 'Detail Report with Summary Breaks'
Run;

* statistics in COLUMN statement with two group variables;
PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Region Type N (Museums Camping),MEAN;
	Define Region / GROUP;
	DEFINE TYpe / GROUP;
Run;

PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Region N Type,(Museums Camping),MEAN;
	DEFINE Region / GROUP;
	DEFINE Type / ACROSS;
Run;

* COMPUTE new variables that are numeric and character;
PROC REPORT DATA=natparks NOWINDOWS;
	COLUMN Name Region Museums Camping Facilities Note;
	DEFINE Museums / ANALYSIS SUM NOPRINT;
	DEFINE Camping / ANALYSIS SUM NOPRINT;
	DEFINE Facilities / COMPUTED 'Camping/and/Museums';
	DEFINE Note / COMPUTED;
	COMPUTE Facilities;
		Facilities = Museums.SUM + Camping.SUM;
	ENDCOMP;
	COMPUTE Note / CHAR LENGTH = 10;
		IF Camping.SUM =0 THEN Note ='No camping';
	ENDCOMP;
	TITLE 'REport with Two Computed Variables';
Run;

