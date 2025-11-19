# Read Gradescope CSV File

This functions reads the Gradescope CSV file and checks for correct
Gradescope format. Each assignment should follow the four-column format:
`Assignment Name`, `Assignment Name - Max Points`,
`Assignment Name - Submission Time`,
`Assignment Name - Lateness (H:M:S)`. All other columns are designed as
ID columns.

## Usage

``` r
read_gs(path, verbose = FALSE)
```

## Arguments

- path:

  Path to Gradescope CSV

- verbose:

  whether or not to print messages

## Value

A dataframe of Gradescope CSV file, if no errors

## Details

Now it is favored to use read_files. This function is left for
backwards-compatibility.

## Examples

``` r
path <- system.file("extdata", "gs_demo.csv", package = "nemogb")
read_gs(path = path)
#> Rows: 10 Columns: 44
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr  (13): Names, Email, Sections, Lab 1 - Submission Time, Lab 2 - Submissi...
#> dbl  (21): SID, Lab 1, Lab 1 - Max Points, Lab 2, Lab 2 - Max Points, Lab 3,...
#> time (10): Lab 1 - Lateness (H:M:S), Lab 2 - Lateness (H:M:S), Lab 3 - Laten...
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```
