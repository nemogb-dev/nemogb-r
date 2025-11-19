# Apply Slip Days

This function applies any slip day policies within the policy file.

## Usage

``` r
apply_slip_days(gs, policy)
```

## Arguments

- gs:

  A Gradescope dataframe

- policy:

  A grading policy file as an R list

## Value

A dataframe of the original Gradescope data with lateness updated
according to the slip day policies

## Examples

``` r
path <- system.file("extdata", "slip-days-policy-demo.yaml", package = "nemogb")
slip_days_policy_demo <- read_policy(path = path)
apply_slip_days(gs = gs_demo, policy = slip_days_policy_demo)
#> # A tibble: 10 × 45
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
#> # ℹ 39 more variables: `Lab 1 - Submission Time` <chr>,
#> #   `Lab 1 - Lateness (H:M:S)` <chr>, `Lab 2` <dbl>,
#> #   `Lab 2 - Max Points` <dbl>, `Lab 2 - Submission Time` <chr>,
#> #   `Lab 2 - Lateness (H:M:S)` <chr>, `Lab 3` <dbl>,
#> #   `Lab 3 - Max Points` <dbl>, `Lab 3 - Submission Time` <chr>,
#> #   `Lab 3 - Lateness (H:M:S)` <chr>, `Lab 4` <dbl>,
#> #   `Lab 4 - Max Points` <dbl>, `Lab 4 - Submission Time` <chr>, …
```
