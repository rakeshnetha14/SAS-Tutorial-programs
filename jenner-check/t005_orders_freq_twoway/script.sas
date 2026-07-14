* one-way and crosstab frequency tables (Chapter4.sas, orders);
Data orders;
	INPUT Coffee $ Window $ @@;
	DATALINES;
Espresso Drive Latte Walk Espresso Walk Mocha Drive Latte Drive
Mocha Walk Espresso Drive Latte Walk Mocha Drive Espresso Walk
;
RUN;

PROC FREQ DATA=orders;
	TABLES Window Window * Coffee;
Run;
