# Gradescope Demo Data

An example dataset that mimics Gradescope format with students as rows
and assignment information across the columns. All assignments follow
the same four-column format of Lab 1, as noted below. Assignments in
`gs_demo` are Lab 1, Lab 2, Lab 3, Lab 4, Lab 5, Lab 6, Discussion 1,
Discussion 2, Midterm and Final. Any other columns that do not follow
this format are designated as ID columns.

## Usage

``` r
gs_demo
```

## Format

### `gs_demo`

A data frame with 10 rows and 44 columns:

- Names:

  Student name

- Email:

  Student email

- SID:

  Student ID number

- Sections:

  Student class section

- Lab 1:

  An assignment called Lab 1

- Lab 1 - Max Points:

  Maximum possible points for Lab 1

- Lab 1 - Lateness (H:M:S):

  How late Lab 1 was turned in, formatted HH:MM:SS

- Lab 1 - Submission Time:

  When Lab 1 was turned in, formatted MM/DD/YY HH:MM

## Examples

``` r
gs_demo
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
