# session_diff

    Code
      class(sd)
    Output
      [1] "session_diff" "list"        

---

    Code
      unclass(sd)
    Output
      $old
      $old$name
      [1] "lines1"
      
      
      $new
      $new$name
      [1] "lines2"
      
      
      $diff
      @@ -14,10 +14,6 @@
       
       - Packages -----------------------------------------------
        ! package      * version    date (UTC) lib source
      -   cli            3.0.1.9000 2021-10-11 [1] local
      -   covr           3.5.1      2020-09-16 [1] CRAN (R 4.1.0)
      -   crayon         1.4.1      2021-02-08 [1] CRAN (R 4.1.0)
      -   desc           1.4.0.9000 2021-10-04 [1] local
          diffobj        0.3.4      2021-03-22 [1] CRAN (R 4.1.0)
          ellipsis       0.3.2      2021-04-29 [1] CRAN (R 4.1.0)
          evaluate       0.14       2019-05-28 [1] CRAN (R 4.1.0)
      @@ -39,9 +35,8 @@
          rlang          0.4.11     2021-04-30 [1] CRAN (R 4.1.0)
          rprojroot      2.0.2      2020-11-15 [1] CRAN (R 4.1.0)
          rstudioapi     0.13       2020-11-12 [1] CRAN (R 4.1.0)
      - P sessioninfo  * 1.1.1.9000 2021-10-12 [?] local
      +   sessioninfo  * 1.1.1      2021-10-12 [?] local
          testthat     * 3.0.4      2021-07-01 [1] CRAN (R 4.1.0)
      -   testthatlabs   0.0.0.9000 2021-09-15 [1] local
          tibble         3.1.4      2021-08-25 [1] CRAN (R 4.1.0)
          utf8           1.2.2      2021-07-24 [1] CRAN (R 4.1.0)
          vctrs          0.3.8      2021-04-29 [1] CRAN (R 4.1.0)
      @@ -50,7 +45,5 @@
       
        [1] /Users/gaborcsardi/Library/R/x86_64/4.1/library
        [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
      -
      - P -- Loaded and on-disk path mismatch.
       
       ----------------------------------------------------------
      

# print.session_diff

    Code
      print(session_diff(lines1, lines2))
    Output
      --- lines1
      +++ lines2
       - Session info  ------------------------------------------
        hash: squid, supervillain: medium skin tone, ewe
       
        setting  value
        version  R version 4.1.1 (2021-08-10)
        os       macOS Mojave 10.14.6
        system   x86_64, darwin17.0
        ui       X11
        language (EN)
        collate  C
        ctype    en_US.UTF-8
        tz       Europe/Madrid
        pandoc   2.7.3 @ /usr/local/bin/pandoc
       
       - Packages -----------------------------------------------
        ! package      * version    date (UTC) lib source
      -   cli            3.0.1.9000 2021-10-11 [1] local
      -   covr           3.5.1      2020-09-16 [1] CRAN (R 4.1.0)
      -   crayon         1.4.1      2021-02-08 [1] CRAN (R 4.1.0)
      -   desc           1.4.0.9000 2021-10-04 [1] local
          diffobj        0.3.4      2021-03-22 [1] CRAN (R 4.1.0)
          ellipsis       0.3.2      2021-04-29 [1] CRAN (R 4.1.0)
          evaluate       0.14       2019-05-28 [1] CRAN (R 4.1.0)
          fansi          0.5.0      2021-05-25 [1] CRAN (R 4.1.0)
          glue           1.4.2      2021-10-04 [1] local
          lazyeval       0.2.2      2019-03-15 [1] CRAN (R 4.1.0)
          lifecycle      1.0.1      2021-09-24 [1] CRAN (R 4.1.0)
          magrittr       2.0.1      2020-11-17 [1] CRAN (R 4.1.0)
          mockery        0.4.2      2019-09-03 [1] CRAN (R 4.1.0)
          pillar         1.6.3      2021-09-26 [1] CRAN (R 4.1.1)
          pkgconfig      2.0.3      2019-09-22 [1] CRAN (R 4.1.0)
          pkgload        1.2.2      2021-09-11 [1] CRAN (R 4.1.0)
          prettycode     1.1.0      2019-12-16 [1] CRAN (R 4.1.0)
          prompt         1.0.0      2021-03-02 [1] local
          ps             1.6.0      2021-02-28 [1] CRAN (R 4.1.0)
          R6             2.5.1      2021-08-19 [1] CRAN (R 4.1.0)
          rematch2       2.1.2      2020-05-01 [1] CRAN (R 4.1.0)
          rex            1.2.0      2020-04-21 [1] CRAN (R 4.1.0)
          rlang          0.4.11     2021-04-30 [1] CRAN (R 4.1.0)
          rprojroot      2.0.2      2020-11-15 [1] CRAN (R 4.1.0)
          rstudioapi     0.13       2020-11-12 [1] CRAN (R 4.1.0)
      - P sessioninfo  * 1.1.1.9000 2021-10-12 [?] local
      +   sessioninfo  * 1.1.1      2021-10-12 [?] local
          testthat     * 3.0.4      2021-07-01 [1] CRAN (R 4.1.0)
      -   testthatlabs   0.0.0.9000 2021-09-15 [1] local
          tibble         3.1.4      2021-08-25 [1] CRAN (R 4.1.0)
          utf8           1.2.2      2021-07-24 [1] CRAN (R 4.1.0)
          vctrs          0.3.8      2021-04-29 [1] CRAN (R 4.1.0)
          waldo          0.3.1      2021-09-14 [1] CRAN (R 4.1.0)
          withr          2.4.2      2021-04-18 [1] CRAN (R 4.1.0)
       
        [1] /Users/gaborcsardi/Library/R/x86_64/4.1/library
        [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
      -
      - P -- Loaded and on-disk path mismatch.
       
       ----------------------------------------------------------

# find_session_info_in_html

    Code
      find_session_info_in_html(url, html)$text
    Output
       [1] "─ Session info  🤳🏾  😻  ⚒️   ────────────────────────────────────────────────────────────────────────────"
       [2] " setting  value"                                                                                           
       [3] " version  R version 4.1.1 (2021-08-10)"                                                                    
       [4] " os       macOS Mojave 10.14.6"                                                                            
       [5] " system   x86_64, darwin17.0"                                                                              
       [6] " ui       X11"                                                                                             
       [7] " language (EN)"                                                                                            
       [8] " collate  en_US.UTF-8"                                                                                     
       [9] " ctype    en_US.UTF-8"                                                                                     
      [10] " tz       Europe/Madrid"                                                                                   
      [11] " date     2021-10-07"                                                                                      
      [12] " pandoc   2.7.3 @ /usr/local/bin/pandoc"                                                                   
      [13] ""                                                                                                          
      [14] "─ Packages ─────────────────────────────────────────────────────────────────────────────────────────────"  
      [15] " package     * version     date (UTC) lib source"                                                          
      [16] " cachem        1.0.6       2021-08-19 [1] CRAN (R 4.1.0)"                                                  
      [17] " callr         3.7.0.9000  2021-10-01 [1] Github (r-lib/callr@ea5c3df)"                                    
      [18] " cli           3.0.1.9000  2021-10-07 [1] Github (r-lib/cli@e9758aa)"                                      
      [19] " clipr         0.7.1       2020-10-08 [1] CRAN (R 4.1.0)"                                                  
      [20] " commonmark    1.7         2018-12-01 [1] CRAN (R 4.1.0)"                                                  
      [21] " crayon        1.4.1       2021-02-08 [1] CRAN (R 4.1.0)"                                                  
      [22] " desc          1.4.0.9000  2021-10-04 [1] local"                                                           
      [23] " devtools      2.4.2       2021-06-07 [1] CRAN (R 4.1.0)"                                                  
      [24] " digest        0.6.28      2021-09-23 [1] CRAN (R 4.1.0)"                                                  
      [25] " ellipsis      0.3.2       2021-04-29 [1] CRAN (R 4.1.0)"                                                  
      [26] " fansi         0.5.0       2021-05-25 [1] CRAN (R 4.1.0)"                                                  
      [27] " fastmap       1.1.0       2021-01-25 [1] CRAN (R 4.1.0)"                                                  
      [28] " fs            1.5.0       2020-07-31 [1] CRAN (R 4.1.0)"                                                  
      [29] " glue          1.4.2       2021-10-04 [1] local"                                                           
      [30] " knitr         1.34        2021-09-09 [1] CRAN (R 4.1.0)"                                                  
      [31] " lifecycle     1.0.1       2021-09-24 [1] CRAN (R 4.1.0)"                                                  
      [32] " magrittr      2.0.1       2020-11-17 [1] CRAN (R 4.1.0)"                                                  
      [33] " memoise       2.0.0       2021-01-26 [1] CRAN (R 4.1.0)"                                                  
      [34] " pillar        1.6.3       2021-09-26 [1] CRAN (R 4.1.1)"                                                  
      [35] " pkgbuild      1.2.0       2020-12-15 [1] CRAN (R 4.1.0)"                                                  
      [36] " pkgconfig     2.0.3       2019-09-22 [1] CRAN (R 4.1.0)"                                                  
      [37] " pkgload       1.2.2       2021-09-11 [1] CRAN (R 4.1.0)"                                                  
      [38] " prettycode    1.1.0       2019-12-16 [1] CRAN (R 4.1.0)"                                                  
      [39] " prettyunits   1.1.1       2020-01-24 [1] CRAN (R 4.1.0)"                                                  
      [40] " processx      3.5.2.9000  2021-09-15 [1] local"                                                           
      [41] " prompt        1.0.0       2021-03-02 [1] local"                                                           
      [42] " ps            1.6.0       2021-02-28 [1] CRAN (R 4.1.0)"                                                  
      [43] " purrr         0.3.4       2020-04-17 [1] CRAN (R 4.1.0)"                                                  
      [44] " R6            2.5.1       2021-08-19 [1] CRAN (R 4.1.0)"                                                  
      [45] " remotes       2.4.0       2021-06-02 [1] CRAN (R 4.1.0)"                                                  
      [46] " rlang         0.99.0.9000 2021-10-07 [1] Github (r-lib/rlang@3ba19df)"                                    
      [47] " roxygen2      7.1.2       2021-10-04 [1] local"                                                           
      [48] " rprojroot     2.0.2       2020-11-15 [1] CRAN (R 4.1.0)"                                                  
      [49] " rstudioapi    0.13        2020-11-12 [1] CRAN (R 4.1.0)"                                                  
      [50] " sessioninfo * 1.1.1.9000  2021-10-05 [?] load_all()"                                                      
      [51] " stringi       1.7.4       2021-08-25 [1] CRAN (R 4.1.0)"                                                  
      [52] " stringr       1.4.0       2019-02-10 [1] CRAN (R 4.1.0)"                                                  
      [53] " testthat    * 3.0.4       2021-07-01 [1] CRAN (R 4.1.0)"                                                  
      [54] " tibble        3.1.4       2021-08-25 [1] CRAN (R 4.1.0)"                                                  
      [55] " usethis       2.0.1       2021-02-10 [1] CRAN (R 4.1.0)"                                                  
      [56] " utf8          1.2.2       2021-07-24 [1] CRAN (R 4.1.0)"                                                  
      [57] " vctrs         0.3.8       2021-04-29 [1] CRAN (R 4.1.0)"                                                  
      [58] " withr         2.4.2       2021-04-18 [1] CRAN (R 4.1.0)"                                                  
      [59] " xfun          0.26        2021-09-14 [1] CRAN (R 4.1.0)"                                                  
      [60] " xml2          1.3.2       2020-04-23 [1] CRAN (R 4.1.0)"                                                  
      [61] ""                                                                                                          
      [62] " [1] /Users/gaborcsardi/Library/R/x86_64/4.1/library"                                                      
      [63] " [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library"                                       

---

    Code
      find_session_info_in_html(url2, html)$text
    Output
       [1] "- Session info ---------------------------------------------------------------"
       [2] " setting  value                       "                                        
       [3] " version  R version 4.0.4 (2021-02-15)"                                        
       [4] " os       Windows 10 x64              "                                        
       [5] " system   x86_64, mingw32             "                                        
       [6] " ui       RTerm                       "                                        
       [7] " language (EN)                        "                                        
       [8] " collate  English_United States.1252  "                                        
       [9] " ctype    English_United States.1252  "                                        
      [10] " tz       America/Denver              "                                        
      [11] " date     2021-03-06                  "                                        
      [12] ""                                                                              
      [13] "- Packages -------------------------------------------------------------------"
      [14] " package     * version date       lib source           "                       
      [15] " assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.3)   "                       
      [16] " cli           2.3.0   2021-01-31 [1] CRAN (R 4.0.3)   "                       
      [17] " colorspace    2.0-0   2020-11-11 [1] CRAN (R 4.0.3)   "                       
      [18] " crayon        1.4.1   2021-02-08 [1] CRAN (R 4.0.4)   "                       
      [19] " DBI           1.1.1   2021-01-15 [1] CRAN (R 4.0.3)   "                       
      [20] " digest        0.6.27  2020-10-24 [1] CRAN (R 4.0.3)   "                       
      [21] " dplyr       * 1.0.5   2021-03-05 [1] standard (@1.0.5)"                       
      [22] " ellipsis      0.3.1   2020-05-15 [1] CRAN (R 4.0.3)   "                       
      [23] " evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.3)   "                       
      [24] " fs            1.5.0   2020-07-31 [1] CRAN (R 4.0.3)   "                       
      [25] " generics      0.1.0   2020-10-31 [1] CRAN (R 4.0.3)   "                       
      [26] " glue          1.4.2   2020-08-27 [1] CRAN (R 4.0.3)   "                       
      [27] " highr         0.8     2019-03-20 [1] CRAN (R 4.0.3)   "                       
      [28] " hms           1.0.0   2021-01-13 [1] CRAN (R 4.0.3)   "                       
      [29] " htmltools     0.5.1.1 2021-01-22 [1] CRAN (R 4.0.3)   "                       
      [30] " knitr         1.31    2021-01-27 [1] CRAN (R 4.0.3)   "                       
      [31] " lifecycle     1.0.0   2021-02-15 [1] CRAN (R 4.0.4)   "                       
      [32] " magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.0.3)   "                       
      [33] " munsell       0.5.0   2018-06-12 [1] CRAN (R 4.0.3)   "                       
      [34] " pillar        1.4.7   2020-11-20 [1] CRAN (R 4.0.3)   "                       
      [35] " pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.3)   "                       
      [36] " ps            1.5.0   2020-12-05 [1] CRAN (R 4.0.3)   "                       
      [37] " purrr         0.3.4   2020-04-17 [1] CRAN (R 4.0.3)   "                       
      [38] " R6            2.5.0   2020-10-28 [1] CRAN (R 4.0.3)   "                       
      [39] " readr       * 1.4.0   2020-10-05 [1] CRAN (R 4.0.3)   "                       
      [40] " reprex        1.0.0   2021-01-27 [1] CRAN (R 4.0.3)   "                       
      [41] " rlang         0.4.10  2020-12-30 [1] CRAN (R 4.0.3)   "                       
      [42] " rmarkdown     2.6     2020-12-14 [1] CRAN (R 4.0.3)   "                       
      [43] " rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.0.3)   "                       
      [44] " scales      * 1.1.1   2020-05-11 [1] CRAN (R 4.0.3)   "                       
      [45] " sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.3)   "                       
      [46] " stringi       1.5.3   2020-09-09 [1] CRAN (R 4.0.3)   "                       
      [47] " stringr       1.4.0   2019-02-10 [1] CRAN (R 4.0.3)   "                       
      [48] " tibble      * 3.0.6   2021-01-29 [1] CRAN (R 4.0.3)   "                       
      [49] " tidyselect    1.1.0   2020-05-11 [1] CRAN (R 4.0.3)   "                       
      [50] " vctrs         0.3.6   2020-12-17 [1] CRAN (R 4.0.3)   "                       
      [51] " withr         2.4.1   2021-01-26 [1] CRAN (R 4.0.3)   "                       
      [52] " xfun          0.20    2021-01-06 [1] CRAN (R 4.0.3)   "                       
      [53] " yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.3)   "                       
      [54] ""                                                                              
      [55] "[1] C:/Users/ayip/Documents/R/R-4.0.4/library"                                 

---

    Code
      find_session_info_in_html(url, html)
    Condition
      Error in `find_session_info_in_html()`:
      ! Cannot parse session info from 'https://github.com/r-lib/sessioninfo/issues/6'.

---

    Code
      find_session_info_in_html(url, html)
    Condition
      Error in `find_session_info_in_html()`:
      ! Cannot find session info at 'https://github.com/r-lib/sessioninfo/issues/6'.

# parse_url

    Code
      parse_url("https://github.com/r-lib/sessioninfo/issues/6")
    Output
        protocol username password       host                        path anchor
      1    https                   github.com /r-lib/sessioninfo/issues/6       

---

    Code
      parse_url(
        "https://github.com/r-lib/sessioninfo/issues/6#issuecomment-937772467")
    Output
        protocol username password       host                        path
      1    https                   github.com /r-lib/sessioninfo/issues/6
                        anchor
      1 issuecomment-937772467

# get_session_info_literal

    Code
      get_session_info_literal(structure(1, class = "foo"))
    Condition
      Error in `get_session_info_literal()`:
      ! Could not interpret a `foo` as a session info.

# beginning

    Code
      beginning("foo\nbar\nfoobar\nnotthis")
    Output
      [1] "foo"    "bar"    "foobar"

---

    Code
      beginning(c("foo", "bar", "foobar", "notthis"))
    Output
      [1] "foo"    "bar"    "foobar"

---

    Code
      beginning(strrep("123456789 ", 20))
    Output
      [1] "123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789"

# session_diff_text

    Code
      print(session_diff_text(x, y))
    Output
      @@ -1,2 +1,2 @@
       foo
      -bar
      +baz

---

    Code
      print(session_diff_text(x, y))
    Output
      @@ -1,2 +1,2 @@
       foo
      -bar
      +baz

# expand_diff_text

    Code
      xp1
    Output
      $old
       [1] "- Session info  ------------------------------------------"         
       [2] " hash: squid, supervillain: medium skin tone, ewe"                  
       [3] ""                                                                   
       [4] " setting  value"                                                    
       [5] " version  R version 4.1.1 (2021-08-10)"                             
       [6] " os       macOS Mojave 10.14.6"                                     
       [7] " system   x86_64, darwin17.0"                                       
       [8] " ui       X11"                                                      
       [9] " language (EN)"                                                     
      [10] " collate  C"                                                        
      [11] " ctype    en_US.UTF-8"                                              
      [12] " tz       Europe/Madrid"                                            
      [13] " date     2021-10-12"                                               
      [14] " pandoc   2.7.3 @ /usr/local/bin/pandoc"                            
      [15] ""                                                                   
      [16] "- Packages -----------------------------------------------"         
      [17] " ! package      * version    date (UTC) lib source"                 
      [18] "   cli            3.0.1.9000 2021-10-11 [1] local"                  
      [19] "   covr           3.5.1      2020-09-16 [1] CRAN (R 4.1.0)"         
      [20] "   crayon         1.4.1      2021-02-08 [1] CRAN (R 4.1.0)"         
      [21] "   desc           1.4.0.9000 2021-10-04 [1] local"                  
      [22] "   diffobj        0.3.4      2021-03-22 [1] CRAN (R 4.1.0)"         
      [23] "   ellipsis       0.3.2      2021-04-29 [1] CRAN (R 4.1.0)"         
      [24] "   evaluate       0.14       2019-05-28 [1] CRAN (R 4.1.0)"         
      [25] "   fansi          0.5.0      2021-05-25 [1] CRAN (R 4.1.0)"         
      [26] "   glue           1.4.2      2021-10-04 [1] local"                  
      [27] "   lazyeval       0.2.2      2019-03-15 [1] CRAN (R 4.1.0)"         
      [28] "   lifecycle      1.0.1      2021-09-24 [1] CRAN (R 4.1.0)"         
      [29] "   magrittr       2.0.1      2020-11-17 [1] CRAN (R 4.1.0)"         
      [30] "   mockery        0.4.2      2019-09-03 [1] CRAN (R 4.1.0)"         
      [31] "   pillar         1.6.3      2021-09-26 [1] CRAN (R 4.1.1)"         
      [32] "   pkgconfig      2.0.3      2019-09-22 [1] CRAN (R 4.1.0)"         
      [33] "   pkgload        1.2.2      2021-09-11 [1] CRAN (R 4.1.0)"         
      [34] "   prettycode     1.1.0      2019-12-16 [1] CRAN (R 4.1.0)"         
      [35] "   prompt         1.0.0      2021-03-02 [1] local"                  
      [36] "   ps             1.6.0      2021-02-28 [1] CRAN (R 4.1.0)"         
      [37] "   R6             2.5.1      2021-08-19 [1] CRAN (R 4.1.0)"         
      [38] "   rematch2       2.1.2      2020-05-01 [1] CRAN (R 4.1.0)"         
      [39] "   rex            1.2.0      2020-04-21 [1] CRAN (R 4.1.0)"         
      [40] "   rlang          0.4.11     2021-04-30 [1] CRAN (R 4.1.0)"         
      [41] "   rprojroot      2.0.2      2020-11-15 [1] CRAN (R 4.1.0)"         
      [42] "   rstudioapi     0.13       2020-11-12 [1] CRAN (R 4.1.0)"         
      [43] " P sessioninfo  * 1.1.1.9000 2021-10-12 [?] local"                  
      [44] "   testthat     * 3.0.4      2021-07-01 [1] CRAN (R 4.1.0)"         
      [45] "   testthatlabs   0.0.0.9000 2021-09-15 [1] local"                  
      [46] "   tibble         3.1.4      2021-08-25 [1] CRAN (R 4.1.0)"         
      [47] "   utf8           1.2.2      2021-07-24 [1] CRAN (R 4.1.0)"         
      [48] "   vctrs          0.3.8      2021-04-29 [1] CRAN (R 4.1.0)"         
      [49] "   waldo          0.3.1      2021-09-14 [1] CRAN (R 4.1.0)"         
      [50] "   withr          2.4.2      2021-04-18 [1] CRAN (R 4.1.0)"         
      [51] ""                                                                   
      [52] " [1] /Users/gaborcsardi/Library/R/x86_64/4.1/library"               
      [53] " [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library"
      [54] ""                                                                   
      [55] " P -- Loaded and on-disk path mismatch."                            
      [56] ""                                                                   
      [57] "----------------------------------------------------------"         
      
      $new
       [1] "- Session info  ------------------------------------------"         
       [2] " hash: squid, supervillain: medium skin tone, ewe"                  
       [3] ""                                                                   
       [4] " setting  value"                                                    
       [5] " version  R version 4.1.1 (2021-08-10)"                             
       [6] " os       macOS Mojave 10.14.6"                                     
       [7] " system   x86_64, darwin17.0"                                       
       [8] " ui       X11"                                                      
       [9] " language (EN)"                                                     
      [10] " collate  C"                                                        
      [11] " ctype    en_US.UTF-8"                                              
      [12] " tz       Europe/Madrid"                                            
      [13] " date     2021-10-12"                                               
      [14] " pandoc   2.7.3 @ /usr/local/bin/pandoc"                            
      [15] ""                                                                   
      [16] "- Packages -----------------------------------------------"         
      [17] " ! package      * version    date (UTC) lib source"                 
      [18] "   diffobj        0.3.4      2021-03-22 [1] CRAN (R 4.1.0)"         
      [19] "   ellipsis       0.3.2      2021-04-29 [1] CRAN (R 4.1.0)"         
      [20] "   evaluate       0.14       2019-05-28 [1] CRAN (R 4.1.0)"         
      [21] "   fansi          0.5.0      2021-05-25 [1] CRAN (R 4.1.0)"         
      [22] "   glue           1.4.2      2021-10-04 [1] local"                  
      [23] "   lazyeval       0.2.2      2019-03-15 [1] CRAN (R 4.1.0)"         
      [24] "   lifecycle      1.0.1      2021-09-24 [1] CRAN (R 4.1.0)"         
      [25] "   magrittr       2.0.1      2020-11-17 [1] CRAN (R 4.1.0)"         
      [26] "   mockery        0.4.2      2019-09-03 [1] CRAN (R 4.1.0)"         
      [27] "   pillar         1.6.3      2021-09-26 [1] CRAN (R 4.1.1)"         
      [28] "   pkgconfig      2.0.3      2019-09-22 [1] CRAN (R 4.1.0)"         
      [29] "   pkgload        1.2.2      2021-09-11 [1] CRAN (R 4.1.0)"         
      [30] "   prettycode     1.1.0      2019-12-16 [1] CRAN (R 4.1.0)"         
      [31] "   prompt         1.0.0      2021-03-02 [1] local"                  
      [32] "   ps             1.6.0      2021-02-28 [1] CRAN (R 4.1.0)"         
      [33] "   R6             2.5.1      2021-08-19 [1] CRAN (R 4.1.0)"         
      [34] "   rematch2       2.1.2      2020-05-01 [1] CRAN (R 4.1.0)"         
      [35] "   rex            1.2.0      2020-04-21 [1] CRAN (R 4.1.0)"         
      [36] "   rlang          0.4.11     2021-04-30 [1] CRAN (R 4.1.0)"         
      [37] "   rprojroot      2.0.2      2020-11-15 [1] CRAN (R 4.1.0)"         
      [38] "   rstudioapi     0.13       2020-11-12 [1] CRAN (R 4.1.0)"         
      [39] "   sessioninfo  * 1.1.1      2021-10-12 [?] local"                  
      [40] "   testthat     * 3.0.4      2021-07-01 [1] CRAN (R 4.1.0)"         
      [41] "   tibble         3.1.4      2021-08-25 [1] CRAN (R 4.1.0)"         
      [42] "   utf8           1.2.2      2021-07-24 [1] CRAN (R 4.1.0)"         
      [43] "   vctrs          0.3.8      2021-04-29 [1] CRAN (R 4.1.0)"         
      [44] "   waldo          0.3.1      2021-09-14 [1] CRAN (R 4.1.0)"         
      [45] "   withr          2.4.2      2021-04-18 [1] CRAN (R 4.1.0)"         
      [46] ""                                                                   
      [47] " [1] /Users/gaborcsardi/Library/R/x86_64/4.1/library"               
      [48] " [2] /Library/Frameworks/R.framework/Versions/4.1/Resources/library"
      [49] ""                                                                   
      [50] "----------------------------------------------------------"         
      

# parse_pkgs

    Code
      names(pkgs$pkgs)
    Output
      [1] "!"          "package"    "*"          "version"    "date (UTC)"
      [6] "lib"        "source"    

---

    Code
      pkgs$pkgs[["!"]]
    Output
       [1] ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  "P"
      [20] ""  ""  ""  "" 

---

    Code
      pkgs$pkgs$package
    Output
       [1] "cli"          "covr"         "crayon"       "desc"         "evaluate"    
       [6] "glue"         "lazyeval"     "lifecycle"    "magrittr"     "pkgload"     
      [11] "prettycode"   "prompt"       "ps"           "R6"           "rex"         
      [16] "rlang"        "rprojroot"    "rstudioapi"   "sessioninfo"  "testthat"    
      [21] "testthatlabs" "waldo"        "withr"       

---

    Code
      pkgs$pkgs
    Output
         !      package *    version date (UTC) lib         source
      1             cli   3.0.1.9000 2021-10-11 [1]          local
      2            covr        3.5.1 2020-09-16 [1] CRAN (R 4.1.0)
      3          crayon        1.4.1 2021-02-08 [1] CRAN (R 4.1.0)
      4            desc   1.4.0.9000 2021-10-04 [1]          local
      5        evaluate         0.14 2019-05-28 [1] CRAN (R 4.1.0)
      6            glue        1.4.2 2021-10-04 [1]          local
      7        lazyeval        0.2.2 2019-03-15 [1] CRAN (R 4.1.0)
      8       lifecycle        1.0.1 2021-09-24 [1] CRAN (R 4.1.0)
      9        magrittr        2.0.1 2020-11-17 [1] CRAN (R 4.1.0)
      10        pkgload        1.2.2 2021-09-11 [1] CRAN (R 4.1.0)
      11     prettycode        1.1.0 2019-12-16 [1] CRAN (R 4.1.0)
      12         prompt        1.0.0 2021-03-02 [1]          local
      13             ps        1.6.0 2021-02-28 [1] CRAN (R 4.1.0)
      14             R6        2.5.1 2021-08-19 [1] CRAN (R 4.1.0)
      15            rex        1.2.0 2020-04-21 [1] CRAN (R 4.1.0)
      16          rlang       0.4.11 2021-04-30 [1] CRAN (R 4.1.0)
      17      rprojroot        2.0.2 2020-11-15 [1] CRAN (R 4.1.0)
      18     rstudioapi         0.13 2020-11-12 [1] CRAN (R 4.1.0)
      19 P  sessioninfo * 1.1.1.9000 2021-10-12 [?]          local
      20       testthat *      3.0.4 2021-07-01 [1] CRAN (R 4.1.0)
      21   testthatlabs   0.0.0.9000 2021-09-15 [1]          local
      22          waldo        0.3.1 2021-09-14 [1] CRAN (R 4.1.0)
      23          withr        2.4.2 2021-04-18 [1] CRAN (R 4.1.0)

# parse_pkgs_section

    Code
      names(pkgs)
    Output
      [1] "!"          "package"    "*"          "version"    "date (UTC)"
      [6] "lib"        "source"    

---

    Code
      pkgs[["!"]]
    Output
       [1] ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  ""  "" 
      [20] ""  ""  ""  ""  "P" ""  ""  ""  ""  ""  ""  "" 

---

    Code
      pkgs$package
    Output
       [1] "cli"          "covr"         "crayon"       "desc"         "diffobj"     
       [6] "ellipsis"     "fansi"        "glue"         "lazyeval"     "lifecycle"   
      [11] "magrittr"     "pillar"       "pkgconfig"    "pkgload"      "prettycode"  
      [16] "prompt"       "ps"           "R6"           "rematch2"     "rex"         
      [21] "rlang"        "rprojroot"    "rstudioapi"   "sessioninfo"  "testthat"    
      [26] "testthatlabs" "tibble"       "utf8"         "vctrs"        "waldo"       
      [31] "withr"       

---

    Code
      pkgs
    Output
         !      package *    version date (UTC) lib         source
      1             cli   3.0.1.9000 2021-10-11 [1]          local
      2            covr        3.5.1 2020-09-16 [1] CRAN (R 4.1.0)
      3          crayon        1.4.1 2021-02-08 [1] CRAN (R 4.1.0)
      4            desc   1.4.0.9000 2021-10-04 [1]          local
      5         diffobj        0.3.4 2021-03-22 [1] CRAN (R 4.1.0)
      6        ellipsis        0.3.2 2021-04-29 [1] CRAN (R 4.1.0)
      7           fansi        0.5.0 2021-05-25 [1] CRAN (R 4.1.0)
      8            glue        1.4.2 2021-10-04 [1]          local
      9        lazyeval        0.2.2 2019-03-15 [1] CRAN (R 4.1.0)
      10      lifecycle        1.0.1 2021-09-24 [1] CRAN (R 4.1.0)
      11       magrittr        2.0.1 2020-11-17 [1] CRAN (R 4.1.0)
      12         pillar        1.6.3 2021-09-26 [1] CRAN (R 4.1.1)
      13      pkgconfig        2.0.3 2019-09-22 [1] CRAN (R 4.1.0)
      14        pkgload        1.2.2 2021-09-11 [1] CRAN (R 4.1.0)
      15     prettycode        1.1.0 2019-12-16 [1] CRAN (R 4.1.0)
      16         prompt        1.0.0 2021-03-02 [1]          local
      17             ps        1.6.0 2021-02-28 [1] CRAN (R 4.1.0)
      18             R6        2.5.1 2021-08-19 [1] CRAN (R 4.1.0)
      19       rematch2        2.1.2 2020-05-01 [1] CRAN (R 4.1.0)
      20            rex        1.2.0 2020-04-21 [1] CRAN (R 4.1.0)
      21          rlang       0.4.11 2021-04-30 [1] CRAN (R 4.1.0)
      22      rprojroot        2.0.2 2020-11-15 [1] CRAN (R 4.1.0)
      23     rstudioapi         0.13 2020-11-12 [1] CRAN (R 4.1.0)
      24 P  sessioninfo * 1.1.1.9000 2021-10-07 [?]          local
      25       testthat *      3.0.4 2021-07-01 [1] CRAN (R 4.1.0)
      26   testthatlabs   0.0.0.9000 2021-09-15 [1]          local
      27         tibble        3.1.4 2021-08-25 [1] CRAN (R 4.1.0)
      28           utf8        1.2.2 2021-07-24 [1] CRAN (R 4.1.0)
      29          vctrs        0.3.8 2021-04-29 [1] CRAN (R 4.1.0)
      30          waldo        0.3.1 2021-09-14 [1] CRAN (R 4.1.0)
      31          withr        2.4.2 2021-04-18 [1] CRAN (R 4.1.0)

---

    Code
      names(pkgs2)
    Output
      [1] "package"    "*"          "version"    "date (UTC)" "lib"       
      [6] "source"    

---

    Code
      pkgs2[["!"]]
    Output
      NULL

---

    Code
      pkgs2$package
    Output
      [1] "cli"         "crayon"      "prettycode"  "prompt"      "ps"         
      [6] "sessioninfo" "withr"      

---

    Code
      pkgs2
    Output
            package *    version date (UTC) lib         source
      1         cli   3.0.1.9000 2021-10-11 [1]          local
      2      crayon        1.4.1 2021-02-08 [1] CRAN (R 4.1.0)
      3  prettycode        1.1.0 2019-12-16 [1] CRAN (R 4.1.0)
      4      prompt        1.0.0 2021-03-02 [1]          local
      5          ps        1.6.0 2021-02-28 [1] CRAN (R 4.1.0)
      6 sessioninfo   1.1.1.9000 2021-10-12 [1]          local
      7       withr        2.4.2 2021-04-18 [1] CRAN (R 4.1.0)

