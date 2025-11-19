# Predict the source of grade dataframe.

This function performs the auto-determination of where the grades
dataframe was sourced.

## Usage

``` r
determine_grade_source(grades_df)
```

## Arguments

- grades_df:

  This is the input Dataframe

## Value

A string "Canvas", "Gradescope", or "Unrecognized" of the determination.
