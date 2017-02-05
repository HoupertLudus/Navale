program BaTaille_navale;

uses crt;

CONST
	Max = 10 ;					
	BateauMax = 5 ;				
	TailleMax = 6 ;				

//Debut de tout les types

Type
	Cellule = record
		Ligne : INTEGER ;
		Colonne : INTEGER ;
	END ;
	
Type
	Bateau = record
		n : Cellule ;
		Taille : INTEGER ;
		nom : STRING ;
	END ;
	
Type
	Flotte = record
		n1 : Bateau ;
	END ;
	
Type	
	Marge = record
		x : INTEGER ;
		y : INTEGER ;
	END ;

Type
	TabCellule = array [1..100] of Cellule ;
	TabBateau = array[1..100] of Bateau ;
	TabFlotte = array[1..BateauMax,1..100] of Flotte ;
	TabNom = array[1..8] of STRING ;
	Tab = array[1..20] of INTEGER ;

//Debut de toutes les procedure

PROCEDURE IniTabCellule(VAR PosCellule,CelluleTOuche:TabCellule);

VAR
	i : INTEGER ;
	
BEGIN
	FOR i := 1 TO Max DO
	BEGIN
		PosCellule[i].Colonne := 0 ;
		PosCellule[i].Ligne := 0 ;
		CelluleTOuche[i].Colonne := 0 ;
		CelluleTOuche[i].Ligne := 0 ;
	END;
END;

PROCEDURE IniTabFlotte(VAR Bateau:TabBateau; VAR Ensemble:TabFlotte);

VAR
	i : INTEGER ;
	j : INTEGER ;
BEGIN
	FOR i:=1 TO Max DO
	BEGIN
		Bateau[i].n.Colonne:=0;
		Bateau[i].n.Ligne:=0;
		FOR j:=1 TO BateauMax DO
		BEGIN
			Ensemble[j,i].n1.n.Colonne:=0;
			Ensemble[j,i].n1.n.Ligne:=0;
		END;
	END;
END;

PROCEDURE AfficheMap();

VAR
	cpt,i,j:INTEGER;

BEGIN
		cpt:=7;
	FOR i:=1 TO Max DO		
	BEGIN
		GoTOXY(cpt,5);
		WRITE(i);
		cpt:=cpt+4;
	END;
	
	
	cpt:=8;
	FOR i:=1 TO Max DO		
	BEGIN
		FOR j:=1 TO Max*3 DO
		BEGIN
			GoTOXY(3,cpt);
			WRITE(Chr(i+64));
		END;
		cpt:=cpt+3;
	END;
		
END;

PROCEDURE Clrtxt2();

VAR
	i,j:INTEGER;
BEGIN

	FOR i:=13 TO 29 DO
	BEGIN
		FOR j:=49 TO 71 DO
		BEGIN
			GoTOXY(j,i);
			WRITE(' ');
		END;
	END;

END;

PROCEDURE Clrtxt3();

VAR
	i,j:INTEGER;

BEGIN

	FOR i:=34 TO 35 DO
	BEGIN
		FOR j:=49 TO 85 DO
		BEGIN
			GoTOXY(j,i);
			WRITE(' ');
		END;
	END;

END;

//Debut de toute les fonctions
FUNCTION TestCaseLigne(Bateau:TabBateau;PosCellule:TabCellule;x,y,i:INTEGER):BOOLEAN;

VAR
	j:INTEGER;
	Test,Test2:BOOLEAN;

BEGIN
	Test:=false;
	Test2:=true;
	FOR j:=1 TO Bateau[i].Taille DO
	BEGIN
		IF (Bateau[j].n.Colonne<>PosCellule[y].Colonne) AND (Bateau[j].n.Ligne<>PosCellule[(x+(j-1))].Ligne) THEN
		BEGIN
			Test:=true;	
		END;
		
		IF Test=false THEN
		BEGIN
			Test2:=false;
		END;
	END;
	
	IF Test2=false THEN
	BEGIN
		Test:=false;
	END;
	
		TestCaseLigne:=Test;

END;

FUNCTION TestCaseColonne(Bateau:TabBateau;PosCellule:TabCellule;x,y,i:INTEGER):BOOLEAN;

VAR
	j:INTEGER;
	Test,Test2:BOOLEAN;

BEGIN

	Test:=false;	
	FOR j:=1 TO Bateau[i].Taille DO
	BEGIN
		IF (Bateau[j].n.Colonne<>PosCellule[(y+(j-1))].Colonne) AND (Bateau[j].n.Ligne<>PosCellule[x].Ligne) THEN
		BEGIN
			Test:=true;	
		END;
		
		IF Test=false THEN
		BEGIN
			Test2:=false;
		END;
	END;
	
	IF Test2=false THEN
	BEGIN
		Test:=false;
	END;

	TestCaseColonne:=Test;

END;

FUNCTION TestCase(Bateau:TabBateau; Ensemble:TabFlotte):BOOLEAN;

VAR
	i,j,l,k:INTEGER;
	Test:BOOLEAN;

BEGIN
	Test:=true;
	
	FOR i:=1 TO BateauMax DO
	BEGIN
		FOR j:=1 TO BateauMax DO
		BEGIN
			FOR k:=1 TO Bateau[i].Taille DO
			BEGIN
				FOR l:=1 TO Bateau[i].Taille DO
				BEGIN
					IF (Ensemble[i,k].n1.n.Ligne=Ensemble[j,l].n1.n.Ligne) AND (Ensemble[i,k].n1.n.Colonne=Ensemble[j,l].n1.n.Colonne) AND (j<>i) THEN
					BEGIN
						Test:=false;
					END;
				END;
			END;
		END;
	END;
	TestCase:=Test;
END;

FUNCTION one1(car:STRING):INTEGER;

BEGIN
		IF length(car)=1 THEN
		BEGIN
			IF(ord(car[1])>=48) AND (ord(car[1])<=57) THEN
			BEGIN
				one1:=ord(car[1])-48
			END
				ELSE
					BEGIN
					one1:=0;
					END;
		END
		ELSE
			IF length(car)=2 THEN
			BEGIN
				
				IF (ord(car[1])=49) AND (ord(car[2])=48)THEN
				BEGIN
					one1:=10
				END
					ELSE
					BEGIN
						one1:=0;
					END;
			END;
			
			
END;

FUNCTION a1(car:CHAR):INTEGER;

BEGIN
	IF(ord(car)>=97) AND (ord(car)<97+Max) THEN
	BEGIN	
		a1:=ord(car)-96
	END
		ELSE
			a1:=11;
END;

FUNCTION trouver(Ensemble:TabFlotte;Bateau:TabBateau;PosCellule:TabCellule;x,y:INTEGER;VAR nbr:INTEGER):BOOLEAN;
VAR
	i,j:INTEGER;
	Test:BOOLEAN;
BEGIN
	Test:=false;
	FOR i:=1 TO BateauMax DO
	BEGIN
		FOR j:=1 TO Bateau[i].Taille DO
		BEGIN
			IF (Ensemble[i,j].n1.n.Colonne=PosCellule[y].Colonne) AND (Ensemble[i,j].n1.n.Ligne=PosCellule[x].Ligne) THEN
			BEGIN
				Test:=true;
				nbr:=i;			
			END;
		END;
	END;
	trouver:=Test;
END;

FUNCTION ENDal(Nb:Tab):BOOLEAN;

VAR
	i,cpt:INTEGER;
	Test:BOOLEAN;

BEGIN
	Test:=false;
	cpt:=0;
	FOR i:=1 TO BateauMax DO
	BEGIN
		IF Nb[i]<1 THEN
		BEGIN
			cpt:=cpt+1;
			IF cpt=BateauMax THEN
			BEGIN
				Test:=true;
			END;
		END;
	END;
	
	ENDal:=Test;

END;

//Procedure de creation de cellule et bateau 
PROCEDURE CreateCellule(VAR PosCellule:TabCellule);

VAR
	cpt,i:INTEGER;

BEGIN	
	
	cpt:=7;
	FOR i:=1 TO Max DO	
	BEGIN
		PosCellule[i].Ligne:=cpt;
		cpt:=cpt+4;
	END;

	cpt:=8;
	FOR i:=1 TO Max DO	
	BEGIN
		PosCellule[i].Colonne:=cpt;
		cpt:=cpt+3;
	END;


END;

PROCEDURE CreateBateau (PosCellule:TabCellule;VAR Bateau:TabBateau;i:INTEGER);

VAR
	j,x,y,randdirection:INTEGER;
	Test:BOOLEAN;
BEGIN

	REPEAT
	BEGIN
	RanDOmize;
	
	
		RandDirection:=Random(2)+1;
	
		case RandDirection of
			1:BEGIN		
					REPEAT
					BEGIN
						x:=Random(Max)+1;
						y:=Random(Max)+1;
					END;
					UNTIL (y<=Max-Bateau[i].Taille);
					
					Test:=TestCaseColonne(Bateau,PosCellule,x,y,i);	
					IF Test=true THEN
					BEGIN
						
						FOR j:=1 TO Bateau[i].Taille DO
						BEGIN
							Bateau[j].n.Colonne:=PosCellule[(y+j)-1].Colonne;
							Bateau[j].n.Ligne:=PosCellule[x].Ligne;
						END;
					END;
					
				END;
			
			2:BEGIN
					REPEAT
					BEGIN
						x:=RanDOm(Max)+1;
						y:=RanDOm(Max)+1;
					END;
					UNTIL (x<=Max-Bateau[i].Taille);
					
					Test:=TestCaseLigne(Bateau,PosCellule,x,y,i);	
					IF Test=true THEN
					BEGIN
						
						FOR j:=1 TO Bateau[i].Taille DO
						BEGIN
							Bateau[j].n.Colonne:=PosCellule[y].Colonne;
							Bateau[j].n.Ligne:=PosCellule[(x+j)-1].Ligne;
						END;
					END;
				
				END;
		END;

	END;
	UNTIL (Test=true);

END;

PROCEDURE TailleBateau(VAR Bateau:TabBateau;VAR TailleB:Tab);

VAR
	i,nbr:INTEGER;

BEGIN
	
	RanDOmize;
	
	FOR i:=1 TO BateauMax DO
	BEGIN
		REPEAT
			nbr:=RanDOm(TailleMax)+1;
		UNTIL nbr>1;
		
		Bateau[i].Taille:=nbr;
		TailleB[i]:=Bateau[i].Taille;
	END;

END;

PROCEDURE CreateFlotte (Bateau:TabBateau; PosCellule:TabCellule; VAR Ensemble:TabFlotte);

VAR
	i,j:INTEGER;
	Test:BOOLEAN;

BEGIN

	REPEAT
	BEGIN
		IniTabFlotte(Bateau,Ensemble);
		
		FOR i:=1 TO BateauMax DO
		BEGIN

			CreateBateau(PosCellule,Bateau,i);
			

			FOR j:=1 TO Bateau[i].Taille DO
			BEGIN	
					Ensemble[i,j].n1.n.Ligne:=Bateau[j].n.Ligne;
					Ensemble[i,j].n1.n.Colonne:=Bateau[j].n.Colonne;
			END;

		END;

		Test:=TestCase(Bateau,Ensemble);
		
	END;
	UNTIL (Test=true);

END;
	
//Debut du programme principal

VAR
	
	PosCellule,CelluleTOuche:TabCellule;
	Bateau:TabBateau;
	Nom:TabNom;
	TailleB:Tab;
	margin:Marge;
	Ensemble:TabFlotte;
	x1,y1,i,k,j,nbr:INTEGER;
	y:CHAR;
	x,pseuDO:STRING;
	Test:BOOLEAN;
	
	
BEGIN
	clrscr;
	
	IniTabCellule(PosCellule,CelluleTOuche);

	AfficheMap();	
	
	CreateCellule(PosCellule);

	TailleBateau(Bateau,TailleB);
	
	CreateFlotte(Bateau,PosCellule,Ensemble);
	
	margin.x:=(Max*4)+10;
	margin.y:=Max;
	
	REPEAT
	BEGIN

			REPEAT
			BEGIN
				
				GoTOXY(margin.x,margin.y+13);
				WRITE('Coordonne x ? 1-10');
				GoTOXY(margin.x,margin.y+14);
				WRITE('.');
				READLN(x);
				x1:=one1(x);
				IF (x1=0) THEN
				BEGIN
					FOR i:=margin.x TO margin.x+10 DO
					BEGIN
						GoTOXY(i,margin.y+14);
						WRITE(' ');
					END;
				END;
			END;
			UNTIL (x1<>0) AND (x<>'');;
			
			clrtxt3;
			
			REPEAT
			BEGIN
				GoTOXY(margin.x,margin.y+15);
				WRITE('Coordonne y ? a-j');
				GoTOXY(margin.x,margin.y+16);
				WRITE('.');
				READLN(y);
				y:=LowerCase(y);
				y1:=a1(y);
				IF (y1=11) THEN
				BEGIN
					FOR i:=margin.x TO margin.x+10 DO
					BEGIN
						GoTOXY(i,margin.y+16);
						WRITE(' ');
					END;
				END;
			END;
			UNTIL (y1<>11);
			
		Test:=trouver(Ensemble,Bateau,PosCellule,x1,y1,nbr);
		
		IF Test=true THEN
		BEGIN
			
			IF (CelluleTOuche[nbr].Ligne<>PosCellule[x1].Ligne) OR (CelluleTOuche[nbr].Colonne<>PosCellule[y1].Colonne) THEN
			BEGIN
				
				IF (TailleB[nbr]>0) THEN
				BEGIN
				CelluleTOuche[nbr].Ligne:=PosCellule[x1].Ligne;
				CelluleTOuche[nbr].Colonne:=PosCellule[y1].Colonne;
			
				GoTOXY(PosCellule[x1].Ligne,PosCellule[y1].Colonne);
				WRITE('X');
				GoTOXY(margin.x,margin.y+24);
				WRITE(Nom[nbr],' toucher !');
				TailleB[nbr]:=TailleB[nbr]-1;
				END;
				
				IF TailleB[nbr]<=0 THEN
				BEGIN
					GoTOXY(margin.x,margin.y+25);
					WRITE('vous avez coule un Bateau !');
					FOR i:=1 TO Bateau[nbr].Taille DO
					BEGIN
						GoTOXY(Ensemble[nbr,i].n1.n.Ligne,Ensemble[nbr,i].n1.n.Colonne);
						WRITE('C');
					END;
					TailleB[nbr]:=-1;
				END;
			END
		END
		ELSE
		BEGIN
			GoTOXY(PosCellule[x1].Ligne,PosCellule[y1].Colonne);
			WRITE('0');
		END;
		
		clrtxt2;

			
		Test:=ENDal(TailleB);
	END;
	UNTIL Test=true;
	delay(2000);
	
	clrtxt3;
	
	GoTOXY(margin.x,margin.y+24);
	WRITE('FIN');

	
	READLN;
END.
	