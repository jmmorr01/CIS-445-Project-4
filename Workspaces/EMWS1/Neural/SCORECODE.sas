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
      label GRP_Age2 = 'Dummy: GRP_Age=2' ;

      label GRP_Age3 = 'Dummy: GRP_Age=3' ;

      label GRP_Age4 = 'Dummy: GRP_Age=4' ;

      label GRP_BasementType2 = 'Dummy: GRP_BasementType=2' ;

      label GRP_BasementType3 = 'Dummy: GRP_BasementType=3' ;

      label GRP_Baths3 = 'Dummy: GRP_Baths=3' ;

      label GRP_CentralAir2 = 'Dummy: GRP_CentralAir=2' ;

      label GRP_FirePlace2 = 'Dummy: GRP_FirePlace=2' ;

      label GRP_G_ConstructionType2 = 'Dummy: GRP_G_ConstructionType=2' ;

      label GRP_GarageSize2 = 'Dummy: GRP_GarageSize=2' ;

      label GRP_TotalArea2 = 'Dummy: GRP_TotalArea=2' ;

      label GRP_TotalArea3 = 'Dummy: GRP_TotalArea=3' ;

      label GRP_TotalArea4 = 'Dummy: GRP_TotalArea=4' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_SalePrice = 'Predicted: SalePrice' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for GRP_Age ;
drop GRP_Age2 GRP_Age3 GRP_Age4 ;
if missing( GRP_Age ) then do;
   GRP_Age2 = .;
   GRP_Age3 = .;
   GRP_Age4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_Age , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '5'  then do;
      GRP_Age2 = 0.63245553203367;
      GRP_Age3 = 0.63245553203367;
      GRP_Age4 = 0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_Age2 = 0.63245553203367;
      GRP_Age3 = 0.63245553203367;
      GRP_Age4 = -0.63245553203367;
   end;
   else if _dm12 = '3'  then do;
      GRP_Age2 = 0.63245553203367;
      GRP_Age3 = -0.63245553203367;
      GRP_Age4 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_Age2 = -0.63245553203367;
      GRP_Age3 = -0.63245553203367;
      GRP_Age4 = -0.63245553203367;
   end;
   else do;
      GRP_Age2 = .;
      GRP_Age3 = .;
      GRP_Age4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_BasementType ;
drop GRP_BasementType2 GRP_BasementType3 ;
if missing( GRP_BasementType ) then do;
   GRP_BasementType2 = .;
   GRP_BasementType3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_BasementType , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      GRP_BasementType2 = -0.75;
      GRP_BasementType3 = -0.75;
   end;
   else if _dm12 = '3'  then do;
      GRP_BasementType2 = 0.75;
      GRP_BasementType3 = -0.75;
   end;
   else if _dm12 = '4'  then do;
      GRP_BasementType2 = 0.75;
      GRP_BasementType3 = 0.75;
   end;
   else do;
      GRP_BasementType2 = .;
      GRP_BasementType3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_Baths ;
drop GRP_Baths3 ;
if missing( GRP_Baths ) then do;
   GRP_Baths3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_Baths , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_Baths3 = -1;
   end;
   else if _dm12 = '4'  then do;
      GRP_Baths3 = 1;
   end;
   else do;
      GRP_Baths3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_CentralAir ;
drop GRP_CentralAir2 ;
if missing( GRP_CentralAir ) then do;
   GRP_CentralAir2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_CentralAir , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      GRP_CentralAir2 = -1;
   end;
   else if _dm12 = '3'  then do;
      GRP_CentralAir2 = 1;
   end;
   else do;
      GRP_CentralAir2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_FirePlace ;
drop GRP_FirePlace2 ;
if missing( GRP_FirePlace ) then do;
   GRP_FirePlace2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_FirePlace , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_FirePlace2 = 1;
   end;
   else if _dm12 = '2'  then do;
      GRP_FirePlace2 = -1;
   end;
   else do;
      GRP_FirePlace2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_G_ConstructionType ;
drop GRP_G_ConstructionType2 ;
if missing( GRP_G_ConstructionType ) then do;
   GRP_G_ConstructionType2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_G_ConstructionType , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      GRP_G_ConstructionType2 = -1;
   end;
   else if _dm12 = '3'  then do;
      GRP_G_ConstructionType2 = 1;
   end;
   else do;
      GRP_G_ConstructionType2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_GarageSize ;
drop GRP_GarageSize2 ;
if missing( GRP_GarageSize ) then do;
   GRP_GarageSize2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_GarageSize , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '3'  then do;
      GRP_GarageSize2 = 1;
   end;
   else if _dm12 = '2'  then do;
      GRP_GarageSize2 = -1;
   end;
   else do;
      GRP_GarageSize2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GRP_TotalArea ;
drop GRP_TotalArea2 GRP_TotalArea3 GRP_TotalArea4 ;
if missing( GRP_TotalArea ) then do;
   GRP_TotalArea2 = .;
   GRP_TotalArea3 = .;
   GRP_TotalArea4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GRP_TotalArea , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '5'  then do;
      GRP_TotalArea2 = 0.63245553203367;
      GRP_TotalArea3 = 0.63245553203367;
      GRP_TotalArea4 = 0.63245553203367;
   end;
   else if _dm12 = '4'  then do;
      GRP_TotalArea2 = 0.63245553203367;
      GRP_TotalArea3 = 0.63245553203367;
      GRP_TotalArea4 = -0.63245553203367;
   end;
   else if _dm12 = '3'  then do;
      GRP_TotalArea2 = 0.63245553203367;
      GRP_TotalArea3 = -0.63245553203367;
      GRP_TotalArea4 = -0.63245553203367;
   end;
   else if _dm12 = '2'  then do;
      GRP_TotalArea2 = -0.63245553203367;
      GRP_TotalArea3 = -0.63245553203367;
      GRP_TotalArea4 = -0.63245553203367;
   end;
   else do;
      GRP_TotalArea2 = .;
      GRP_TotalArea3 = .;
      GRP_TotalArea4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
*** *************************;
*** Writing the Node ord ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =  1.0000000827403E-10 * GRP_Age2  +  1.0000000133514E-10 * GRP_Age3
          +  9.9999994396249E-11 * GRP_Age4  +     2.19396277615857 * 
        GRP_BasementType2  +  1.0000000133514E-10 * GRP_BasementType3
          +  1.0000000827403E-10 * GRP_Baths3  +  1.0000000827403E-10 * 
        GRP_CentralAir2  +     3.64853941128541 * GRP_FirePlace2
          +     1.37409899652201 * GRP_G_ConstructionType2
          +     3.57351607059962 * GRP_GarageSize2  +  9.9999994396249E-11 * 
        GRP_TotalArea2  +     0.48701596702829 * GRP_TotalArea3
          +     2.14977038627574 * GRP_TotalArea4 ;
   H12  =     2.14644805112317 * GRP_Age2  +     1.95097720078181 * GRP_Age3
          +     1.80244898009527 * GRP_Age4  +  1.0000000133514E-10 * 
        GRP_BasementType2  +     3.63636443206898 * GRP_BasementType3
          +      1.8636611423261 * GRP_Baths3  +     2.50819958872812 * 
        GRP_CentralAir2  +     0.16862606040283 * GRP_FirePlace2
          +     1.77302094819769 * GRP_G_ConstructionType2
          +     2.00573259561136 * GRP_GarageSize2  +     1.87643150853497 * 
        GRP_TotalArea2  +     0.63611591670256 * GRP_TotalArea3
          +      5.1442801895614 * GRP_TotalArea4 ;
   H13  =     3.60834251768799 * GRP_Age2  +     3.65802377108976 * GRP_Age3
          +     0.26646016438357 * GRP_Age4  +     4.65567435778378 * 
        GRP_BasementType2  +     2.42262006695455 * GRP_BasementType3
          +     0.74257823114779 * GRP_Baths3  +     4.00716045002316 * 
        GRP_CentralAir2  +  9.9999999600419E-11 * GRP_FirePlace2
          +     0.64476276754776 * GRP_G_ConstructionType2
          +  1.0000000827403E-10 * GRP_GarageSize2  +     0.99450944137347 * 
        GRP_TotalArea2  +  1.0000000827403E-10 * GRP_TotalArea3
          +  1.0000000827403E-10 * GRP_TotalArea4 ;
   H11  =     -2.6624082873868 + H11 ;
   H12  =    -4.28162750216268 + H12 ;
   H13  =     8.75076195644127 + H13 ;
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
   P_SalePrice  =     3879.47192918675 * H11  +     2703.68234836976 * H12
          +    -2295.13126581828 * H13 ;
   P_SalePrice  =     77619.9928694919 + P_SalePrice ;
END;
ELSE DO;
   P_SalePrice  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_SalePrice  =     75017.5647668393;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
