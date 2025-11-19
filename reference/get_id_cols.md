# Get the ID Columns for Gradescope Data

This function identifies the ID columns from Gradescope data.

## Usage

``` r
get_id_cols(gs, verbose = FALSE)
```

## Arguments

- gs:

  Gradescope dataframe

- verbose:

  Whether or not to return an alert of assignments

## Value

A vector of the names of the ID columns in the dataframe

## Examples

``` r
get_id_cols(gs_demo, verbose = TRUE)
#> Important Message
#> ℹ The ID columns from Gradescope are Names, Email, SID, and Sections
#> [1] "Names"    "Email"    "SID"      "Sections"
```
