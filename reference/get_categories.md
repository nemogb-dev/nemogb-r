# Get the Category Names for Policy

This function identifies the names of all categories in a policy list.

## Usage

``` r
get_categories(policy, verbose = FALSE)
```

## Arguments

- policy:

  R list of a valid policy file

- verbose:

  Whether or not to return an alert of categories

## Value

A vector of the names of the categories in the policy R list

## Examples

``` r
get_categories(policy_demo, verbose = TRUE)
#> Important Message
#> ℹ The categories from the policy are Labs, Discussion, Midterm Exam, Final Exam, and Overall Grade
#> [1] "Labs"          "Discussion"    "Midterm Exam"  "Final Exam"   
#> [5] "Overall Grade"
```
