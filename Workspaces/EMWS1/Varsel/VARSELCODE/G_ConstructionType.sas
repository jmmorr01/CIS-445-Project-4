/*----G_ConstructionType begin----*/
length _NORM12 $ 12;
_NORM12 = put( ConstructionType , BEST. );
%DMNORMIP( _NORM12 )
drop _NORM12;
select(_NORM12);
when('1' ) G_ConstructionType = 0;
when('2' ) G_ConstructionType = 1;
when('3' ) G_ConstructionType = 1;
otherwise substr(_WARN_, 2, 1) = 'U';
end;
label G_ConstructionType="Grouped Levels for  ConstructionType";
/*----ConstructionType end----*/
