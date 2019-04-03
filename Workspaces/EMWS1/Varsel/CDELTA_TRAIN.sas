if upcase(name) = 'CONSTRUCTIONTYPE' then role = 'REJECTED';
else
if upcase(name) = 'FIRSTFLOOR' then role = 'REJECTED';
else
if upcase(name) = 'GARAGETYPE' then role = 'REJECTED';
else
if upcase(name) = 'LOTSIZE' then role = 'REJECTED';
else
if upcase(name) = 'NEIGHBORHOOD' then role = 'REJECTED';
else
if upcase(name) = 'UPPERAREA' then role = 'REJECTED';
else
if upcase(name) = 'WALLTYPE' then role = 'REJECTED';
if upcase(strip(name)) = "G_CONSTRUCTIONTYPE" then level = "NOMINAL";
