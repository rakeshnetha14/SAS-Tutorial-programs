* recoding with parallel ARRAYs and a variable-list range (Chapter3_code.sas, songs1);
Data songs1;
	INPUT City :$15. Age wj kt tr filp ttr;
	ARRAY new (5) Song1 - Song5;
	ARRAY old (5) wj -- ttr;
	DO i = 1 to 5;
		IF old(i) = 9 THEN new(i)=.;
			ELSE new(i) = old(i);
	END;
	AvgScore = MEAN(OF Song1 - Song5);
	DATALINES;
Austin 34 5 4 9 3 5
Dallas 28 9 9 2 4 6
Houston 41 3 5 7 9 2
;
RUN;

PROC Print Data=songs1;
Run;
