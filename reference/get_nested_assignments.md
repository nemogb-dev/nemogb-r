# Get the Nested Assignments for Category

This function identifies the nested assignments for a given category.

## Usage

``` r
get_nested_assignments(category, verbose = FALSE)
```

## Arguments

- category:

  a category from a policy R list

- verbose:

  Whether or not to return an alert of assignments

## Value

A vector of the names of the nested assignments in the category

## Examples

``` r
category <- policy_demo[["categories"]][[1]]
get_nested_assignments(category = category, verbose = TRUE)
#> Important Message
#> ℹ The assignments from the category Labs are Lab 1, Lab 2, Lab 3, Lab 4, Lab 5, and Lab 6
#> [1] "Lab 1" "Lab 2" "Lab 3" "Lab 4" "Lab 5" "Lab 6"
```
