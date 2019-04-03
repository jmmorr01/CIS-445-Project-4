 
*------------------------------------------------------------*;
* Variable: G_ConstructionType;
*------------------------------------------------------------*;
LABEL GRP_G_ConstructionType =
'Grouped: Grouped Levels for  ConstructionType';
 
if MISSING(G_ConstructionType) then do;
GRP_G_ConstructionType = 1;
end;
else if NOT MISSING(G_ConstructionType) then do;
if (G_ConstructionType eq 0
) then do;
GRP_G_ConstructionType = 2;
end;
else
if (G_ConstructionType eq 1
) then do;
GRP_G_ConstructionType = 3;
end;
else do;
GRP_G_ConstructionType = 1;
end;
end;
