# Get the Assignment Names for Gradescope Data

This function identifies the assignments from Gradescope data and
returns the assignments' names.

## Usage

``` r
get_assignments(gs, verbose = FALSE)
```

## Arguments

- gs:

  Gradescope dataframe

- verbose:

  Whether or not to print assignment names

## Value

A vector of the names of the assignments in the dataframe

## Examples

``` r
get_assignments(gs_demo, verbose = TRUE)
#> Important Message
#> ℹ The assignments from Gradescope are Discussion 1, Discussion 2, Final, Lab 1, Lab 2, Lab 3, Lab 4, Lab 5, Lab 6, and Midterm
#>  [1] "Discussion 1" "Discussion 2" "Final"        "Lab 1"        "Lab 2"       
#>  [6] "Lab 3"        "Lab 4"        "Lab 5"        "Lab 6"        "Midterm"     
```
