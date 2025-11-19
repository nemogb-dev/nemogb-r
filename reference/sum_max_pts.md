# Aggregation for Maximum Possible Points Functions

A collection of functions to compute the maximum possible points for
each category

- `sum_max_pts()` computes the maximum possible points for each category
  as the sum of maximum points of each assignment within the category

- `mean_max_pts()` computes the maximum possible points for each
  category as the average of maximum points of each assignment within
  the category

## Usage

``` r
sum_max_pts(grades_mat, category, assignments)

mean_max_pts(grades_mat, category, assignments)
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for each category

- category:

  Category name

- assignments:

  Assignment names for this category

## Value

A matrix with the additional computation of the maximum possible points
for each category
