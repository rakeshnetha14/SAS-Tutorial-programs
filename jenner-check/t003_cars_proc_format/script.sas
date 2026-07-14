* user-defined formats with numeric ranges and a character map (Chapter4.sas, cars_format);
Data cars_format;
	INPUT Age :3. Sex :2. Income :10. Color :$3. ;
	DATALINES;
25 1 45000 W
52 2 88000 B
17 1 12000 Y
70 2 33000 G
;
RUN;

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
RUN;

Proc print data=cars_format;
	FORMAT Sex gender. Age agegroup. Color $col. Income DOLLAR8.;
	Title 'Car Survey with user defined Formats';
Run;
