/*--- adapted from section 7 of the repo's utl-kind-of-universal-...
      .sas file: the %avgr / %avgra classic-editor command-macro pair
      for computing N/Sum/Mean/StdDev/Min/Q1/Median/Q3/Max over a
      highlighted row of numbers. The original %avgra reads the
      numbers from the Windows clipboard (filename clp clipbrd) inside
      the SAS classic editor; that step is swapped for the same six
      sample values (1 2 3 4 5 6) fed in via DATALINES, since a
      jenner-check bundle must be self-contained. The macro body,
      PROC MEANS call, and options are otherwise exactly as written. ----*/

%macro avgra;
   data _sumh_;
     input x @@;
     datalines;
1 2 3 4 5 6
;
   run;quit;
   proc means data=_sumh_ n sum mean std min q1 median q3 max;run;quit;
%mend avgra;

%avgra;
