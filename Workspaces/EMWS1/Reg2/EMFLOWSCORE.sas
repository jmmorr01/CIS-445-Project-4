*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

drop _Y;
_Y = SalePrice ;

drop _DM_BAD;
_DM_BAD=0;

*** Check Age for missing values ;
if missing( Age ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check Basement for missing values ;
if missing( Basement ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check Baths for missing values ;
if missing( Baths ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check FirePlace for missing values ;
if missing( FirePlace ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check FirstFloor for missing values ;
if missing( FirstFloor ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check GarageSize for missing values ;
if missing( GarageSize ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check SecondFloor for missing values ;
if missing( SecondFloor ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check TotalArea for missing values ;
if missing( TotalArea ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for BasementType ;
drop _0_0 _0_1 ;
if missing( BasementType ) then do;
   _0_0 = .;
   _0_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( BasementType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _0_0 = -1;
      _0_1 = -1;
   end;
   else if _dm12 = '1'  then do;
      _0_0 = 0;
      _0_1 = 1;
   end;
   else if _dm12 = '0'  then do;
      _0_0 = 1;
      _0_1 = 0;
   end;
   else do;
      _0_0 = .;
      _0_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for CentralAir ;
drop _1_0 ;
if missing( CentralAir ) then do;
   _1_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( CentralAir , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _1_0 = -1;
   end;
   else if _dm12 = '0'  then do;
      _1_0 = 1;
   end;
   else do;
      _1_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for ConstructionType ;
drop _2_0 _2_1 ;
if missing( ConstructionType ) then do;
   _2_0 = .;
   _2_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( ConstructionType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _2_0 = 1;
      _2_1 = 0;
   end;
   else if _dm12 = '2'  then do;
      _2_0 = 0;
      _2_1 = 1;
   end;
   else if _dm12 = '3'  then do;
      _2_0 = -1;
      _2_1 = -1;
   end;
   else do;
      _2_0 = .;
      _2_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for GarageType ;
drop _3_0 _3_1 _3_2 _3_3 _3_4 ;
*** encoding is sparse, initialize to zero;
_3_0 = 0;
_3_1 = 0;
_3_2 = 0;
_3_3 = 0;
_3_4 = 0;
if missing( GarageType ) then do;
   _3_0 = .;
   _3_1 = .;
   _3_2 = .;
   _3_3 = .;
   _3_4 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( GarageType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _3_2 = 1;
   end;
   else if _dm12 = '0'  then do;
      _3_0 = 1;
   end;
   else if _dm12 = '3'  then do;
      _3_3 = 1;
   end;
   else if _dm12 = '1'  then do;
      _3_1 = 1;
   end;
   else if _dm12 = '4'  then do;
      _3_4 = 1;
   end;
   else if _dm12 = '5'  then do;
      _3_0 = -1;
      _3_1 = -1;
      _3_2 = -1;
      _3_3 = -1;
      _3_4 = -1;
   end;
   else do;
      _3_0 = .;
      _3_1 = .;
      _3_2 = .;
      _3_3 = .;
      _3_4 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for LotSize ;
drop _4_0 _4_1 ;
if missing( LotSize ) then do;
   _4_0 = .;
   _4_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( LotSize , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _4_0 = 1;
      _4_1 = 0;
   end;
   else if _dm12 = '2'  then do;
      _4_0 = 0;
      _4_1 = 1;
   end;
   else if _dm12 = '3'  then do;
      _4_0 = -1;
      _4_1 = -1;
   end;
   else do;
      _4_0 = .;
      _4_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for Neighborhood ;
drop _5_0 ;
if missing( Neighborhood ) then do;
   _5_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( Neighborhood , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _5_0 = 1;
   end;
   else if _dm12 = '2'  then do;
      _5_0 = -1;
   end;
   else do;
      _5_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for WallType ;
drop _6_0 _6_1 ;
if missing( WallType ) then do;
   _6_0 = .;
   _6_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( WallType , BEST. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _6_0 = 0;
      _6_1 = 1;
   end;
   else if _dm12 = '1'  then do;
      _6_0 = 1;
      _6_1 = 0;
   end;
   else if _dm12 = '3'  then do;
      _6_0 = -1;
      _6_1 = -1;
   end;
   else do;
      _6_0 = .;
      _6_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     75984.2752293578;
   goto REG2DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: Age ;
_TEMP = Age ;
_LP0 = _LP0 + (   -431.936071671528 * _TEMP);

***  Effect: Basement ;
_TEMP = Basement ;
_LP0 = _LP0 + (    2.18687828412111 * _TEMP);

***  Effect: BasementType ;
_TEMP = 1;
_LP0 = _LP0 + (   -9160.85317146442) * _TEMP * _0_0;
_LP0 = _LP0 + (    4491.95255674066) * _TEMP * _0_1;

***  Effect: Baths ;
_TEMP = Baths ;
_LP0 = _LP0 + (    471.670852372481 * _TEMP);

***  Effect: CentralAir ;
_TEMP = 1;
_LP0 = _LP0 + (   -1213.32943828199) * _TEMP * _1_0;

***  Effect: ConstructionType ;
_TEMP = 1;
_LP0 = _LP0 + (   -17878.5942963889) * _TEMP * _2_0;
_LP0 = _LP0 + (   -14287.5427047542) * _TEMP * _2_1;

***  Effect: FirePlace ;
_TEMP = FirePlace ;
_LP0 = _LP0 + (   -1702.40321440209 * _TEMP);

***  Effect: FirstFloor ;
_TEMP = FirstFloor ;
_LP0 = _LP0 + (     7.3902914604401 * _TEMP);

***  Effect: GarageSize ;
_TEMP = GarageSize ;
_LP0 = _LP0 + (    3891.72416970124 * _TEMP);

***  Effect: GarageType ;
_TEMP = 1;
_LP0 = _LP0 + (    3417.41210774315) * _TEMP * _3_0;
_LP0 = _LP0 + (   -801.914423123984) * _TEMP * _3_1;
_LP0 = _LP0 + (    3383.58879889631) * _TEMP * _3_2;
_LP0 = _LP0 + (     6532.9209186196) * _TEMP * _3_3;
_LP0 = _LP0 + (   -16566.7236017071) * _TEMP * _3_4;

***  Effect: LotSize ;
_TEMP = 1;
_LP0 = _LP0 + (   -174.269009800207) * _TEMP * _4_0;
_LP0 = _LP0 + (   -8400.20858929302) * _TEMP * _4_1;

***  Effect: Neighborhood ;
_TEMP = 1;
_LP0 = _LP0 + (   -828.923780605267) * _TEMP * _5_0;

***  Effect: SecondFloor ;
_TEMP = SecondFloor ;
_LP0 = _LP0 + (   -52.9687723273401 * _TEMP);

***  Effect: TotalArea ;
_TEMP = TotalArea ;
_LP0 = _LP0 + (    9.94109260562379 * _TEMP);

***  Effect: WallType ;
_TEMP = 1;
_LP0 = _LP0 + (   -2473.21138494035) * _TEMP * _6_0;
_LP0 = _LP0 + (   -2541.97716567457) * _TEMP * _6_1;
*--- Intercept ---*;
_LP0 = _LP0 + (    81836.5530427854);

REG2DR1:

*** Predicted Value, Error, and Residual;
label P_SalePrice = 'Predicted: SalePrice' ;
P_SalePrice = _LP0;

drop _R;
if _Y = . then do;
   R_SalePrice = .;
end;
else do;
   _R = _Y - _LP0;
    label R_SalePrice = 'Residual: SalePrice' ;
   R_SalePrice = _R;
end;

*************************************;
***** end scoring code for regression;
*************************************;
