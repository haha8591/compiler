%option noyywrap
%option caseless
%%
[a-zA-Z\n]    {return yytext[0]; }
"\."       {/*句號忽略*/}
[ \t] 	   {/*空白忽略*/}
","	   {/*逗號忽略*/}
"?"	   {/*問號忽略*/}
":"	   {/*冒號忽略*/}
"\!"	   {/*驚嘆號忽略*/}
"\;"	   {/*分號忽略*/}

%%