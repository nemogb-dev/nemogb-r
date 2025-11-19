# Get Grades

This function processes the Gradescope data and the policy file, and
then calculates all grades based on the criteria from the policy file
and the assignment scores from the Gradescope data. This function
assumes the YAML policy file and the Gradescope .csv file were read in
using the
[`read_policy()`](https://github.com/nemogb-dev/nemogb-r/reference/read_policy.md)
and
[`read_gs()`](https://github.com/nemogb-dev/nemogb-r/reference/read_gs.md)
functions respectively, which check for proper data format.

## Usage

``` r
get_grades(gs, policy, verbose = FALSE, append = TRUE)
```

## Arguments

- gs:

  A Gradescope dataframe

- policy:

  A grading policy file as an R list

- verbose:

  if FALSE, throws error if no assignments found in gs

- append:

  if FALSE, returns dataframe with only newly computed categories'
  scores

## Value

A dataframe of the original Gradescope data with computed categories'
scores appended as additional columns

## Examples

``` r
get_grades(gs = gs_demo, policy = policy_demo, verbose = TRUE)
#> # A tibble: 10 × 59
#>    Names               Email         SID   Sections `Lab 1` `Lab 1 - Max Points`
#>    <chr>               <chr>         <chr> <chr>      <dbl>                <dbl>
#>  1 Dr. Kadin           Dr.Kadin@ber… 3032… fake-cl…     0.9                   10
#>  2 Bartley Toy         BartleyToy@b… 3032… fake-cl…     0.5                   10
#>  3 Dr. Dontae          Dr.Dontae@be… 3032… fake-cl…     1                     10
#>  4 Narcissus Considine NarcissusCon… 3032… fake-cl…     1                     10
#>  5 Verne Wilderman     VerneWilderm… 3032… fake-cl…     0.8                   10
#>  6 Toivo Witting       ToivoWitting… 3032… fake-cl…     0.9                   10
#>  7 Tegan Crooks        TeganCrooks@… 3032… fake-cl…     0.8                   10
#>  8 Tyrus Cremin-Wisozk TyrusCremin-… 3032… fake-cl…     0.2                   10
#>  9 Sydni Hansen        SydniHansen@… 3032… fake-cl…     0.8                   10
#> 10 Mrs. Chelsie        Mrs.Chelsie@… 3032… fake-cl…     0.5                   10
#> # ℹ 53 more variables: `Lab 1 - Submission Time` <dbl>,
#> #   `Lab 1 - Lateness (H:M:S)` <time>, `Lab 2` <dbl>,
#> #   `Lab 2 - Max Points` <dbl>, `Lab 2 - Submission Time` <dbl>,
#> #   `Lab 2 - Lateness (H:M:S)` <time>, `Lab 3` <dbl>,
#> #   `Lab 3 - Max Points` <dbl>, `Lab 3 - Submission Time` <dbl>,
#> #   `Lab 3 - Lateness (H:M:S)` <time>, `Lab 4` <dbl>,
#> #   `Lab 4 - Max Points` <dbl>, `Lab 4 - Submission Time` <dbl>, …
```
