# Working With Canvas Data

``` r
library(nemogb)
```

Canvas is a popular classroom management tool that is commonly used to
grade assignments and collect student grades throughout colleges and
universities. This article describes how to use `nemogb` with Canvas
data.

Advanced users wishing to gain a deep understanding of how Canvas data
is structured can also read the [Detailed Canvas Export
Info](https://nemogb-dev.github.io/nemogb-r/articles/detailed-canvas-export-info.html)
vignette.

## Getting the Data

This article details `nemogb` workflows for users who use Canvas to
collect student assignment grades. To use `nemogb`, users must first
source the necessary csv files containing student assignment data from
Canvas.

The primary csv file needed from Canvas is the grades file, which
contains the assignment grades for each student. To source this file,
navigate to the “Grades” tab on Canvas. On the grades page, click
“Export” and then “Export Entire Gradebook”.

The grades csv is the only file that is needed to generate final grades
with `nemogb`. Read below for more information on other data that can be
exported from Canvas.

## Data Format

The internal standard for `nemogb` data is for assignment data to be
formatted like Gradescope data, which is another platform for collecting
student grades. `nemogb` functionality converts the Canvas assignment
data into our internal standards for seamless use of Canvas data.

To use grade data from Canvas, simply use
[`read_files()`](https://github.com/nemogb-dev/nemogb-r/reference/read_files.md);
this process is not unique to Canvas data. `nemogb` assesses the source
of the file (e.g. Gradescope, Canvas, or other) and load in file in
appropriately. To force the file to be read in as a Canvas sourced file,
users can pass the argument `source = "Canvas"` into the read_files()
function. `nemogb` will track where the data originated and prevent
potentially dangerous operations during grading.

After reading in the data, the data can be used to calculate grades as
in the case study vignettes.

Here is an example of the transformation `nemogb` applies to Canvas
grade data.

Below is assignment grade data as exported from Canvas.

    #> Rows: 11 Columns: 38
    #> ── Column specification ────────────────────────────────────────────────────────
    #> Delimiter: ","
    #> chr (27): Student, SIS Login ID, Section, Assignments Current Score, Assignm...
    #> dbl (11): ID, SIS User ID, HW 1 (8595677), HW 2 (8595678), HW 3 (8595679), H...
    #> 
    #> ℹ Use `spec()` to retrieve the full column specification for this data.
    #> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

| Student         |      ID | SIS User ID | SIS Login ID                             | Section                 | HW 1 (8595677) | HW 2 (8595678) | HW 3 (8595679) | HW 4 (8595680) | Q1 (8671819) | Q2 (8671820) | MT1 (8671822) | MT2 (8671823) | final exam (8677368) | Assignments Current Score | Assignments Unposted Current Score | Assignments Final Score | Assignments Unposted Final Score | Quizzes Current Score | Quizzes Unposted Current Score | Quizzes Final Score | Quizzes Unposted Final Score | Midterms Current Score | Midterms Unposted Current Score | Midterms Final Score | Midterms Unposted Final Score | final exam Current Score | final exam Unposted Current Score | final exam Final Score | final exam Unposted Final Score | Current Score | Unposted Current Score | Final Score | Unposted Final Score | Current Grade | Unposted Current Grade | Final Grade | Unposted Final Grade |
|:----------------|--------:|------------:|:-----------------------------------------|:------------------------|---------------:|---------------:|---------------:|---------------:|-------------:|-------------:|--------------:|--------------:|---------------------:|:--------------------------|:-----------------------------------|:------------------------|:---------------------------------|:----------------------|:-------------------------------|:--------------------|:-----------------------------|:-----------------------|:--------------------------------|:---------------------|:------------------------------|:-------------------------|:----------------------------------|:-----------------------|:--------------------------------|:--------------|:-----------------------|:------------|:---------------------|:--------------|:-----------------------|:------------|:---------------------|
| Points Possible |      NA |          NA | NA                                       | NA                      |              1 |              1 |              1 |              1 |         30.0 |         30.0 |            50 |            50 |               100.00 | (read only)               | (read only)                        | (read only)             | (read only)                      | (read only)           | (read only)                    | (read only)         | (read only)                  | (read only)            | (read only)                     | (read only)          | (read only)                   | (read only)              | (read only)                       | (read only)            | (read only)                     | (read only)   | (read only)            | (read only) | (read only)          | (read only)   | (read only)            | (read only) | (read only)          |
| Hendricks, Jeff | 5620182 |  1033455469 | 1756724                                  | Your Class Discussion 1 |              1 |              1 |              0 |              1 |         19.0 |          0.0 |            23 |            10 |                 0.00 | 44.44                     | 44.44                              | 44.44                   | 44.44                            | 31.67                 | 31.67                          | 31.67               | 31.67                        | 33.00                  | 33.00                           | 33.00                | 33.00                         | 0.00                     | 0.00                              | 0.00                   | 0.00                            | 22.44         | 22.44                  | 22.44       | 22.44                | F             | F                      | F           | F                    |
| Smith, Karen    | 5734457 |  1034536709 | 1833456                                  | Your Class Discussion 1 |              1 |              1 |              1 |              0 |          0.0 |          0.0 |             7 |             0 |                 0.00 | 33.33                     | 33.33                              | 33.33                   | 33.33                            | 0.00                  | 0.00                           | 0.00                | 0.00                         | 7.00                   | 7.00                            | 7.00                 | 7.00                          | 0.00                     | 0.00                              | 0.00                   | 0.00                            | 9.53          | 9.53                   | 9.53        | 9.53                 | F             | F                      | F           | F                    |
| Berger, Henry   | 5721938 |  1033320625 | 1886709                                  | Your Class Discussion 1 |              1 |              1 |              1 |              0 |         17.0 |         20.5 |            31 |            21 |                45.25 | 100.00                    | 100.00                             | 100.00                  | 100.00                           | 62.50                 | 62.50                          | 62.50               | 62.50                        | 52.00                  | 52.00                           | 52.00                | 52.00                         | 45.25                    | 45.25                             | 45.25                  | 45.25                           | 59.04         | 59.04                  | 59.04       | 59.04                | B+            | B+                     | B+          | B+                   |
| Whitley, Alan   | 5571234 |  1035823612 | 1723974                                  | Your Class Discussion 1 |              0 |              1 |              1 |              1 |         11.0 |         10.0 |            11 |            10 |                35.38 | 77.78                     | 77.78                              | 77.78                   | 77.78                            | 35.00                 | 35.00                          | 35.00               | 35.00                        | 21.00                  | 21.00                           | 21.00                | 21.00                         | 35.38                    | 35.38                             | 35.38                  | 35.38                           | 39.71         | 39.71                  | 39.71       | 39.71                | C+            | C+                     | C+          | C+                   |
| Jackson, Keith  | 5354659 |  1032235053 | 3416951                                  | Your Class Discussion 1 |              1 |              1 |              1 |              1 |         26.0 |          7.0 |            22 |             3 |                26.00 | 77.78                     | 77.78                              | 77.78                   | 77.78                            | 55.00                 | 55.00                          | 55.00               | 55.00                        | 25.00                  | 25.00                           | 25.00                | 25.00                         | 26.00                    | 26.00                             | 26.00                  | 26.00                           | 37.36         | 37.36                  | 37.36       | 37.36                | C+            | C+                     | C+          | C+                   |
| Harris, Miranda | 5621984 |  1033457242 | 1769716                                  | Your Class Discussion 1 |              0 |              1 |              0 |              0 |         15.5 |          1.0 |            10 |             4 |                20.50 | 88.89                     | 88.89                              | 88.89                   | 88.89                            | 27.50                 | 27.50                          | 27.50               | 27.50                        | 14.00                  | 14.00                           | 14.00                | 14.00                         | 20.50                    | 20.50                             | 20.50                  | 20.50                           | 30.47         | 30.47                  | 30.47       | 30.47                | C-            | C-                     | C-          | C-                   |
| Tines, Maria    | 5578591 |  1034768282 | 1725568                                  | Your Class Discussion 1 |              0 |              1 |              0 |              0 |         18.5 |         11.0 |            12 |            12 |                18.75 | 55.56                     | 55.56                              | 55.56                   | 55.56                            | 49.17                 | 49.17                          | 49.17               | 49.17                        | 24.00                  | 24.00                           | 24.00                | 24.00                         | 18.75                    | 18.75                             | 18.75                  | 18.75                           | 30.35         | 30.35                  | 30.35       | 30.35                | C-            | C-                     | C-          | C-                   |
| Rizzo, Teoscar  | 5654659 |  1045099144 | 1440632                                  | Your Class Discussion 1 |              1 |              1 |              1 |              1 |         19.5 |         11.0 |            34 |             7 |                11.50 | 88.89                     | 88.89                              | 88.89                   | 88.89                            | 50.83                 | 50.83                          | 50.83               | 50.83                        | 41.00                  | 41.00                           | 41.00                | 41.00                         | 11.50                    | 11.50                             | 11.50                  | 11.50                           | 39.47         | 39.47                  | 39.47       | 39.47                | C+            | C+                     | C+          | C+                   |
| Craig, Linda    | 5523085 |  1030100042 | 1724586                                  | Your Class Discussion 1 |              0 |              0 |              0 |              0 |         18.0 |          0.0 |             4 |             0 |                 0.00 | 0.00                      | 0.00                               | 0.00                    | 0.00                             | 30.00                 | 30.00                          | 30.00               | 30.00                        | 4.00                   | 4.00                            | 4.00                 | 4.00                          | 0.00                     | 0.00                              | 0.00                   | 0.00                            | 5.38          | 5.38                   | 5.38        | 5.38                 | F             | F                      | F           | F                    |
| Student, Test   | 5743823 |          NA | fee755ff9407d959738822f95f5e2613d9b7688b | Your Class Discussion 1 |              0 |              0 |              0 |              0 |          0.0 |          0.0 |             0 |             0 |                 0.00 | 0.00                      | 0.00                               | 0.00                    | 0.00                             | 0.00                  | 0.00                           | 0.00                | 0.00                         | 0.00                   | 0.00                            | 0.00                 | 0.00                          | 0.00                     | 0.00                              | 0.00                   | 0.00                            | 0.00          | 0.00                   | 0.00        | 0.00                 | F             | F                      | F           | F                    |

Below is the dataframe after being transformed by `nemogb`.

    #> Rows: 11 Columns: 38
    #> ── Column specification ────────────────────────────────────────────────────────
    #> Delimiter: ","
    #> chr (27): Student, SIS Login ID, Section, Assignments Current Score, Assignm...
    #> dbl (11): ID, SIS User ID, HW 1 (8595677), HW 2 (8595678), HW 3 (8595679), H...
    #> 
    #> ℹ Use `spec()` to retrieve the full column specification for this data.
    #> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

| First Name | Last Name |        SID | Sections                | HW 1 (8595677) | HW 1 (8595677) - Max Points | HW 1 (8595677) - Submission Time | HW 1 (8595677) - Lateness (H:M:S) | HW 2 (8595678) | HW 2 (8595678) - Max Points | HW 2 (8595678) - Submission Time | HW 2 (8595678) - Lateness (H:M:S) | HW 3 (8595679) | HW 3 (8595679) - Max Points | HW 3 (8595679) - Submission Time | HW 3 (8595679) - Lateness (H:M:S) | HW 4 (8595680) | HW 4 (8595680) - Max Points | HW 4 (8595680) - Submission Time | HW 4 (8595680) - Lateness (H:M:S) | Q1 (8671819) | Q1 (8671819) - Max Points | Q1 (8671819) - Submission Time | Q1 (8671819) - Lateness (H:M:S) | Q2 (8671820) | Q2 (8671820) - Max Points | Q2 (8671820) - Submission Time | Q2 (8671820) - Lateness (H:M:S) | MT1 (8671822) | MT1 (8671822) - Max Points | MT1 (8671822) - Submission Time | MT1 (8671822) - Lateness (H:M:S) | MT2 (8671823) | MT2 (8671823) - Max Points | MT2 (8671823) - Submission Time | MT2 (8671823) - Lateness (H:M:S) | final exam (8677368) | final exam (8677368) - Max Points | final exam (8677368) - Submission Time | final exam (8677368) - Lateness (H:M:S) |
|:-----------|:----------|-----------:|:------------------------|---------------:|----------------------------:|:---------------------------------|:----------------------------------|---------------:|----------------------------:|:---------------------------------|:----------------------------------|---------------:|----------------------------:|:---------------------------------|:----------------------------------|---------------:|----------------------------:|:---------------------------------|:----------------------------------|-------------:|--------------------------:|:-------------------------------|:--------------------------------|-------------:|--------------------------:|:-------------------------------|:--------------------------------|--------------:|---------------------------:|:--------------------------------|:---------------------------------|--------------:|---------------------------:|:--------------------------------|:---------------------------------|---------------------:|----------------------------------:|:---------------------------------------|:----------------------------------------|
| Jeff       | Hendricks | 1033455469 | Your Class Discussion 1 |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |         19.0 |                        30 | NA                             | 00:00:00                        |          0.0 |                        30 | NA                             | 00:00:00                        |            23 |                         50 | NA                              | 00:00:00                         |            10 |                         50 | NA                              | 00:00:00                         |                 0.00 |                               100 | NA                                     | 00:00:00                                |
| Karen      | Smith     | 1034536709 | Your Class Discussion 1 |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |          0.0 |                        30 | NA                             | 00:00:00                        |          0.0 |                        30 | NA                             | 00:00:00                        |             7 |                         50 | NA                              | 00:00:00                         |             0 |                         50 | NA                              | 00:00:00                         |                 0.00 |                               100 | NA                                     | 00:00:00                                |
| Henry      | Berger    | 1033320625 | Your Class Discussion 1 |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |         17.0 |                        30 | NA                             | 00:00:00                        |         20.5 |                        30 | NA                             | 00:00:00                        |            31 |                         50 | NA                              | 00:00:00                         |            21 |                         50 | NA                              | 00:00:00                         |                45.25 |                               100 | NA                                     | 00:00:00                                |
| Alan       | Whitley   | 1035823612 | Your Class Discussion 1 |              0 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |         11.0 |                        30 | NA                             | 00:00:00                        |         10.0 |                        30 | NA                             | 00:00:00                        |            11 |                         50 | NA                              | 00:00:00                         |            10 |                         50 | NA                              | 00:00:00                         |                35.38 |                               100 | NA                                     | 00:00:00                                |
| Keith      | Jackson   | 1032235053 | Your Class Discussion 1 |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |         26.0 |                        30 | NA                             | 00:00:00                        |          7.0 |                        30 | NA                             | 00:00:00                        |            22 |                         50 | NA                              | 00:00:00                         |             3 |                         50 | NA                              | 00:00:00                         |                26.00 |                               100 | NA                                     | 00:00:00                                |
| Miranda    | Harris    | 1033457242 | Your Class Discussion 1 |              0 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |         15.5 |                        30 | NA                             | 00:00:00                        |          1.0 |                        30 | NA                             | 00:00:00                        |            10 |                         50 | NA                              | 00:00:00                         |             4 |                         50 | NA                              | 00:00:00                         |                20.50 |                               100 | NA                                     | 00:00:00                                |
| Maria      | Tines     | 1034768282 | Your Class Discussion 1 |              0 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |         18.5 |                        30 | NA                             | 00:00:00                        |         11.0 |                        30 | NA                             | 00:00:00                        |            12 |                         50 | NA                              | 00:00:00                         |            12 |                         50 | NA                              | 00:00:00                         |                18.75 |                               100 | NA                                     | 00:00:00                                |
| Teoscar    | Rizzo     | 1045099144 | Your Class Discussion 1 |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |              1 |                           1 | NA                               | 00:00:00                          |         19.5 |                        30 | NA                             | 00:00:00                        |         11.0 |                        30 | NA                             | 00:00:00                        |            34 |                         50 | NA                              | 00:00:00                         |             7 |                         50 | NA                              | 00:00:00                         |                11.50 |                               100 | NA                                     | 00:00:00                                |
| Linda      | Craig     | 1030100042 | Your Class Discussion 1 |              0 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |              0 |                           1 | NA                               | 00:00:00                          |         18.0 |                        30 | NA                             | 00:00:00                        |          0.0 |                        30 | NA                             | 00:00:00                        |             4 |                         50 | NA                              | 00:00:00                         |             0 |                         50 | NA                              | 00:00:00                         |                 0.00 |                               100 | NA                                     | 00:00:00                                |

## Limitations

With our current implemention, there are limitations to using assignment
data sourced from Canvas, resulting in a reduction of potential grading
functionality in `nemogb`. The primary limitation surrounds the
application of lateness policies when using data sourced from Canvas.

The grades csv exported from Canvas does not include information on
assignment lateness. As mentioned below, Canvas also can export files
detailing late assignments. However, this lateness file omits the time
that the assignment was due, making it not possible to accurately
calculate how late any late assignment is. As a result, we do not allow
lateness policies to be used when the data is sourced from Canvas.
Attempts to do so will raise an error.

Currently, our recommendation is for Canvas users to apply any late
policies in Canvas, since Canvas can apply simple lateness policies.

## Other Data

In addition to the grades file, Canvas also exports information that can
be relevant to grade calculation. Examples include the lateness csv file
and a roster csv file. Integrating the information from these two files
are currently not supported.

The lateness file details which assignments where submitted late by
which students. Due to the drawbacks mentioned above, we are currently
not using this file to implement lateness penalties in `nemogb`.

The roster csv file gives all student names and their contact
information, which can be relevant if instructors desire to have student
contact information available in the exported grades file.

Both of these files are accessed through the “New Analytics” tab
available on the right side of the course homepage. To download these
files, click Analytics on the home page, navigate to the Reports tab and
download the desired report.

![](../../../_temp/Library/nemogb/extdata/canvasAnalytics.png)

![](../../../_temp/Library/nemogb/extdata/canvasAnalyticsOptions.png)

Currently, providing files other than the grades file is not supported
by `nemogb`. However, we have built the infrastructure to read in these
files for future integration of other data sources (e.g. the lateness or
roster csv files from Canvas).

For full information on the formatting of Canvas exported data, see the
[Detailed Canvas Export
Info](https://nemogb-dev.github.io/nemogb-r/articles/detailed-canvas-export-info.html)
vignette.
