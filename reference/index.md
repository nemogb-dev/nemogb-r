# Package index

## Gradescope Data Functions

These functions are to read in and process data from a grading platform
such as Gradescope.

- [`read_files()`](https://github.com/nemogb-dev/nemogb-r/reference/read_files.md)
  : Read in File(s) from Grading Platform(s)
- [`process_gs()`](https://github.com/nemogb-dev/nemogb-r/reference/process_gs.md)
  : Process Gradescope Data
- [`check_data_format()`](https://github.com/nemogb-dev/nemogb-r/reference/check_data_format.md)
  : Check Formatting of Grades Data
- [`get_id_cols()`](https://github.com/nemogb-dev/nemogb-r/reference/get_id_cols.md)
  : Get the ID Columns for Gradescope Data
- [`get_assignments()`](https://github.com/nemogb-dev/nemogb-r/reference/get_assignments.md)
  : Get the Assignment Names for Gradescope Data
- [`determine_grade_source()`](https://github.com/nemogb-dev/nemogb-r/reference/determine_grade_source.md)
  : Predict the source of grade dataframe.
- [`read_gs()`](https://github.com/nemogb-dev/nemogb-r/reference/read_gs.md)
  : Read Gradescope CSV File

## Policy File Functions

These functions are to read in and process the policy file.

- [`read_policy()`](https://github.com/nemogb-dev/nemogb-r/reference/read_policy.md)
  : Read Grading Policy .yml
- [`process_policy()`](https://github.com/nemogb-dev/nemogb-r/reference/process_policy.md)
  : Process Policy File
- [`reconcile_policy_with_gs()`](https://github.com/nemogb-dev/nemogb-r/reference/reconcile_policy_with_gs.md)
  : Reconcile Policy File with Gradescope Data
- [`flatten_policy()`](https://github.com/nemogb-dev/nemogb-r/reference/flatten_policy.md)
  : Flatten Policy File ("Un-nest" the Nested Structure of Policy File)
- [`get_categories()`](https://github.com/nemogb-dev/nemogb-r/reference/get_categories.md)
  : Get the Category Names for Policy
- [`get_nested_assignments()`](https://github.com/nemogb-dev/nemogb-r/reference/get_nested_assignments.md)
  : Get the Nested Assignments for Category

## Grading Functions

These functions are to grade the processed Gradescope data based on the
criteria in the processed policy file

- [`get_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/get_grades.md)
  : Get Grades
- [`calculate_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/calculate_grades.md)
  : Calculate Grades
- [`get_category_grade()`](https://github.com/nemogb-dev/nemogb-r/reference/get_category_grade.md)
  : Calculate A Single Category Grade
- [`score()`](https://github.com/nemogb-dev/nemogb-r/reference/score.md)
  [`aggregation()`](https://github.com/nemogb-dev/nemogb-r/reference/score.md)
  [`lateness()`](https://github.com/nemogb-dev/nemogb-r/reference/score.md)
  [`drop_n_lowest()`](https://github.com/nemogb-dev/nemogb-r/reference/score.md)
  [`aggregation_max_pts()`](https://github.com/nemogb-dev/nemogb-r/reference/score.md)
  [`aggregation_lateness()`](https://github.com/nemogb-dev/nemogb-r/reference/score.md)
  : Key Functions
- [`raw_over_max()`](https://github.com/nemogb-dev/nemogb-r/reference/raw_over_max.md)
  : Score Functions
- [`equally_weighted()`](https://github.com/nemogb-dev/nemogb-r/reference/equally_weighted.md)
  [`weighted_by_points()`](https://github.com/nemogb-dev/nemogb-r/reference/equally_weighted.md)
  [`max_score()`](https://github.com/nemogb-dev/nemogb-r/reference/equally_weighted.md)
  [`min_score()`](https://github.com/nemogb-dev/nemogb-r/reference/equally_weighted.md)
  [`weighted_mean()`](https://github.com/nemogb-dev/nemogb-r/reference/equally_weighted.md)
  [`none()`](https://github.com/nemogb-dev/nemogb-r/reference/equally_weighted.md)
  : Aggregation Functions
- [`sum_max_pts()`](https://github.com/nemogb-dev/nemogb-r/reference/sum_max_pts.md)
  [`mean_max_pts()`](https://github.com/nemogb-dev/nemogb-r/reference/sum_max_pts.md)
  : Aggregation for Maximum Possible Points Functions
- [`until()`](https://github.com/nemogb-dev/nemogb-r/reference/until.md)
  [`add()`](https://github.com/nemogb-dev/nemogb-r/reference/until.md)
  [`between()`](https://github.com/nemogb-dev/nemogb-r/reference/until.md)
  [`scale_by()`](https://github.com/nemogb-dev/nemogb-r/reference/until.md)
  [`after()`](https://github.com/nemogb-dev/nemogb-r/reference/until.md)
  [`set_to()`](https://github.com/nemogb-dev/nemogb-r/reference/until.md)
  : Lateness Functions
- [`mean_lateness()`](https://github.com/nemogb-dev/nemogb-r/reference/mean_lateness.md)
  [`sum_lateness()`](https://github.com/nemogb-dev/nemogb-r/reference/mean_lateness.md)
  [`max_lateness()`](https://github.com/nemogb-dev/nemogb-r/reference/mean_lateness.md)
  : Aggregation for Lateness Functions
- [`apply_slip_days()`](https://github.com/nemogb-dev/nemogb-r/reference/apply_slip_days.md)
  : Apply Slip Days

## Demo Items

These items are used to demonstrate the functionality of this package.

- [`gs_demo`](https://github.com/nemogb-dev/nemogb-r/reference/gs_demo.md)
  : Gradescope Demo Data
- [`policy_demo`](https://github.com/nemogb-dev/nemogb-r/reference/policy_demo.md)
  : Policy Demo File
