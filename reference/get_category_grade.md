# Calculate A Single Category Grade

This function calculates the grade of a single category based on the
policy file. Note that this function is called within
[`calculate_grades()`](https://github.com/nemogb-dev/nemogb-r/reference/calculate_grades.md)
and it should not be used on its own.

## Usage

``` r
get_category_grade(grades_mat, policy_item)
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for that category

- policy_item:

  An item from the policy file, which is the grading criteria for a
  specific category

## Value

A matrix with a single category's computed grades appended as additional
columns
