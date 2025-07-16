%let pgm=utl-kind-of-universal-taming-of-macro-triggers-and-quoting-with-less-klingon-code;

%stop_submission;

Kind of universal taming of macro triggers and quoting with less klingon code

SOAPBOX ON
  I find the sas quoting functions to be inscrutable;
SOAPBOX OFF

github
https://tinyurl.com/y3ctueey
https://github.com/rogerjdeangelis/utl-kind-of-universal-taming-of-macro-triggers-and-quoting-with-less-klingon-code

 Contents

      1 Tslit macro to single quote a resolved macro variable
      2 Resolve some but not all single quoted macro variables
      3 A more natural macro  unquote/dequote function

  Bartosz Jablonski
  yabwon@gmail.com

      4 Install barts baseplus package and run oneliners
      5 GenerateOneLiners macro
        Very versatile dynamic generator for missing macro functions.
        Can be used to create a better %syfunc(dequote() function
      6 Example of mcro functions SUM MEAN MEDIAN VAR QUOTE

   One line command macro

      7 Roger command macro for N Sum Mean Std Dev Minimum Quartile Median Quartile Maximum

1 TSLIT
=======

%let name=Fred;

%let reslv=%tslit(Name: &name);
%put &=reslv;

RESLV='Name: Fred'


2 RESOLVE SOME BUT NOT ALL SINGLE QUOTED MACRO VARIABLES
========================================================

Resolve &archive but not %draft

%symdel dir achive reslv ans ans1/ nowarn;

%let dir='D:\Data\backup&archive;2024%draft%sfx.txt';
%let archive=ironmountain;

/*--- note ? cannot be used in a windows path ----*/
/*--- more clear than macro quoting           ----*/
/*--- more maintainable than macro quoting    ----*/
/*--- runs at macro time like %unquote        ---*/

%dosubl(%nrstr(
    data _null_;
       length str $255;
       str=&dir;
       str=translate(str,'?','%');
       str=resolve(str);
       str=translate(str,'%','?');
       str=quote(strip(str),"'");
       call symputx('reslv',str);
    run;quit;
    %let ans=&reslv;
));
run;quit;

%put &=ans;



ANS='D:\Data\backupironmountain;2024%draft%sfx.txt'



%macro dequote(arg)/des='alias for %sysfunc(dequote()';
   %qsysfunc(dequote(&arg));
%mend dequote;


3 A MORE NATURAL MACRO UNQUOTE FUNCTION
=======================================


/*---- FAILS                  ----*/

%let res = %unquote('&sysdate &systime');
%put &=res;

RES='&sysdate &systime'

/*---- WORKS (more logical?) ----*/

%let res = %dequote('&sysdate &systime');
%put &=res;

RES=15JAN23 09:17


%macro dequote(arg)/des='alias for %sysfunc(dequote()';
   %sysfunc(dequote(&arg));
%mend dequote;


REPOS

Be skeptical of these (some before dosubl?)

https://github.com/rogerjdeangelis/utl-classic-editor-commnand-macro-to-repair-sas-satement-with-uunbalanced-quotes
https://github.com/rogerjdeangelis/utl-create-csv-file-with-both-character-and-numeric-variables-double-quoted-example-of-tilde-format
https://github.com/rogerjdeangelis/utl-quote-unquote-concatenate-of-macro-variables
https://github.com/rogerjdeangelis/utl-quotes-within-quotes-within-quotes-and-the-macro-language
https://github.com/rogerjdeangelis/utl-resolve-macro-variable-within-single-quotes
https://github.com/rogerjdeangelis/utl-safest-way-to-deal-with-macro-variables-containing-macro-triggers-and-quotes-sysfunc-dequote
https://github.com/rogerjdeangelis/utl_resolve_a_single_quoted_macro_variable
https://github.com/rogerjdeangelis/utl_safest_way_to_deal_with_macro_variables_containing_macro_triggers_and_quotes

4 INSTALL BARTS BASEPLUS PACKAGE AND RUN ONELINE DEQUOTE
========================================================

filename packages "%sysfunc(pathname(work))"; /         * setup WORK as temporary directory for packages */
filename SPFinit url "https://raw.githubusercontent.com/yabwon/SAS_PACKAGES/main/SPF/SPFinit.sas";
%include SPFinit; /* enable the framework */

%installPackage(baseplus) /* install a package */
%helpPackage(baseplus)    /* get help about the package */
%loadPackage(baseplus)    /* load the package content into the SAS session */

/*---- generate _quote macro to
%GenerateOneLiners(listOfFunctions=quote, prefix=_)

/*----
NOTE: The GENERATEONELINERS macro is generating the following macros:
     ================================================================
      macro %_QUOTE()
      macro %q_QUOTE()
NOTE: DATA statement used (Total process time):
      real time           0.03 seconds
      user cpu time       0.01 seconds
      system cpu time     0.01 seconds
      memory              561.28k
      OS Memory           37124.00k
      Timestamp           07/15/2025 02:28:27 PM
      Step Count                        1067  Switch Count  0
----*/

5 INSTALL BARTS BASEPLUS PACKAGE AND RUN ONELINE DEQUOTE
========================================================

%GenerateOneLiners(
  listOfFunctions=SUM MEAN MEDIAN VAR
, prefix=_)

6 EXAMPLE OF MCRO FUNCTIONS SUM MEAN MEDIAN VAR QUOTE
======================================================

%GenerateOneLiners(
  listOfFunctions=SUM MEAN MEDIAN VAR
, prefix=_)

/*--- you have this macro var and you need to quote dir c:/oto ---*/
%let dir=dir c:/oto;

%let ans = %_quote(&dir);
%put &=ans;

ANS="dir c:/oto"


%utlnopts; /*--- just the result of the puts ---*/
%put SUM      of 1,2,3,4,5,6 = %_SUM(1,2,3,4,5,6);
%put MEAN     of 1,2,3,4,5,6 = %_MEAN(1,2,3,4,5,6);
%put MEDIAN   of 1,2,3,4,5,6 = %_MEDIAN(1,2,3,4,5,6);
%put SUM      of 1,2,3,4,5,6 = %_SUM(1,2,3,4,5,6);
%put VARIANCE of 1,2,3,4,5,6 = %_VAR(1,2,3,4,5,6);
%utlopts;  /*--- turn opts on               ----*/

SUM      of 1,2,3,4,5,6 = 21
MEAN     of 1,2,3,4,5,6 = 3.5
MEDIAN   of 1,2,3,4,5,6 = 3.5
SUM      of 1,2,3,4,5,6 = 21


7 Roger command macro for SUM MEAN MEDIAN VAR QUOTE

Classic Editor

File View Tool Solutions Window Help

Command --->
00001
00002 1 2 3 4 5 6
00003
00004
00004

Highlight 1 2 3 4 5 6 The go to classic editor command line and tpye avgh

The output window will have

N         Sum      Mean     Std Dev    Minimum    Quartile     Median   Quartile   Maximum
------------------------------------------------------------------------------------------
6  21.0000000 3.5000000   1.8708287  1.0000000   2.0000000  3.5000000  5.0000000 6.0000000
------------------------------------------------------------------------------------------

Put this in your autocall library or function key or mouse action

%macro avgr / cmd des="Usage: sumv. Hilite a row of numbers and an proc means will run";
   store;note;notesubmit '%avgra;';
   run;
%mend avgr;

%macro avgra;
   filename clp clipbrd ;
   data _sumh_;
     infile clp;
     input x @@;
   run;quit;
   proc means data=_sumh_ n sum mean std min q1 median q3 max;run;quit
%mend avgra;

related repos
https://youtu.be/DzNdKj1CQps
https://github.com/rogerjdeangelis/utl-latest-command-macros-for-the-sas-classic-editor
https://github.com/rogerjdeangelis/utl_classic_sas_editor_display_manager_commands_improved

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
