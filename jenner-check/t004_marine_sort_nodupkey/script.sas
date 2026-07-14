* dedup-and-order with PROC SORT NODUPKEY and a DESCENDING key (Chapter4.sas, marine/seasort);
Data marine;
	INPUT Name $ Family $ Length @@;
	DATALINES;
Beluga Whale 15 Orca Whale 25 Mako Shark 12 Whale_Shark Shark 40
Great_White Shark 20 Blue Whale 30 Orca Whale 25 Nurse Shark 10
;
RUN;

Proc sort data=marine OUT=seasort NODUPKEY;
	BY Family DESCENDING Length;
RUN;

Proc Print Data=seasort;
	Title 'Whales and Sharks';
Run;
