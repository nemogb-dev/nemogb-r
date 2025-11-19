# Applying Slip Days to Your Grading Policy

Slip days are a unique grading policy, where there is an allotted budget
of allowed lateness that can be applied to certain assignments. Here’s
an example of what that looks like in a policy file. Note that
`slip_days` are their own separate section in the grading policy and do
no fall under the other `categories` grading criteria. Often, slip days
are computed prior to applying other grading policies because they
adjust the lateness.

``` yaml
coursewide:
  course_name: Stat 101
  description: Syllabus for gs_demo
slip_days:
  - name: "Slip Days 1"
    num_slip_days: 2
    order: chronological
    assignments:
        - "Lab 1"
        - "Lab 2"
        - "Lab 3"
        - "Lab 4"
        - "Lab 5"
        - "Lab 6"
categories:
  - category: Overall Grade
    aggregation: weighted_mean
    assignments:
    - category: Labs
      lateness:
      - after: "00:00:01"
      - set_to: 0.0
      aggregation: weighted_by_points
      weight: 0.3
      assignments:
        - "Lab 1"
        - "Lab 2"
        - "Lab 3"
        - "Lab 4"
        - "Lab 5"
        - "Lab 6"
    - category: Discussion
      aggregation: equally_weighted
      weight: 0.1
      assignments:
        - "Discussion 1"
        - "Discussion 2"
    - category: Midterm Exam
      aggregation: none
      weight: 0.3
      assignments:
        - "Midterm"
    - category: Final Exam
      aggregation: none
      weight: 0.3
      assignments:
        - "Final"
```

In this policy, there are 2 allotted slip days for the six Lab
assignments. This means that students can turn in Lab assignments up to
2 days late with no additional lateness penalty applied. Usually, these
slip days are allotted chronologically, so if a student turns in Lab 1 2
days late, they do not have any more slip days that can be used for
later Lab assignments. Similarly, if a student turned in Lab 1 a day
late, they can still turn in one of the other labs at most a day late
with no penalty. Lateness is rounded up to the next day, so a student
will use a slip day if their assignment is turned in 1 minute late or 23
hours late.

The `order` key here explicitly determines that the order in which slip
days are allotted is `chronological`. This is the default if there was
no `order` key is provided. Another accepted key is `given`, which
allocates slip days based on the order given in the policy file in
`assignments` under `slipdays` with no regard to the chronological order
of these assignments.

The lateness policy for `Labs` in `categories` section shows that any
late assignments receive a zero. This is applied after a student’s slip
days run out.

The process for computing the grades using `nemogb` is the same as any
other policy file, as demonstrated below.

``` r
library(nemogb)
gs <- read_gs(system.file("extdata", "gs_demo.csv", package = "nemogb"))
#> Rows: 10 Columns: 44
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr  (13): Names, Email, Sections, Lab 1 - Submission Time, Lab 2 - Submissi...
#> dbl  (21): SID, Lab 1, Lab 1 - Max Points, Lab 2, Lab 2 - Max Points, Lab 3,...
#> time (10): Lab 1 - Lateness (H:M:S), Lab 2 - Lateness (H:M:S), Lab 3 - Laten...
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
policy <- read_policy(system.file("extdata", "slip-days-policy-demo.yaml", package = "nemogb"))
grades <- get_grades(gs, policy)
```

Here is what the grades look like:

| Names               | Email                             | SID        | Sections        | Remaining: Slip Days 1 | Lab 1 | Lab 1 - Max Points | Lab 1 - Submission Time | Lab 1 - Lateness (H:M:S) | Lab 2 | Lab 2 - Max Points | Lab 2 - Submission Time | Lab 2 - Lateness (H:M:S) |     Lab 3 | Lab 3 - Max Points | Lab 3 - Submission Time | Lab 3 - Lateness (H:M:S) | Lab 4 | Lab 4 - Max Points | Lab 4 - Submission Time | Lab 4 - Lateness (H:M:S) | Lab 5 | Lab 5 - Max Points | Lab 5 - Submission Time | Lab 5 - Lateness (H:M:S) | Lab 6 | Lab 6 - Max Points | Lab 6 - Submission Time | Lab 6 - Lateness (H:M:S) | Discussion 1 | Discussion 1 - Max Points | Discussion 1 - Submission Time | Discussion 1 - Lateness (H:M:S) | Discussion 2 | Discussion 2 - Max Points | Discussion 2 - Submission Time | Discussion 2 - Lateness (H:M:S) | Midterm | Midterm - Max Points | Midterm - Submission Time | Midterm - Lateness (H:M:S) | Final | Final - Max Points | Final - Submission Time | Final - Lateness (H:M:S) |      Labs | Labs - Max Points | Labs - Lateness (H:M:S) | Discussion | Discussion - Max Points | Discussion - Lateness (H:M:S) | Midterm Exam | Midterm Exam - Max Points | Midterm Exam - Lateness (H:M:S) | Final Exam | Final Exam - Max Points | Final Exam - Lateness (H:M:S) | Overall Grade | Overall Grade - Max Points | Overall Grade - Lateness (H:M:S) |
|:--------------------|:----------------------------------|:-----------|:----------------|-----------------------:|------:|-------------------:|------------------------:|:-------------------------|------:|-------------------:|------------------------:|:-------------------------|----------:|-------------------:|------------------------:|:-------------------------|------:|-------------------:|------------------------:|:-------------------------|------:|-------------------:|------------------------:|:-------------------------|------:|-------------------:|------------------------:|:-------------------------|-------------:|--------------------------:|-------------------------------:|:--------------------------------|-------------:|--------------------------:|-------------------------------:|:--------------------------------|--------:|---------------------:|--------------------------:|:---------------------------|------:|-------------------:|------------------------:|:-------------------------|----------:|------------------:|:------------------------|-----------:|------------------------:|:------------------------------|-------------:|--------------------------:|:--------------------------------|-----------:|------------------------:|:------------------------------|--------------:|---------------------------:|:---------------------------------|
| Dr. Kadin           | <Dr.Kadin@berkeley.edu>           | 3032412514 | fake-class-2023 |                      0 |   0.9 |                 10 |                       7 | 00:00:00                 |  0.25 |                 20 |                      10 | 00:00:00                 | 0.4666667 |                 15 |                       6 | 00:00:00                 |   0.9 |                 10 |                       5 | 00:00:00                 |   0.0 |                  5 |                       7 | 00:00:00                 |   0.4 |                 10 |                       4 | 00:00:00                 |         1.00 |                         4 |                              6 | 00:00:00.000000                 |         1.00 |                         4 |                              2 | 00:50:32                        |    0.88 |                   50 |                         7 | 00:00:00                   |  0.10 |                100 |                       4 | 00:00:00                 | 0.4857143 |                70 | 00:00:00                |      1.000 |                       8 | 00:50:32                      |         0.88 |                        50 | 00:00:00                        |       0.10 |                     100 | 00:00:00                      |     0.5397143 |                        228 | 00:50:32                         |
| Bartley Toy         | <BartleyToy@berkeley.edu>         | 3032412515 | fake-class-2023 |                      2 |   0.5 |                 10 |                       5 | 00:00:00                 |  1.00 |                 20 |                       6 | 00:00:00                 | 0.0666667 |                 15 |                       2 | 00:00:00                 |   0.5 |                 10 |                       9 | 00:00:00                 |   0.2 |                  5 |                       2 | 00:00:00                 |   0.0 |                 10 |                       3 | 00:00:00                 |         1.00 |                         4 |                              4 | 00:00:00.000000                 |         1.00 |                         4 |                              5 | 00:00:00                        |    0.00 |                   50 |                         3 | 00:00:00                   |  0.78 |                100 |                       1 | 00:00:00                 | 0.4571429 |                70 | 00:00:00                |      1.000 |                       8 | 00:00:00                      |         0.00 |                        50 | 00:00:00                        |       0.78 |                     100 | 00:00:00                      |     0.4711429 |                        228 | 00:00:00                         |
| Dr. Dontae          | <Dr.Dontae@berkeley.edu>          | 3032412516 | fake-class-2023 |                      2 |   1.0 |                 10 |                       2 | 00:00:00                 |  0.60 |                 20 |                       7 | 00:00:00                 | 1.0000000 |                 15 |                       1 | 00:00:00                 |   0.8 |                 10 |                       1 | 00:00:00                 |   0.6 |                  5 |                       5 | 00:00:00                 |   0.6 |                 10 |                       2 | 00:00:00                 |         1.00 |                         4 |                              1 | 00:00:00.000000                 |         0.75 |                         4 |                              4 | 00:00:00                        |    0.34 |                   50 |                         2 | 00:00:00                   |  0.24 |                100 |                       8 | 00:00:00                 | 0.7714286 |                70 | 00:00:00                |      0.875 |                       8 | 00:00:00                      |         0.34 |                        50 | 00:00:00                        |       0.24 |                     100 | 00:00:00                      |     0.4929286 |                        228 | 00:00:00                         |
| Narcissus Considine | <NarcissusConsidine@berkeley.edu> | 3032412517 | fake-class-2023 |                      1 |   1.0 |                 10 |                      10 | 00:00:00                 |  0.05 |                 20 |                       1 | 00:00:00                 | 0.5333333 |                 15 |                      10 | 00:00:00                 |   0.6 |                 10 |                       3 | 00:00:00                 |   0.2 |                  5 |                       3 | 00:00:00                 |   1.0 |                 10 |                       5 | 00:00:00                 |         0.75 |                         4 |                             10 | 08:23:06.000000                 |         1.00 |                         4 |                              6 | 00:00:00                        |    0.30 |                   50 |                         6 | 00:00:00                   |  0.89 |                100 |                       9 | 00:00:00                 | 0.5142857 |                70 | 00:00:00                |      0.875 |                       8 | 08:23:06                      |         0.30 |                        50 | 00:00:00                        |       0.89 |                     100 | 00:00:00                      |     0.5987857 |                        228 | 08:23:06                         |
| Verne Wilderman     | <VerneWilderman@berkeley.edu>     | 3032412518 | fake-class-2023 |                      0 |   0.8 |                 10 |                       4 | 00:00:00                 |  0.50 |                 20 |                       3 | 00:00:00                 | 0.6000000 |                 15 |                       9 | 00:00:00                 |   0.1 |                 10 |                      10 | 00:00:00                 |   0.8 |                  5 |                       4 | 00:00:00                 |   0.0 |                 10 |                       9 | 00:00:00                 |         1.00 |                         4 |                              9 | 01:06:36.000000                 |         0.75 |                         4 |                              3 | 14:22:13                        |    0.16 |                   50 |                        10 | 00:52:01                   |  0.97 |                100 |                       5 | 00:00:00                 | 0.4571429 |                70 | 00:00:00                |      0.875 |                       8 | 14:22:13                      |         0.16 |                        50 | 00:52:01                        |       0.97 |                     100 | 00:00:00                      |     0.5636429 |                        228 | 14:22:13                         |
| Toivo Witting       | <ToivoWitting@berkeley.edu>       | 3032412519 | fake-class-2023 |                      2 |   0.9 |                 10 |                       6 | 00:00:00                 |  0.10 |                 20 |                       5 | 00:00:00                 | 0.6000000 |                 15 |                       4 | 00:00:00                 |   1.0 |                 10 |                       7 | 00:00:00                 |   1.0 |                  5 |                       8 | 00:00:00                 |   0.1 |                 10 |                       7 | 00:00:00                 |         1.00 |                         4 |                              2 | 00:00:00.000000                 |         1.00 |                         4 |                              9 | 00:00:00                        |    0.62 |                   50 |                         9 | 00:00:00                   |  0.51 |                100 |                       6 | 00:00:00                 | 0.5142857 |                70 | 00:00:00                |      1.000 |                       8 | 00:00:00                      |         0.62 |                        50 | 00:00:00                        |       0.51 |                     100 | 00:00:00                      |     0.5932857 |                        228 | 00:00:00                         |
| Tegan Crooks        | <TeganCrooks@berkeley.edu>        | 3032412520 | fake-class-2023 |                      0 |   0.8 |                 10 |                       9 | 00:00:00                 |  0.55 |                 20 |                       9 | 00:00:00                 | 0.4666667 |                 15 |                       7 | 00:00:00                 |   1.0 |                 10 |                       8 | 00:00:00                 |   0.8 |                  5 |                       1 | 00:00:00                 |   0.4 |                 10 |                       6 | 00:00:00                 |         1.00 |                         4 |                              8 | 00:34:58.000000                 |         0.75 |                         4 |                              1 | 00:30:20                        |    0.58 |                   50 |                         8 | 00:00:00                   |  0.58 |                100 |                      10 | 00:00:00                 | 0.6285714 |                70 | 00:00:00                |      0.875 |                       8 | 00:34:58                      |         0.58 |                        50 | 00:00:00                        |       0.58 |                     100 | 00:00:00                      |     0.6240714 |                        228 | 00:34:58                         |
| Tyrus Cremin-Wisozk | <TyrusCremin-Wisozk@berkeley.edu> | 3032412521 | fake-class-2023 |                      2 |   0.2 |                 10 |                       3 | 00:00:00                 |  1.00 |                 20 |                       2 | 00:00:00                 | 0.6000000 |                 15 |                       3 | 00:00:00                 |   0.3 |                 10 |                       6 | 00:00:00                 |   1.0 |                  5 |                       6 | 00:00:00                 |   1.0 |                 10 |                       1 | 00:00:00                 |         1.00 |                         4 |                              3 | 00:00:00.000000                 |         1.00 |                         4 |                              7 | 00:00:00                        |    0.08 |                   50 |                         5 | 00:00:00                   |  0.80 |                100 |                       2 | 00:00:00                 | 0.7000000 |                70 | 00:00:00                |      1.000 |                       8 | 00:00:00                      |         0.08 |                        50 | 00:00:00                        |       0.80 |                     100 | 00:00:00                      |     0.5740000 |                        228 | 00:00:00                         |
| Sydni Hansen        | <SydniHansen@berkeley.edu>        | 3032412522 | fake-class-2023 |                      1 |   0.8 |                 10 |                       1 | 00:00:00                 |  0.15 |                 20 |                       8 | 00:00:00                 | 0.9333333 |                 15 |                       5 | 00:00:00                 |   0.9 |                 10 |                       4 | 00:00:00                 |   1.0 |                  5 |                       9 | 00:00:00                 |   0.3 |                 10 |                      10 | 00:00:00                 |         0.00 |                         4 |                              7 | 00:00:00.000000                 |         1.00 |                         4 |                             10 | 00:00:00                        |    0.08 |                   50 |                         4 | 00:00:00                   |  0.83 |                100 |                       7 | 00:00:00                 | 0.6000000 |                70 | 00:00:00                |      0.500 |                       8 | 00:00:00                      |         0.08 |                        50 | 00:00:00                        |       0.83 |                     100 | 00:00:00                      |     0.5030000 |                        228 | 00:00:00                         |
| Mrs. Chelsie        | <Mrs.Chelsie@berkeley.edu>        | 3032412523 | fake-class-2023 |                      0 |   0.5 |                 10 |                       8 | 00:00:00                 |  0.95 |                 20 |                       4 | 00:00:00                 | 1.0000000 |                 15 |                       8 | 00:00:00                 |   0.2 |                 10 |                       2 | 00:00:00                 |   0.0 |                  5 |                      10 | 09:31:21                 |   1.0 |                 10 |                       8 | 00:00:00                 |         0.75 |                         4 |                              5 | 00:00:00.000000                 |         1.00 |                         4 |                              8 | 00:00:00                        |    0.94 |                   50 |                         1 | 00:00:00                   |  0.53 |                100 |                       3 | 00:00:00                 | 0.7285714 |                70 | 09:31:21                |      0.875 |                       8 | 00:00:00                      |         0.94 |                        50 | 00:00:00                        |       0.53 |                     100 | 00:00:00                      |     0.7470714 |                        228 | 09:31:21                         |

Note that there is also a column called “Slip Days 1”, which shows how
much of their “slip-days budget” each student has used up.

Here is a before-and-after comparison of how students’ lateness are
updated after applying slip days.

|        SID | Lab 1 | Lab 1 - Lateness (H:M:S) | Lab 2 | Lab 2 - Lateness (H:M:S) | Lab 3 | Lab 3 - Lateness (H:M:S) | Lab 4 | Lab 4 - Lateness (H:M:S) | Lab 5 | Lab 5 - Lateness (H:M:S) | Lab 6 | Lab 6 - Lateness (H:M:S) |
|-----------:|------:|:-------------------------|------:|:-------------------------|------:|:-------------------------|------:|:-------------------------|------:|:-------------------------|------:|:-------------------------|
| 3032412514 |     9 | 00:00:00                 |     5 | 47:55:53                 |     7 | 00:00:00                 |     9 | 00:00:00                 |     0 | 00:00:00                 |     4 | 00:00:00                 |
| 3032412515 |     5 | 00:00:00                 |    20 | 00:00:00                 |     1 | 00:00:00                 |     5 | 00:00:00                 |     1 | 00:00:00                 |     0 | 00:00:00                 |
| 3032412516 |    10 | 00:00:00                 |    12 | 00:00:00                 |    15 | 00:00:00                 |     8 | 00:00:00                 |     3 | 00:00:00                 |     6 | 00:00:00                 |
| 3032412517 |    10 | 00:00:00                 |     1 | 00:00:00                 |     8 | 08:57:32                 |     6 | 00:00:00                 |     1 | 00:00:00                 |    10 | 00:00:00                 |
| 3032412518 |     8 | 00:00:00                 |    10 | 00:00:00                 |     9 | 14:59:55                 |     1 | 14:10:40                 |     4 | 00:00:00                 |     0 | 00:00:00                 |
| 3032412519 |     9 | 00:00:00                 |     2 | 00:00:00                 |     9 | 00:00:00                 |    10 | 00:00:00                 |     5 | 00:00:00                 |     1 | 00:00:00                 |
| 3032412520 |     8 | 11:25:51                 |    11 | 00:00:17                 |     7 | 00:00:00                 |    10 | 00:00:00                 |     4 | 00:00:00                 |     4 | 00:00:00                 |
| 3032412521 |     2 | 00:00:00                 |    20 | 00:00:00                 |     9 | 00:00:00                 |     3 | 00:00:00                 |     5 | 00:00:00                 |    10 | 00:00:00                 |
| 3032412522 |     8 | 00:00:00                 |     3 | 00:00:00                 |    14 | 00:00:00                 |     9 | 00:00:00                 |     5 | 00:00:00                 |     3 | 12:24:26                 |
| 3032412523 |     5 | 00:34:45                 |    19 | 00:00:00                 |    15 | 13:12:53                 |     2 | 00:00:00                 |     4 | 09:31:21                 |    10 | 00:00:00                 |

| SID        | Lab 1 | Lab 1 - Lateness (H:M:S) | Lab 2 | Lab 2 - Lateness (H:M:S) |     Lab 3 | Lab 3 - Lateness (H:M:S) | Lab 4 | Lab 4 - Lateness (H:M:S) | Lab 5 | Lab 5 - Lateness (H:M:S) | Lab 6 | Lab 6 - Lateness (H:M:S) | Remaining: Slip Days 1 |
|:-----------|------:|:-------------------------|------:|:-------------------------|----------:|:-------------------------|------:|:-------------------------|------:|:-------------------------|------:|:-------------------------|-----------------------:|
| 3032412514 |   0.9 | 00:00:00                 |  0.25 | 00:00:00                 | 0.4666667 | 00:00:00                 |   0.9 | 00:00:00                 |   0.0 | 00:00:00                 |   0.4 | 00:00:00                 |                      0 |
| 3032412515 |   0.5 | 00:00:00                 |  1.00 | 00:00:00                 | 0.0666667 | 00:00:00                 |   0.5 | 00:00:00                 |   0.2 | 00:00:00                 |   0.0 | 00:00:00                 |                      2 |
| 3032412516 |   1.0 | 00:00:00                 |  0.60 | 00:00:00                 | 1.0000000 | 00:00:00                 |   0.8 | 00:00:00                 |   0.6 | 00:00:00                 |   0.6 | 00:00:00                 |                      2 |
| 3032412517 |   1.0 | 00:00:00                 |  0.05 | 00:00:00                 | 0.5333333 | 00:00:00                 |   0.6 | 00:00:00                 |   0.2 | 00:00:00                 |   1.0 | 00:00:00                 |                      1 |
| 3032412518 |   0.8 | 00:00:00                 |  0.50 | 00:00:00                 | 0.6000000 | 00:00:00                 |   0.1 | 00:00:00                 |   0.8 | 00:00:00                 |   0.0 | 00:00:00                 |                      0 |
| 3032412519 |   0.9 | 00:00:00                 |  0.10 | 00:00:00                 | 0.6000000 | 00:00:00                 |   1.0 | 00:00:00                 |   1.0 | 00:00:00                 |   0.1 | 00:00:00                 |                      2 |
| 3032412520 |   0.8 | 00:00:00                 |  0.55 | 00:00:00                 | 0.4666667 | 00:00:00                 |   1.0 | 00:00:00                 |   0.8 | 00:00:00                 |   0.4 | 00:00:00                 |                      0 |
| 3032412521 |   0.2 | 00:00:00                 |  1.00 | 00:00:00                 | 0.6000000 | 00:00:00                 |   0.3 | 00:00:00                 |   1.0 | 00:00:00                 |   1.0 | 00:00:00                 |                      2 |
| 3032412522 |   0.8 | 00:00:00                 |  0.15 | 00:00:00                 | 0.9333333 | 00:00:00                 |   0.9 | 00:00:00                 |   1.0 | 00:00:00                 |   0.3 | 00:00:00                 |                      1 |
| 3032412523 |   0.5 | 00:00:00                 |  0.95 | 00:00:00                 | 1.0000000 | 00:00:00                 |   0.2 | 00:00:00                 |   0.0 | 09:31:21                 |   1.0 | 00:00:00                 |                      0 |

Note that majority of late submissions were within the allotted “slip
day budget,” but the last student had additional lateness in Lab 5. This
means that, in the final grades results, this student will receive a
zero on this assignment as a resulting penalty.
