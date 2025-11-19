# Case Study: Simple Syllabus

Now, we will walk through a simple syllabus and its `nemogb`
implementation with 5 students in the class. Let’s start with what this
syllabus would look like on a class website:

## Syllabus

The final student’s grade is computed from *1) homework assignments, 2)
midterm and 3) the final exam*. Their grade will be computed as follows:

- Homework 20%
  - Homework 1, Homework 2 (and they are aggregated equally)
- Midterm 40%
- Final Exam 40%

## Policy File

Here is what the policy file looks like:

``` yaml
coursewide:
  course: Stat 101 Simple Syllabus

categories:
 - category: Overall Grade
   aggregation: weighted_mean
   assignments:
   - category: Homework
     weight: 0.20
     aggregation: equally_weighted
     assignments:
     - "Homework 1"
     - "Homework 2"
   - category: Midterm
     weight: 0.40
     aggregation: none
     assignments:
     - "Midterm Exam"
   - category: Final
     weight: 0.40
     aggregation: none
     assignments:
     - "Final Exam"
```

## Gradescope Assigments File

Here is what the Gradescope assignments file looks like:

``` r
simple_syllabus_data <- read_gs(system.file("extdata", "simple_syllabus_data.csv", package = "nemogb"))
```

| Names         | Email                     |        SID | Sections  | Homework 1 | Homework 1 - Max Points | Homework 1 - Submission Time | Homework 1 - Lateness (H:M:S) | Homework 2 | Homework 2 - Max Points | Homework 2 - Submission Time | Homework 2 - Lateness (H:M:S) | Midterm Exam | Midterm Exam - Max Points | Midterm Exam - Submission Time | Midterm Exam - Lateness (H:M:S) | Final Exam | Final Exam - Max Points | Final Exam - Submission Time | Final Exam - Lateness (H:M:S) |
|:--------------|:--------------------------|-----------:|:----------|-----------:|------------------------:|:-----------------------------|:------------------------------|-----------:|------------------------:|:-----------------------------|:------------------------------|-------------:|--------------------------:|:-------------------------------|:--------------------------------|-----------:|------------------------:|:-----------------------------|:------------------------------|
| Alice Smith   | <alice.smith@email.com>   | 3032412514 | section-1 |          9 |                      10 | 1/19/23 22:20                | 00:00:00                      |          5 |                      20 | 9/21/22 23:54                | 47:55:53                      |           44 |                        50 | 2/14/23 21:06                  | 00:00:00                        |         10 |                     100 | 1/20/23 15:13                | 00:00:00                      |
| Bob Johnson   | <bob.johnson@email.com>   | 3032412515 | section-1 |          5 |                      10 | 1/19/23 12:16                | 00:00:00                      |         20 |                      20 | 9/19/22 23:32                | 00:00:00                      |            0 |                        50 | 2/14/23 18:25                  | 00:00:00                        |         78 |                     100 | 1/20/23 10:04                | 00:00:00                      |
| Charlie Brown | <charlie.brown@email.com> | 3032412516 | section-1 |         10 |                      10 | 1/19/23 10:26                | 00:00:00                      |         12 |                      20 | 9/19/22 23:44                | 00:00:00                      |           17 |                        50 | 2/14/23 18:00                  | 00:00:00                        |         24 |                     100 | 1/23/23 8:22                 | 00:00:00                      |
| David Wilson  | <david.wilson@email.com>  | 3032412517 | section-1 |         10 |                      10 | 1/20/23 8:12                 | 00:00:00                      |          1 |                      20 | 9/13/22 20:29                | 00:00:00                      |           15 |                        50 | 2/14/23 20:00                  | 00:00:00                        |         89 |                     100 | 1/24/23 0:50                 | 00:00:00                      |
| Eva White     | <eva.white@email.com>     | 3032412518 | section-1 |          8 |                      10 | 1/19/23 12:06                | 00:00:00                      |         10 |                      20 | 9/19/22 0:15                 | 00:00:00                      |            8 |                        50 | 2/15/23 13:51                  | 00:52:01                        |         97 |                     100 | 1/20/23 15:53                | 00:00:00                      |

## Workflow

**Overall grade** is calculated using the three categories, with the
weights as shown above; This is represented by `Overall Grade` with an
aggregation of `weighted_mean`.

The **Midterm** and **Final Exam** categories contain only a single
assignment, as shown in the `simple_syllabus_data` file, which is
usually downloaded from Gradescope.

The **Homework** category is compiled of two assignments: *“Homework 1”*
and *“Homework 2”* in the `simple_syllabus_data`.

### Grade Calculations

``` r
simple_syllabus_data <- read_gs(system.file("extdata", "simple_syllabus_data.csv", package = "nemogb"))

policy <- read_policy(system.file("extdata", "simple_syllabus.yaml", package = "nemogb"))

grades <- get_grades(gs = simple_syllabus_data, policy = policy)
```

First, read in your YAML policy file.
[`read_policy()`](https://github.com/nemogb-dev/nemogb-r/reference/read_policy.md)
and
[`read_gs()`](https://github.com/nemogb-dev/nemogb-r/reference/read_gs.md)
read in their respective files and check for correct formatting.
Finally,
[`get_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/get_grades.md)
computes your assignment grades based on your policy file.

The output of the grades looks like:

| Names         | Email                     | SID        | Sections  | Homework 1 | Homework 1 - Max Points | Homework 1 - Submission Time | Homework 1 - Lateness (H:M:S) | Homework 2 | Homework 2 - Max Points | Homework 2 - Submission Time | Homework 2 - Lateness (H:M:S) | Midterm Exam | Midterm Exam - Max Points | Midterm Exam - Submission Time | Midterm Exam - Lateness (H:M:S) | Final Exam | Final Exam - Max Points | Final Exam - Submission Time | Final Exam - Lateness (H:M:S) | Homework | Homework - Max Points | Homework - Lateness (H:M:S) | Midterm | Midterm - Max Points | Midterm - Lateness (H:M:S) | Final | Final - Max Points | Final - Lateness (H:M:S) | Overall Grade | Overall Grade - Max Points | Overall Grade - Lateness (H:M:S) |
|:--------------|:--------------------------|:-----------|:----------|-----------:|------------------------:|-----------------------------:|:------------------------------|-----------:|------------------------:|-----------------------------:|:------------------------------|-------------:|--------------------------:|-------------------------------:|:--------------------------------|-----------:|------------------------:|-----------------------------:|:------------------------------|---------:|----------------------:|:----------------------------|--------:|---------------------:|:---------------------------|------:|-------------------:|:-------------------------|--------------:|---------------------------:|:---------------------------------|
| Alice Smith   | <alice.smith@email.com>   | 3032412514 | section-1 |        0.9 |                      10 |                            4 | 00:00:00                      |       0.25 |                      20 |                            5 | 47:55:53                      |         0.88 |                        50 |                              4 | 00:00:00                        |       0.10 |                     100 |                            2 | 00:00:00                      |    0.575 |                    30 | 47:55:53                    |    0.88 |                   50 | 00:00:00                   |  0.10 |                100 | 00:00:00                 |         0.507 |                        180 | 47:55:53                         |
| Bob Johnson   | <bob.johnson@email.com>   | 3032412515 | section-1 |        0.5 |                      10 |                            3 | 00:00:00                      |       1.00 |                      20 |                            3 | 00:00:00                      |         0.00 |                        50 |                              2 | 00:00:00                        |       0.78 |                     100 |                            1 | 00:00:00                      |    0.750 |                    30 | 00:00:00                    |    0.00 |                   50 | 00:00:00                   |  0.78 |                100 | 00:00:00                 |         0.462 |                        180 | 00:00:00                         |
| Charlie Brown | <charlie.brown@email.com> | 3032412516 | section-1 |        1.0 |                      10 |                            1 | 00:00:00                      |       0.60 |                      20 |                            4 | 00:00:00                      |         0.34 |                        50 |                              1 | 00:00:00                        |       0.24 |                     100 |                            4 | 00:00:00                      |    0.800 |                    30 | 00:00:00                    |    0.34 |                   50 | 00:00:00                   |  0.24 |                100 | 00:00:00                 |         0.392 |                        180 | 00:00:00                         |
| David Wilson  | <david.wilson@email.com>  | 3032412517 | section-1 |        1.0 |                      10 |                            5 | 00:00:00                      |       0.05 |                      20 |                            1 | 00:00:00                      |         0.30 |                        50 |                              3 | 00:00:00                        |       0.89 |                     100 |                            5 | 00:00:00                      |    0.525 |                    30 | 00:00:00                    |    0.30 |                   50 | 00:00:00                   |  0.89 |                100 | 00:00:00                 |         0.581 |                        180 | 00:00:00                         |
| Eva White     | <eva.white@email.com>     | 3032412518 | section-1 |        0.8 |                      10 |                            2 | 00:00:00                      |       0.50 |                      20 |                            2 | 00:00:00                      |         0.16 |                        50 |                              5 | 00:52:01                        |       0.97 |                     100 |                            3 | 00:00:00                      |    0.650 |                    30 | 00:00:00                    |    0.16 |                   50 | 00:52:01                   |  0.97 |                100 | 00:00:00                 |         0.582 |                        180 | 00:52:01                         |

Note that setting the `append = TRUE` in the
[`get_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/get_grades.md)
function will output a data frame of the ID columns and the newly
calculated scores (excluding the original assignment columns from
Gradescope).

``` r
new_cat_grades <- get_grades(gs = simple_syllabus_data, 
                     policy = policy,
                     append = FALSE)
```

The output of the grades will then look like this:

| Names         | Email                     | SID        | Sections  | Homework | Homework - Max Points | Homework - Lateness (H:M:S) | Midterm | Midterm - Max Points | Midterm - Lateness (H:M:S) | Final | Final - Max Points | Final - Lateness (H:M:S) | Overall Grade | Overall Grade - Max Points | Overall Grade - Lateness (H:M:S) |
|:--------------|:--------------------------|:-----------|:----------|---------:|----------------------:|:----------------------------|--------:|---------------------:|:---------------------------|------:|-------------------:|:-------------------------|--------------:|---------------------------:|:---------------------------------|
| Alice Smith   | <alice.smith@email.com>   | 3032412514 | section-1 |    0.575 |                    30 | 47:55:53                    |    0.88 |                   50 | 00:00:00                   |  0.10 |                100 | 00:00:00                 |         0.507 |                        180 | 47:55:53                         |
| Bob Johnson   | <bob.johnson@email.com>   | 3032412515 | section-1 |    0.750 |                    30 | 00:00:00                    |    0.00 |                   50 | 00:00:00                   |  0.78 |                100 | 00:00:00                 |         0.462 |                        180 | 00:00:00                         |
| Charlie Brown | <charlie.brown@email.com> | 3032412516 | section-1 |    0.800 |                    30 | 00:00:00                    |    0.34 |                   50 | 00:00:00                   |  0.24 |                100 | 00:00:00                 |         0.392 |                        180 | 00:00:00                         |
| David Wilson  | <david.wilson@email.com>  | 3032412517 | section-1 |    0.525 |                    30 | 00:00:00                    |    0.30 |                   50 | 00:00:00                   |  0.89 |                100 | 00:00:00                 |         0.581 |                        180 | 00:00:00                         |
| Eva White     | <eva.white@email.com>     | 3032412518 | section-1 |    0.650 |                    30 | 00:00:00                    |    0.16 |                   50 | 00:52:01                   |  0.97 |                100 | 00:00:00                 |         0.582 |                        180 | 00:52:01                         |

## Syllabus as a Grading Script

Here is the coded version of the same syllabus.

``` r
script_grades <- simple_syllabus_data |>
  # calculate percentages
  dplyr::mutate(
    `Homework 1` = `Homework 1` / `Homework 1 - Max Points`,
    `Homework 2` = `Homework 2` / `Homework 2 - Max Points`,
    `Midterm Exam` = `Midterm Exam` / `Midterm Exam - Max Points`,
    `Final Exam` = `Final Exam` / `Final Exam - Max Points`
  ) |>
  # calculate category grade for "Homework"
  dplyr::mutate(`Homework` = (`Homework 1` + `Homework 2`) / 2) |>
  # calculate final Overall Grade
  dplyr::mutate(`Overall Grade` = 0.2 * `Homework` + 0.4 * `Midterm Exam` + 0.4 * `Final Exam`)
```

And, as you can see, the computations align.

![](simple-syllabus_files/figure-html/unnamed-chunk-10-1.png)

### Disclaimers:

- The `weight` of a category with aggregation `weighted_mean` should be
  corresponding order with the `assignments.`

- Categories cannot have the same name as any other assignment name.
