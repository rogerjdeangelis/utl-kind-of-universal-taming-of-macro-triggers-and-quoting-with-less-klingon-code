# utl-kind-of-universal-taming-of-macro-triggers-and-quoting-with-less-klingon-code
Kind of universal taming of macro triggers and quoting with less klingon code
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
    /*--- more maintainable than macro quoting    ---*/

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

    %put &=ans1;

    ANS='D:\Data\backupironmountain;2024%draft%sfx.txt'

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
    https://github.com/rogerjdeangelis/utl-create-csv-file-with-both-character-and-numeric-variables-double-quoted-example-of-tilde-form
    https://github.com/rogerjdeangelis/utl-quote-unquote-concatenate-of-macro-variables
    https://github.com/rogerjdeangelis/utl-quotes-within-quotes-within-quotes-and-the-macro-language
    https://github.com/rogerjdeangelis/utl-resolve-macro-variable-within-single-quotes
    https://github.com/rogerjdeangelis/utl-safest-way-to-deal-with-macro-variables-containing-macro-triggers-and-quotes-sysfunc-dequote
    https://github.com/rogerjdeangelis/utl_resolve_a_single_quoted_macro_variable
    https://github.com/rogerjdeangelis/utl_safest_way_to_deal_with_macro_variables_containing_macro_triggers_and_quotes

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
