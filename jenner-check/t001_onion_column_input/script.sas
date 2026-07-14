* reading using column input (Chapter2_code.sas, Onion_rings);
DATA Onion_rings;
	INPUT VisitingTeam $ 1-20 ConcessionSales 21-24 BleacherSales 25-28 OutHits 29-31 TheirHits 32-34 OurScore 35-37 TheirScore 38-40;
	DATALINES;
Red Sox             1200 340 12 8  5  3
Yankees             2200 560 15 11 7  6
Blue Jays           980  210 9  10 2  4
Orioles             1500 400 11 9  6  5
Rays                1100 300 8  7  3  2
;
RUN;

Proc Print DATA=Onion_rings;
	Title 'Onion Sales Data';
Run;
