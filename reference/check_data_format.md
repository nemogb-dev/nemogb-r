# Check Formatting of Grades Data

This functions checks the column names throughout the Grades data. There
must be an SID column and at least one assignment. It also gives an
alert for what ID columns and assignments are in the data.

## Usage

``` r
check_data_format(gs, verbose = FALSE)
```

## Arguments

- gs:

  Gradescope data frame

- verbose:

  Whether or not to print messages and warnings

## Value

Same gs dataframe if no errors.

## Examples

``` r
check_data_format(gs_demo, verbose = TRUE)
#> Important Message
#> ℹ The ID columns from Gradescope are Names, Email, SID, and Sections
#> Important Message
#> ℹ The assignments from Gradescope are Discussion 1, Discussion 2, Final, Lab 1, Lab 2, Lab 3, Lab 4, Lab 5, Lab 6, and Midterm
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
