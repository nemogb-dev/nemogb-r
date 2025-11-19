# Process Gradescope Data

This function processes the Gradescope data before grading. Ungraded
assignments (i.e. assignments with all NAs for their scores) can
optionally be dropped. Eventually, this will also merge duplicated
students and deal with students with no SID.

## Usage

``` r
process_gs(gs, drop_ungraded = TRUE, verbose = FALSE)
```

## Arguments

- gs:

  A Gradescope dataframe with students as rows and assignment
  information across the columns.

- drop_ungraded:

  Whether or not to drop ungraded assignments

- verbose:

  Whether or not to print messages and warnings

## Value

Gradescope dataframe, optionally with all ungraded assignments removed

## Examples

``` r
process_gs(gs = gs_demo, drop_ungraded = TRUE, verbose = TRUE)
#> Important Message
#> ℹ These are no ungraded assignments
#> # A tibble: 10 × 44
#>    Names               Email           SID Sections `Lab 1` `Lab 1 - Max Points`
#>    <chr>               <chr>         <dbl> <chr>      <dbl>                <dbl>
#>  1 Dr. Kadin           Dr.Kadin@be… 3.03e9 fake-cl…       9                   10
#>  2 Bartley Toy         BartleyToy@… 3.03e9 fake-cl…       5                   10
#>  3 Dr. Dontae          Dr.Dontae@b… 3.03e9 fake-cl…      10                   10
#>  4 Narcissus Considine NarcissusCo… 3.03e9 fake-cl…      10                   10
#>  5 Verne Wilderman     VerneWilder… 3.03e9 fake-cl…       8                   10
#>  6 Toivo Witting       ToivoWittin… 3.03e9 fake-cl…       9                   10
#>  7 Tegan Crooks        TeganCrooks… 3.03e9 fake-cl…       8                   10
#>  8 Tyrus Cremin-Wisozk TyrusCremin… 3.03e9 fake-cl…       2                   10
#>  9 Sydni Hansen        SydniHansen… 3.03e9 fake-cl…       8                   10
#> 10 Mrs. Chelsie        Mrs.Chelsie… 3.03e9 fake-cl…       5                   10
#> # ℹ 38 more variables: `Lab 1 - Submission Time` <chr>,
#> #   `Lab 1 - Lateness (H:M:S)` <time>, `Lab 2` <dbl>,
#> #   `Lab 2 - Max Points` <dbl>, `Lab 2 - Submission Time` <chr>,
#> #   `Lab 2 - Lateness (H:M:S)` <time>, `Lab 3` <dbl>,
#> #   `Lab 3 - Max Points` <dbl>, `Lab 3 - Submission Time` <chr>,
#> #   `Lab 3 - Lateness (H:M:S)` <time>, `Lab 4` <dbl>,
#> #   `Lab 4 - Max Points` <dbl>, `Lab 4 - Submission Time` <chr>, …
```
