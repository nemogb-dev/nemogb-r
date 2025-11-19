# Aggregation for Lateness Functions

A collection of functions to computes lateness for category.

- `mean_lateness()` computes the aggregated lateness of a category by
  taking the mean of the lateness of the category's assignments

- `sum_lateness()` computes the aggregated lateness of a category by
  taking the sum of the lateness of the category's assignments

- `max_lateness()` computes the aggregated lateness of a category by
  taking the maximum of the lateness of the category's assignments

## Usage

``` r
mean_lateness(grades_mat, category, assignments)

sum_lateness(grades_mat, category, assignments)

max_lateness(grades_mat, category, assignments)
```

## Arguments

- grades_mat:

  Matrix with assignments + associated columns for each category

- category:

  Category name

- assignments:

  Assignment names for this category

## Value

A matrix with the aggregated lateness for each category
