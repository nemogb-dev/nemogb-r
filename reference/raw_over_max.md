# Score Functions

A collection of functions to calculate the percentage score and save
back into the column with the assignment score

- `raw_over_max()` computes score by dividing the original assignment
  score by the maximum possible points for the assignment

## Usage

``` r
raw_over_max(grades_mat, assignments)
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for that category

- assignments:

  Assignment names for this category

## Value

A matrix with computed assignment scores
