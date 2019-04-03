***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4 
;
      label S_Age = 'Standard: Age' ;

      label S_Basement = 'Standard: Basement' ;

      label S_Baths = 'Standard: Baths' ;

      label S_FirePlace = 'Standard: FirePlace' ;

      label S_FirstFloor = 'Standard: FirstFloor' ;

      label S_GarageSize = 'Standard: GarageSize' ;

      label S_SecondFloor = 'Standard: SecondFloor' ;

      label S_TotalArea = 'Standard: TotalArea' ;

      label S_UpperArea = 'Standard: UpperArea' ;

      label CentralAir0 = 'Dummy: CentralAir=0' ;

      label BasementType0 = 'Dummy: BasementType=0' ;

      label BasementType1 = 'Dummy: BasementType=1' ;

      label ConstructionType1 = 'Dummy: ConstructionType=1' ;

      label ConstructionType2 = 'Dummy: ConstructionType=2' ;

      label GarageType0 = 'Dummy: GarageType=0' ;

      label GarageType1 = 'Dummy: GarageType=1' ;

      label GarageType2 = 'Dummy: GarageType=2' ;

      label GarageType3 = 'Dummy: GarageType=3' ;

      label GarageType4 = 'Dummy: GarageType=4' ;

      label LotSize1 = 'Dummy: LotSize=1' ;

      label LotSize2 = 'Dummy: LotSize=2' ;

      label Neighborhood1 = 'Dummy: Neighborhood=1' ;

      label WallType1 = 'Dummy: WallType=1' ;

      label WallType2 = 'Dummy: WallType=2' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_SalePrice = 'Predicted: SalePrice' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for CentralAir ;
drop CentralAir0 ;
if missing( CentralAir ) then do;
   CentralAir0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( CentralAir , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      CentralAir0 = -1;
   end;
   else if _dm12 = '0'  then do;
      CentralAir0 = 1;
   end;
   else do;
      CentralAir0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for BasementType ;
drop BasementType0 BasementType1 ;
if missing( BasementType ) then do;
   BasementType0 = .;
   BasementType1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( BasementType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      BasementType0 = -1;
      BasementType1 = -1;
   end;
   else if _dm12 = '1'  then do;
      BasementType0 = 0;
      BasementType1 = 1;
   end;
   else if _dm12 = '0'  then do;
      BasementType0 = 1;
      BasementType1 = 0;
   end;
   else do;
      BasementType0 = .;
      BasementType1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for ConstructionType ;
drop ConstructionType1 ConstructionType2 ;
if missing( ConstructionType ) then do;
   ConstructionType1 = .;
   ConstructionType2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( ConstructionType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      ConstructionType1 = 1;
      ConstructionType2 = 0;
   end;
   else if _dm12 = '2'  then do;
      ConstructionType1 = 0;
      ConstructionType2 = 1;
   end;
   else if _dm12 = '3'  then do;
      ConstructionType1 = -1;
      ConstructionType2 = -1;
   end;
   else do;
      ConstructionType1 = .;
      ConstructionType2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GarageType ;
drop GarageType0 GarageType1 GarageType2 GarageType3 GarageType4 ;
*** encoding is sparse, initialize to zero;
GarageType0 = 0;
GarageType1 = 0;
GarageType2 = 0;
GarageType3 = 0;
GarageType4 = 0;
if missing( GarageType ) then do;
   GarageType0 = .;
   GarageType1 = .;
   GarageType2 = .;
   GarageType3 = .;
   GarageType4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GarageType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      GarageType2 = 1;
   end;
   else if _dm12 = '0'  then do;
      GarageType0 = 1;
   end;
   else if _dm12 = '3'  then do;
      GarageType3 = 1;
   end;
   else if _dm12 = '1'  then do;
      GarageType1 = 1;
   end;
   else if _dm12 = '4'  then do;
      GarageType4 = 1;
   end;
   else if _dm12 = '5'  then do;
      GarageType0 = -1;
      GarageType1 = -1;
      GarageType2 = -1;
      GarageType3 = -1;
      GarageType4 = -1;
   end;
   else do;
      GarageType0 = .;
      GarageType1 = .;
      GarageType2 = .;
      GarageType3 = .;
      GarageType4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for LotSize ;
drop LotSize1 LotSize2 ;
if missing( LotSize ) then do;
   LotSize1 = .;
   LotSize2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( LotSize , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      LotSize1 = 1;
      LotSize2 = 0;
   end;
   else if _dm12 = '2'  then do;
      LotSize1 = 0;
      LotSize2 = 1;
   end;
   else if _dm12 = '3'  then do;
      LotSize1 = -1;
      LotSize2 = -1;
   end;
   else do;
      LotSize1 = .;
      LotSize2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for Neighborhood ;
drop Neighborhood1 ;
if missing( Neighborhood ) then do;
   Neighborhood1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( Neighborhood , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      Neighborhood1 = 1;
   end;
   else if _dm12 = '2'  then do;
      Neighborhood1 = -1;
   end;
   else do;
      Neighborhood1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for WallType ;
drop WallType1 WallType2 ;
if missing( WallType ) then do;
   WallType1 = .;
   WallType2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( WallType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      WallType1 = 0;
      WallType2 = 1;
   end;
   else if _dm12 = '1'  then do;
      WallType1 = 1;
      WallType2 = 0;
   end;
   else if _dm12 = '3'  then do;
      WallType1 = -1;
      WallType2 = -1;
   end;
   else do;
      WallType1 = .;
      WallType2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   Age , 
   Basement , 
   Baths , 
   FirePlace , 
   FirstFloor , 
   GarageSize , 
   SecondFloor , 
   TotalArea , 
   UpperArea   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_Age  =    -5.79800632867022 +     0.12225218876584 * Age ;
   S_Basement  =    -0.49458207878395 +     0.00334997337812 * Basement ;
   S_Baths  =    -1.76411714218363 +     1.10829261382142 * Baths ;
   S_FirePlace  =    -2.01186859107483 +     2.33291145135273 * FirePlace ;
   S_FirstFloor  =    -5.35340382063727 +     0.00510704735291 * FirstFloor ;
   S_GarageSize  =    -1.89394092412704 +     1.79512661504215 * GarageSize ;
   S_SecondFloor  =    -0.29097603119759 +      0.0043289957552 * SecondFloor
         ;
   S_TotalArea  =    -4.25637698545192 +     0.00299693547373 * TotalArea ;
   S_UpperArea  =    -1.23567045229017 +     0.00405418335138 * UpperArea ;
END;
ELSE DO;
   IF MISSING( Age ) THEN S_Age  = . ;
   ELSE S_Age  =    -5.79800632867022 +     0.12225218876584 * Age ;
   IF MISSING( Basement ) THEN S_Basement  = . ;
   ELSE S_Basement  =    -0.49458207878395 +     0.00334997337812 * Basement ;
   IF MISSING( Baths ) THEN S_Baths  = . ;
   ELSE S_Baths  =    -1.76411714218363 +     1.10829261382142 * Baths ;
   IF MISSING( FirePlace ) THEN S_FirePlace  = . ;
   ELSE S_FirePlace  =    -2.01186859107483 +     2.33291145135273 * FirePlace
         ;
   IF MISSING( FirstFloor ) THEN S_FirstFloor  = . ;
   ELSE S_FirstFloor  =    -5.35340382063727 +     0.00510704735291 * 
        FirstFloor ;
   IF MISSING( GarageSize ) THEN S_GarageSize  = . ;
   ELSE S_GarageSize  =    -1.89394092412704 +     1.79512661504215 * 
        GarageSize ;
   IF MISSING( SecondFloor ) THEN S_SecondFloor  = . ;
   ELSE S_SecondFloor  =    -0.29097603119759 +      0.0043289957552 * 
        SecondFloor ;
   IF MISSING( TotalArea ) THEN S_TotalArea  = . ;
   ELSE S_TotalArea  =    -4.25637698545192 +     0.00299693547373 * TotalArea
         ;
   IF MISSING( UpperArea ) THEN S_UpperArea  = . ;
   ELSE S_UpperArea  =    -1.23567045229017 +     0.00405418335138 * UpperArea
         ;
END;
*** *************************;
*** Writing the Node bin ;
*** *************************;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     20.8288312527415 * S_Age  +     6.85079869815029 * S_Basement
          +    -3.36547636721141 * S_Baths  +     5.87348930230314 * 
        S_FirePlace  +    -7.27353406960516 * S_FirstFloor
          +     20.2441756667926 * S_GarageSize  +     6.10111963584497 * 
        S_SecondFloor  +    -6.66694048070819 * S_TotalArea
          +    -8.70959912917795 * S_UpperArea ;
   H12  =     10.6130084030609 * S_Age  +     0.06518128670181 * S_Basement
          +     -1.2800594309462 * S_Baths  +     -1.9026009631468 * 
        S_FirePlace  +    -8.13540387024598 * S_FirstFloor
          +    -4.26028301979254 * S_GarageSize  +     9.77550207180225 * 
        S_SecondFloor  +    -5.11045925561562 * S_TotalArea
          +    -8.80684096235056 * S_UpperArea ;
   H13  =    -1.62638015241576 * S_Age  +     0.17835440510199 * S_Basement
          +    -0.47760139391044 * S_Baths  +     1.23916642847139 * 
        S_FirePlace  +     -2.6601728675208 * S_FirstFloor
          +     6.30709787750877 * S_GarageSize  +     10.9811095291095 * 
        S_SecondFloor  +     3.89258982642337 * S_TotalArea
          +    -3.02954537381811 * S_UpperArea ;
   H11  = H11  +    -6.50435321735439 * CentralAir0 ;
   H12  = H12  +     5.23476103837851 * CentralAir0 ;
   H13  = H13  +    -1.65946101157946 * CentralAir0 ;
   H11  = H11  +     13.2536314783556 * BasementType0
          +     8.53133008760714 * BasementType1  +     0.56324337358479 * 
        ConstructionType1  +      3.3564335892726 * ConstructionType2
          +     1.14539912832644 * GarageType0  +     1.58774341463134 * 
        GarageType1  +      8.8976533682871 * GarageType2
          +    -3.73619344175417 * GarageType3  +     1.12451162075893 * 
        GarageType4  +     8.78498105448465 * LotSize1
          +     0.42366513958359 * LotSize2  +     13.5677805097637 * 
        Neighborhood1  +     2.14852781244836 * WallType1
          +     5.67050453528512 * WallType2 ;
   H12  = H12  +     7.66955372286829 * BasementType0
          +    -8.73066216590974 * BasementType1  +     23.5653250443181 * 
        ConstructionType1  +     2.11127274928508 * ConstructionType2
          +      11.824454390871 * GarageType0  +    -12.2102535974649 * 
        GarageType1  +    -12.2564813758267 * GarageType2
          +    -2.49731621962372 * GarageType3  +      0.9647934720046 * 
        GarageType4  +    -4.67336075437814 * LotSize1
          +     8.07675667956709 * LotSize2  +       5.357475327314 * 
        Neighborhood1  +     15.0927125893857 * WallType1
          +     8.83353157035109 * WallType2 ;
   H13  = H13  +    -4.10438331026384 * BasementType0
          +    -2.78852746806888 * BasementType1  +      9.1197257283848 * 
        ConstructionType1  +     9.95993746370288 * ConstructionType2
          +     7.50990557902757 * GarageType0  +    -2.87649922677036 * 
        GarageType1  +    -1.95379030908894 * GarageType2
          +     0.35884481891863 * GarageType3  +     -4.2599790016529 * 
        GarageType4  +    -6.44191524747859 * LotSize1
          +    -3.99224957796703 * LotSize2  +    -0.27911699149498 * 
        Neighborhood1  +     2.26145968118917 * WallType1
          +     3.59881778615552 * WallType2 ;
   H11  =     7.50883561626074 + H11 ;
   H12  =    -12.0514974902983 + H12 ;
   H13  =    -8.46602867977754 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node intervalTargets ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_SalePrice  =    -530.197082139242 * H11  +    -1939.73401065351 * H12
          +     6303.94688435578 * H13 ;
   P_SalePrice  =     76098.8597249232 + P_SalePrice ;
END;
ELSE DO;
   P_SalePrice  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_SalePrice  =     75984.2752293578;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
