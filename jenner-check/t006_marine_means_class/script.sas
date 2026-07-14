* grouped summary statistics with PROC MEANS and CLASS (Chapter5.sas, marine);
DATA marine;
	INPUT Name $ Family $ Length @@;
	DATALINES;
Beluga Whale 15 Orca Whale 25 Mako Shark 12 Whale_Shark Shark 40
Great_White Shark 20 Blue Whale 30 Nurse Shark 10 Minke Whale 22
;
RUN;

PROC MEANS DATA=marine MEAN MIN MAX;
	CLASS Family;
	Title 'Whales and Sharks';
Run;

PROC PRINT DATA=marine;
Run;
