# Lateness Functions

A collection of functions to apply lateness policies if the lateness of
an assignment falls within a specified threshold

- `until()` determines if the lateness for `assignments` is less than or
  equal to `late_policy`

- `between()` determines if lateness for `assignments` is between
  `late_policy`

- `after()` determines if lateness for `assignments` is more than or
  equal to `late_policy`

- `add()` adds `late_policy` to score if the lateness of the
  `assignments` is within the threshold (Note: a positive value for
  `late_policy` would increase the score for that assignment)

- `scale_by()` scales score by `late_policy` if the lateness of the
  `assignments` is within the threshold

- `set_to()` sets score to `late_policy` if the lateness of the
  `assignments` is within the threshold

## Usage

``` r
until(grades_mat, late_policy, original_late_mat, assignments)

add(grades_mat, late_policy, original_late_mat, assignments)

between(grades_mat, late_policy, original_late_mat, assignments)

scale_by(grades_mat, late_policy, original_late_mat, assignments)

after(grades_mat, late_policy, original_late_mat, assignments)

set_to(grades_mat, late_policy, original_late_mat, assignments)
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for each category

- late_policy:

  Relevant threshold/scalar for lateness policy

- original_late_mat:

  Matrix that saves original lateness values

- assignments:

  Assignment names for this category

## Value

A matrix with the lateness penalties applied to the score of the
category's assignments
