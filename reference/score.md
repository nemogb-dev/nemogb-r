# Key Functions

A collection of functions that correspond to the keys used in the policy
YAML file: each function/key corresponds to a specific cluster of
grading functionality.

- `score()` computes the percentage score and saves back into the column
  with the original assignment score

- `aggregation()` computes the category score by aggregating the
  associated assignment scores

- `lateness()` applies any relevant lateness penalty within the given
  thresholds

- `drop_n_lowest()` drops the n lowest assignment scores; if n \>= num
  of assignments, returns highest assignment score

- `aggregation_max_pts()` computes the maximum possible points for each
  category

- `aggregation_lateness()` computes the aggregated lateness for each
  category

## Usage

``` r
score(grades_mat, policy_line, category, assignments, weights = c())

aggregation(grades_mat, policy_line, category, assignments, weights = c())

lateness(grades_mat, policy_line, category, assignments, weights = c())

drop_n_lowest(grades_mat, policy_line, category, assignments, weights = c())

aggregation_max_pts(
  grades_mat,
  policy_line,
  category,
  assignments,
  weights = c()
)

aggregation_lateness(
  grades_mat,
  policy_line,
  category,
  assignments,
  weights = c()
)
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for that category

- policy_line:

  Policy list item for each key

- category:

  Category name

- assignments:

  Assignment names for this category as a vector

- weights:

  Weights for `weighted_mean` as a vector

## Value

A matrix with the additional computation from the relevant key function
