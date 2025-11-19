# Building a Policy File

There are two ingredients that are needed to calculate course grades
with `nemogb`: a dataframe containing assignment scores and a file that
encodes the grading policies often described in a syllabus. We call that
file a *policy file*.

Policy files are stored as
[.yaml](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started)
files, a simple format for storing hierarchical data in a text file with
minimal markup. Here is an example of a policy file for a course with a
fairly simple grading scheme.

Note that category names cannot be the same as any assignment names.

``` yaml
coursewide:
  course_name: Stat 101
  description: Syllabus for gs_demo
categories:
  - category: Overall Grade
    aggregation: weighted_mean
    assignments:
    - category: Labs
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

Once you have written your policy file, you can read it into R as a
list.

``` r
policy <- nemogb::read_policy(system.file("extdata", "policy_demo.yaml", package = "nemogb"))
```

## Recognized Keys

There are a series of recognized keys with corresponding values. Each
key represents a certain type of calculation in your syllabus, and the
value determines the specifics of this calculation.

### Category

Every single category must have the `category` key. This is the name of
the subcategory and must be unique from all other category names and all
assignment names.

### Assignments

The `assignments` key determines which assignments or subcategories are
used to determine the category score. The values for this key must match
assignments in the Gradescope data or subcategories determined in the
same policy file. If left blank, the category score will not be factored
into any of the grade calculations and will be ignored (this is usually
relevant when computing grades in the middle of the semester when not
all assignments have been assigned and/or graded). Using
[`get_assignments()`](https://github.com/nemogb-dev/nemogb-r/reference/get_assignments.md)
will give you a list of all the assignments’ names within your
Gradescope file.

### Score

The `score` key determines how the percentage of an assignment score is
calculated. At the moment, there is only one valid value for this key:

- `raw_over_max`: the percentage of an assignment score is the score of
  the assignment divided by the maximum points of the assignment.

  - Note: if `score` is not explicitly defined, this is the *default*.

### Aggregation

The `aggregation` key determines how the various assignment scores are
aggregated together in order to calculate the category score. These are
the corresponding values for this key:

- `equally_weighted`: the category score is the average of the
  assignment scores with no regard to the relative point-values of the
  assignments.

  - Note: if `aggregation` is not explicitly defined, this is the
    *default*.

- `weighted_by_points`: the category score is the weighted average of
  the assignment scores with the weights determined by the relative
  point-values of the assignments.

- `max_score`: the category score is the maximum of the assignment
  scores.

- `min_score`: the category score is the minimum of the assignment
  scores.

- `weighted_mean`: the category score is the weighted average of the
  assignment scores with the weights being explicitly determined using
  the `weight` key in the nested categories.

  - Note: this is often reserved for the final overall-grade
    calculation.

- `none`: this is reserved for when a category is comprised of only one
  assignment; hence no aggregation is necessary because the category
  score is simply the assignment score.

  - Note: if an category has `none` for its aggregation and multiple
    assignments, the function defaults to `equally_weighted`.

### Lateness

The `lateness` key is used to write lateness policies. The values for
this key are divided into threshold functions and penalty functions.

Threshold functions determine the valid lateness period for which the
penalty is applied. Here are the possible threshold functions:

- `until`: this marks the lateness-period up until and including the
  specified value.

- `between`: this marks the lateness-period between and including the
  two specified values.

- `after`: this marks the lateness-period after and including the
  specified value.

Here are the possible penalty functions:

- `add`: add the specified value to the assignment score if the
  assignment’s lateness falls within its respective threshold.

  - Note: this is often used to give bonuses for turning an assignment
    in on-time.

- `scale`: scale the assignment score by the specified factor if the
  assignment’s lateness falls within its respective threshold.

  - Note: this is often used to reduce an assignment score if the
    assignment is turned in late.

- `set_to`: set the assignment score to the specified value if the
  assignment’s lateness falls within its respective threshold.

  - Note: this is often used to set an assignment score to zero if the
    assignment is turned in too late.

See `Case Study: Moderate Syllabus` vignette to view an example of a
lateness policy

### Drop N Lowest

The `drop_n_lowest` key is used to drop *n* of the lowest assignments
scores. This *n*-value can take any integer that is less than the total
number of assignments in the category. If *n* is bigger than the number
of assignments within a category, then the highest assignment score is
returned.

## Nesting

The highest level category is `Overall Grade` with all other categories
and/or assignments nested within. The nested structure of categories
allows for the structured breakdown of each category of a syllabus.
Using the example above, `Overall Grade` is the highest level of nesting
with subcategories of `Labs`, `Discussion`, `Midterm Exam` and
`Final Exam`. Each of these subcategories have their own respective
assignments nested within them. Computations begin with the most nested
category level going up the levels toward `Overall Grade`.

## Importance of Order

Order of operation is crucial in the accurate computation of the final
grades. In a policy file, this order is determined by the order of the
keys in the YAML file. When computing grades, generally the high level
ordering is the following:

- `lateness` penalties,

- apply category drops `drop_n_lowest`, and

- `aggregation`

This is generally true for all syllabi. First, apply penalty for
lateness, then drop lowest scoring assignments, and finally apply
aggregations of assignments.

For example, take two separate orders of the computations of the `Labs`
category, each with six assignments (e.g. `Lab 1`, `Lab 2`, etc.). Both
drop the 2 lowest scores. Both apply the same lateness penality: 10%
reduction if the assignment is at most a day late and setting the score
to zero if any more late. Here’s the dataframe that will be used (the
`gs_demo` from the package):

|        SID | Lab 1 | Lab 1 - Max Points | Lab 1 - Submission Time | Lab 1 - Lateness (H:M:S) | Lab 2 | Lab 2 - Max Points | Lab 2 - Submission Time | Lab 2 - Lateness (H:M:S) | Lab 3 | Lab 3 - Max Points | Lab 3 - Submission Time | Lab 3 - Lateness (H:M:S) | Lab 4 | Lab 4 - Max Points | Lab 4 - Submission Time | Lab 4 - Lateness (H:M:S) | Lab 5 | Lab 5 - Max Points | Lab 5 - Submission Time | Lab 5 - Lateness (H:M:S) | Lab 6 | Lab 6 - Max Points | Lab 6 - Submission Time | Lab 6 - Lateness (H:M:S) |
|-----------:|------:|-------------------:|:------------------------|:-------------------------|------:|-------------------:|:------------------------|:-------------------------|------:|-------------------:|:------------------------|:-------------------------|------:|-------------------:|:------------------------|:-------------------------|------:|-------------------:|:------------------------|:-------------------------|------:|-------------------:|:------------------------|:-------------------------|
| 3032412514 |     9 |                 10 | 1/19/23 22:20           | 00:00:00                 |     5 |                 20 | 9/21/22 23:54           | 47:55:53                 |     7 |                 15 | 1/24/23 20:38           | 00:00:00                 |     9 |                 10 | 1/26/23 19:51           | 00:00:00                 |     0 |                  5 | 1/31/23 18:59           | 00:00:00                 |     4 |                 10 | 2/2/23 12:16            | 00:00:00                 |
| 3032412515 |     5 |                 10 | 1/19/23 12:16           | 00:00:00                 |    20 |                 20 | 9/19/22 23:32           | 00:00:00                 |     1 |                 15 | 1/24/23 16:18           | 00:00:00                 |     5 |                 10 | 1/26/23 8:54            | 00:00:00                 |     1 |                  5 | 1/31/23 13:04           | 00:00:00                 |     0 |                 10 | 2/2/23 12:12            | 00:00:00                 |
| 3032412516 |    10 |                 10 | 1/19/23 10:26           | 00:00:00                 |    12 |                 20 | 9/19/22 23:44           | 00:00:00                 |    15 |                 15 | 1/24/23 16:10           | 00:00:00                 |     8 |                 10 | 1/26/23 10:12           | 00:00:00                 |     3 |                  5 | 1/31/23 16:01           | 00:00:00                 |     6 |                 10 | 2/2/23 10:13            | 00:00:00                 |
| 3032412517 |    10 |                 10 | 1/20/23 8:12            | 00:00:00                 |     1 |                 20 | 9/13/22 20:29           | 00:00:00                 |     8 |                 15 | 1/25/23 8:56            | 08:57:32                 |     6 |                 10 | 1/26/23 17:27           | 00:00:00                 |     1 |                  5 | 1/31/23 14:57           | 00:00:00                 |    10 |                 10 | 2/2/23 16:43            | 00:00:00                 |
| 3032412518 |     8 |                 10 | 1/19/23 12:06           | 00:00:00                 |    10 |                 20 | 9/19/22 0:15            | 00:00:00                 |     9 |                 15 | 1/25/23 14:58           | 14:59:55                 |     1 |                 10 | 1/27/23 14:09           | 14:10:40                 |     4 |                  5 | 1/31/23 15:44           | 00:00:00                 |     0 |                 10 | 2/2/23 22:27            | 00:00:00                 |
| 3032412519 |     9 |                 10 | 1/19/23 17:17           | 00:00:00                 |     2 |                 20 | 9/19/22 22:37           | 00:00:00                 |     9 |                 15 | 1/24/23 18:08           | 00:00:00                 |    10 |                 10 | 1/26/23 21:51           | 00:00:00                 |     5 |                  5 | 1/31/23 23:03           | 00:00:00                 |     1 |                 10 | 2/2/23 19:18            | 00:00:00                 |
| 3032412520 |     8 |                 10 | 1/20/23 11:24           | 11:25:51                 |    11 |                 20 | 9/19/22 23:59           | 00:00:17                 |     7 |                 15 | 1/24/23 22:23           | 00:00:00                 |    10 |                 10 | 1/26/23 23:12           | 00:00:00                 |     4 |                  5 | 1/30/23 22:52           | 00:00:00                 |     4 |                 10 | 2/2/23 19:04            | 00:00:00                 |
| 3032412521 |     2 |                 10 | 1/19/23 11:46           | 00:00:00                 |    20 |                 20 | 9/14/22 15:39           | 00:00:00                 |     9 |                 15 | 1/24/23 16:44           | 00:00:00                 |     3 |                 10 | 1/26/23 2:24            | 00:00:00                 |     5 |                  5 | 1/31/23 18:47           | 00:00:00                 |    10 |                 10 | 2/2/23 1:53             | 00:00:00                 |
| 3032412522 |     8 |                 10 | 1/18/23 23:48           | 00:00:00                 |     3 |                 20 | 9/19/22 23:51           | 00:00:00                 |    14 |                 15 | 1/24/23 18:23           | 00:00:00                 |     9 |                 10 | 1/26/23 19:30           | 00:00:00                 |     5 |                  5 | 1/31/23 23:10           | 00:00:00                 |     3 |                 10 | 2/3/23 12:23            | 12:24:26                 |
| 3032412523 |     5 |                 10 | 1/20/23 0:33            | 00:34:45                 |    19 |                 20 | 9/19/22 16:10           | 00:00:00                 |    15 |                 15 | 1/25/23 13:11           | 13:12:53                 |     2 |                 10 | 1/26/23 14:37           | 00:00:00                 |     4 |                  5 | 2/1/23 9:30             | 09:31:21                 |    10 |                 10 | 2/2/23 21:08            | 00:00:00                 |

The first computation would apply the lateness penalty first to all six
assignments and then drop the two lowest scores after. The second
computation would drop the two lowest scores first and then apply the
lateness penalty to the four remaining assignments. Here are the
computed scores for `Labs` side-by-side:

| SID        | Labs - Drops First | Labs - Lateness First |
|:-----------|-------------------:|----------------------:|
| 3032412514 |          0.5333333 |             0.6666667 |
| 3032412515 |          0.5500000 |             0.5500000 |
| 3032412516 |          0.8500000 |             0.8500000 |
| 3032412517 |          0.7700000 |             0.7700000 |
| 3032412518 |          0.6600000 |             0.6600000 |
| 3032412519 |          0.8750000 |             0.8750000 |
| 3032412520 |          0.7537500 |             0.7537500 |
| 3032412521 |          0.9000000 |             0.9000000 |
| 3032412522 |          0.9083333 |             0.9083333 |
| 3032412523 |          0.8925000 |             0.8925000 |

While this distinction doesn’t affect all students, the first student
does get a distinctly different score, highlighting the importance of
order in creating these policy files. It’s evident that seemingly small
distinctions can create a significant effect, especially on larger
student bodies.
