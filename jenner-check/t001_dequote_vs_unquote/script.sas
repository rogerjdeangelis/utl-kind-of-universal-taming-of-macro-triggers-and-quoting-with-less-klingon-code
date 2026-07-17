/*--- adapted from section 3 of the repo's utl-kind-of-universal-...
      .sas file: "A more natural macro unquote/dequote function".
      %unquote() leaves the literal text untouched (it does not strip
      the surrounding quotes or force a second round of macro
      resolution the way the author expects); %sysfunc(dequote())
      does both, which is the point of the write-up. ----*/

/*---- FAILS as unquote leaves quotes as literal text ----*/

%let res = %unquote('&sysdate &systime');
%put &=res;

/*---- WORKS: dequote resolves macro vars then removes matching quotes ----*/

%let res2 = %sysfunc(dequote('&sysdate &systime'));
%put &=res2;

%macro dequote2(arg)/des='alias for %sysfunc(dequote()';
   %sysfunc(dequote(&arg));
%mend dequote2;

%let res3 = %dequote2('&sysdate &systime');
%put &=res3;
