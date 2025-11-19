# Calculate Grades

This function calculates all grades based on the policy file. This
function is called within
[`get_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/get_grades.md)
because it requires previous data processing. Note that the example
below is essentially the functionality of
[`get_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/get_grades.md).

## Usage

``` r
calculate_grades(gs, policy)
```

## Arguments

- gs:

  A Gradescope dataframe

- policy:

  A grading policy file as an R list

## Value

A dataframe of the original Gradescope data with computed categories'
scores appended as additional columns

## Examples

``` r
gs <- process_gs(gs = gs_demo)
policy <- process_policy(policy = policy_demo, verbose = TRUE)
policy <- reconcile_policy_with_gs(policy = policy, gs = gs_demo, verbose = TRUE)
calculate_grades(gs = gs, policy = policy)
#>                  Names                           Email        SID
#> 1            Dr. Kadin           Dr.Kadin@berkeley.edu 3032412514
#> 2          Bartley Toy         BartleyToy@berkeley.edu 3032412515
#> 3           Dr. Dontae          Dr.Dontae@berkeley.edu 3032412516
#> 4  Narcissus Considine NarcissusConsidine@berkeley.edu 3032412517
#> 5      Verne Wilderman     VerneWilderman@berkeley.edu 3032412518
#> 6        Toivo Witting       ToivoWitting@berkeley.edu 3032412519
#> 7         Tegan Crooks        TeganCrooks@berkeley.edu 3032412520
#> 8  Tyrus Cremin-Wisozk TyrusCremin-Wisozk@berkeley.edu 3032412521
#> 9         Sydni Hansen        SydniHansen@berkeley.edu 3032412522
#> 10        Mrs. Chelsie        Mrs.Chelsie@berkeley.edu 3032412523
#>           Sections Lab 1 Lab 1 - Max Points Lab 1 - Submission Time
#> 1  fake-class-2023   0.9                 10                       7
#> 2  fake-class-2023   0.5                 10                       5
#> 3  fake-class-2023   1.0                 10                       2
#> 4  fake-class-2023   1.0                 10                      10
#> 5  fake-class-2023   0.8                 10                       4
#> 6  fake-class-2023   0.9                 10                       6
#> 7  fake-class-2023   0.8                 10                       9
#> 8  fake-class-2023   0.2                 10                       3
#> 9  fake-class-2023   0.8                 10                       1
#> 10 fake-class-2023   0.5                 10                       8
#>    Lab 1 - Lateness (H:M:S) Lab 2 Lab 2 - Max Points Lab 2 - Submission Time
#> 1                  00:00:00  0.25                 20                      10
#> 2                  00:00:00  1.00                 20                       6
#> 3                  00:00:00  0.60                 20                       7
#> 4                  00:00:00  0.05                 20                       1
#> 5                  00:00:00  0.50                 20                       3
#> 6                  00:00:00  0.10                 20                       5
#> 7                  11:25:51  0.55                 20                       9
#> 8                  00:00:00  1.00                 20                       2
#> 9                  00:00:00  0.15                 20                       8
#> 10                 00:34:45  0.95                 20                       4
#>    Lab 2 - Lateness (H:M:S)      Lab 3 Lab 3 - Max Points
#> 1                  47:55:53 0.46666667                 15
#> 2                  00:00:00 0.06666667                 15
#> 3                  00:00:00 1.00000000                 15
#> 4                  00:00:00 0.53333333                 15
#> 5                  00:00:00 0.60000000                 15
#> 6                  00:00:00 0.60000000                 15
#> 7                  00:00:17 0.46666667                 15
#> 8                  00:00:00 0.60000000                 15
#> 9                  00:00:00 0.93333333                 15
#> 10                 00:00:00 1.00000000                 15
#>    Lab 3 - Submission Time Lab 3 - Lateness (H:M:S) Lab 4 Lab 4 - Max Points
#> 1                        6                 00:00:00   0.9                 10
#> 2                        2                 00:00:00   0.5                 10
#> 3                        1                 00:00:00   0.8                 10
#> 4                       10                 08:57:32   0.6                 10
#> 5                        9                 14:59:55   0.1                 10
#> 6                        4                 00:00:00   1.0                 10
#> 7                        7                 00:00:00   1.0                 10
#> 8                        3                 00:00:00   0.3                 10
#> 9                        5                 00:00:00   0.9                 10
#> 10                       8                 13:12:53   0.2                 10
#>    Lab 4 - Submission Time Lab 4 - Lateness (H:M:S) Lab 5 Lab 5 - Max Points
#> 1                        5                 00:00:00   0.0                  5
#> 2                        9                 00:00:00   0.2                  5
#> 3                        1                 00:00:00   0.6                  5
#> 4                        3                 00:00:00   0.2                  5
#> 5                       10                 14:10:40   0.8                  5
#> 6                        6                 00:00:00   1.0                  5
#> 7                        7                 00:00:00   0.8                  5
#> 8                        8                 00:00:00   1.0                  5
#> 9                        4                 00:00:00   1.0                  5
#> 10                       2                 00:00:00   0.8                  5
#>    Lab 5 - Submission Time Lab 5 - Lateness (H:M:S) Lab 6 Lab 6 - Max Points
#> 1                        7                 00:00:00   0.4                 10
#> 2                        2                 00:00:00   0.0                 10
#> 3                        5                 00:00:00   0.6                 10
#> 4                        3                 00:00:00   1.0                 10
#> 5                        4                 00:00:00   0.0                 10
#> 6                        8                 00:00:00   0.1                 10
#> 7                        1                 00:00:00   0.4                 10
#> 8                        6                 00:00:00   1.0                 10
#> 9                        9                 00:00:00   0.3                 10
#> 10                      10                 09:31:21   1.0                 10
#>    Lab 6 - Submission Time Lab 6 - Lateness (H:M:S) Discussion 1
#> 1                        3                 00:00:00         1.00
#> 2                        2                 00:00:00         1.00
#> 3                        1                 00:00:00         1.00
#> 4                        4                 00:00:00         0.75
#> 5                        9                 00:00:00         1.00
#> 6                        6                 00:00:00         1.00
#> 7                        5                 00:00:00         1.00
#> 8                        7                 00:00:00         1.00
#> 9                       10                 12:24:26         0.00
#> 10                       8                 00:00:00         0.75
#>    Discussion 1 - Max Points Discussion 1 - Submission Time
#> 1                          4                              6
#> 2                          4                              4
#> 3                          4                              1
#> 4                          4                             10
#> 5                          4                              9
#> 6                          4                              2
#> 7                          4                              8
#> 8                          4                              3
#> 9                          4                              7
#> 10                         4                              5
#>    Discussion 1 - Lateness (H:M:S) Discussion 2 Discussion 2 - Max Points
#> 1                  00:00:00.000000         1.00                         4
#> 2                  00:00:00.000000         1.00                         4
#> 3                  00:00:00.000000         0.75                         4
#> 4                  08:23:06.000000         1.00                         4
#> 5                  01:06:36.000000         0.75                         4
#> 6                  00:00:00.000000         1.00                         4
#> 7                  00:34:58.000000         0.75                         4
#> 8                  00:00:00.000000         1.00                         4
#> 9                  00:00:00.000000         1.00                         4
#> 10                 00:00:00.000000         1.00                         4
#>    Discussion 2 - Submission Time Discussion 2 - Lateness (H:M:S) Midterm
#> 1                               2                        00:50:32  0.0176
#> 2                               5                        00:00:00  0.0000
#> 3                               4                        00:00:00  0.0068
#> 4                               6                        00:00:00  0.0060
#> 5                               3                        14:22:13  0.0032
#> 6                               9                        00:00:00  0.0124
#> 7                               1                        00:30:20  0.0116
#> 8                               7                        00:00:00  0.0016
#> 9                              10                        00:00:00  0.0016
#> 10                              8                        00:00:00  0.0188
#>    Midterm - Max Points Midterm - Submission Time Midterm - Lateness (H:M:S)
#> 1                    50                         7                   00:00:00
#> 2                    50                         3                   00:00:00
#> 3                    50                         2                   00:00:00
#> 4                    50                         6                   00:00:00
#> 5                    50                        10                   00:52:01
#> 6                    50                         9                   00:00:00
#> 7                    50                         8                   00:00:00
#> 8                    50                         5                   00:00:00
#> 9                    50                         4                   00:00:00
#> 10                   50                         1                   00:00:00
#>     Final Final - Max Points Final - Submission Time Final - Lateness (H:M:S)
#> 1  0.0010                100                       4                 00:00:00
#> 2  0.0078                100                       1                 00:00:00
#> 3  0.0024                100                       8                 00:00:00
#> 4  0.0089                100                       9                 00:00:00
#> 5  0.0097                100                       5                 00:00:00
#> 6  0.0051                100                       6                 00:00:00
#> 7  0.0058                100                      10                 00:00:00
#> 8  0.0080                100                       2                 00:00:00
#> 9  0.0083                100                       7                 00:00:00
#> 10 0.0053                100                       3                 00:00:00
#>           Labs Labs - Max Points Labs - Lateness (H:M:S) Discussion
#> 1  0.006938776                70                47:55:53   0.125000
#> 2  0.006530612                70                00:00:00   0.125000
#> 3  0.011020408                70                00:00:00   0.109375
#> 4  0.007346939                70                08:57:32   0.109375
#> 5  0.006530612                70                14:59:55   0.109375
#> 6  0.007346939                70                00:00:00   0.125000
#> 7  0.008979592                70                11:25:51   0.109375
#> 8  0.010000000                70                00:00:00   0.125000
#> 9  0.008571429                70                12:24:26   0.062500
#> 10 0.011224490                70                13:12:53   0.109375
#>    Discussion - Max Points Discussion - Lateness (H:M:S) Midterm Exam
#> 1                        8                      00:50:32         0.88
#> 2                        8                      00:00:00         0.00
#> 3                        8                      00:00:00         0.34
#> 4                        8                      08:23:06         0.30
#> 5                        8                      14:22:13         0.16
#> 6                        8                      00:00:00         0.62
#> 7                        8                      00:34:58         0.58
#> 8                        8                      00:00:00         0.08
#> 9                        8                      00:00:00         0.08
#> 10                       8                      00:00:00         0.94
#>    Midterm Exam - Max Points Midterm Exam - Lateness (H:M:S) Final Exam
#> 1                         50                        00:00:00       0.10
#> 2                         50                        00:00:00       0.78
#> 3                         50                        00:00:00       0.24
#> 4                         50                        00:00:00       0.89
#> 5                         50                        00:52:01       0.97
#> 6                         50                        00:00:00       0.51
#> 7                         50                        00:00:00       0.58
#> 8                         50                        00:00:00       0.80
#> 9                         50                        00:00:00       0.83
#> 10                        50                        00:00:00       0.53
#>    Final Exam - Max Points Final Exam - Lateness (H:M:S) Overall Grade
#> 1                      100                      00:00:00    0.02016163
#> 2                      100                      00:00:00    0.01679918
#> 3                      100                      00:00:00    0.01700362
#> 4                      100                      00:00:00    0.01761158
#> 5                      100                      00:00:00    0.01676668
#> 6                      100                      00:00:00    0.01995408
#> 7                      100                      00:00:00    0.01885138
#> 8                      100                      00:00:00    0.01838000
#> 9                      100                      00:00:00    0.01179143
#> 10                     100                      00:00:00    0.02153485
#>    Overall Grade - Max Points Overall Grade - Lateness (H:M:S)
#> 1                         228                         47:55:53
#> 2                         228                         00:00:00
#> 3                         228                         00:00:00
#> 4                         228                         08:57:32
#> 5                         228                         14:59:55
#> 6                         228                         00:00:00
#> 7                         228                         11:25:51
#> 8                         228                         00:00:00
#> 9                         228                         12:24:26
#> 10                        228                         13:12:53
```
