# Aggregation Functions

A collection of functions to compute aggregated scores for each
category.

- `equally_weighted()` computes the aggregated category score by taking
  the mean of assignment scores

- `weighted_by_points()` computes the aggregated category score by
  taking the weighted mean of assignment scores using a `weights` vector

- `max_score()` computes the aggregated category score by taking the
  maximum of assignment scores

- `min_score()` computes the aggregated category score by taking the
  minimum of assignment scores

- `none()` is used if there is only one assignment in a category and
  returns that single score; otherwise it defaults to `equally_weighted`

## Usage

``` r
equally_weighted(grades_mat, category, assignments, weights = c())

weighted_by_points(grades_mat, category, assignments, weights = c())

max_score(grades_mat, category, assignments, weights = c())

min_score(grades_mat, category, assignments, weights = c())

weighted_mean(grades_mat, category, assignments, weights)

none(grades_mat, category, assignments, weights = c())
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for each category

- category:

  Category name

- assignments:

  Assignment names for this category

- weights:

  Weights for `weighted_mean`, defaults to NULL with other aggregation
  method

## Value

A matrix with the additional computation of the aggregated category
score
