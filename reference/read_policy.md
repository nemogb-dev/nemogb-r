# Read Grading Policy .yml

This functions reads the grading policy YAML file and checks for correct
format

## Usage

``` r
read_policy(path, verbose = FALSE)
```

## Arguments

- path:

  Path to YAML policy file

- verbose:

  Whether or not to print messages and warnings

## Value

R list of the policy file, if no errors

## Examples

``` r
path <- system.file("extdata", "policy_demo.yaml", package = "nemogb")
read_policy(path = path, verbose = TRUE)
#> $coursewide
#> $coursewide$course_name
#> [1] "Stat 101"
#> 
#> $coursewide$description
#> [1] "Syllabus for gs_demo"
#> 
#> 
#> $categories
#> $categories[[1]]
#> $categories[[1]]$category
#> [1] "Overall Grade"
#> 
#> $categories[[1]]$aggregation
#> [1] "weighted_mean"
#> 
#> $categories[[1]]$assignments
#> $categories[[1]]$assignments[[1]]
#> $categories[[1]]$assignments[[1]]$category
#> [1] "Labs"
#> 
#> $categories[[1]]$assignments[[1]]$aggregation
#> [1] "weighted_by_points"
#> 
#> $categories[[1]]$assignments[[1]]$weight
#> [1] 0.3
#> 
#> $categories[[1]]$assignments[[1]]$assignments
#> [1] "Lab 1" "Lab 2" "Lab 3" "Lab 4" "Lab 5" "Lab 6"
#> 
#> 
#> $categories[[1]]$assignments[[2]]
#> $categories[[1]]$assignments[[2]]$category
#> [1] "Discussion"
#> 
#> $categories[[1]]$assignments[[2]]$aggregation
#> [1] "equally_weighted"
#> 
#> $categories[[1]]$assignments[[2]]$weight
#> [1] 0.1
#> 
#> $categories[[1]]$assignments[[2]]$assignments
#> [1] "Discussion 1" "Discussion 2"
#> 
#> 
#> $categories[[1]]$assignments[[3]]
#> $categories[[1]]$assignments[[3]]$category
#> [1] "Midterm Exam"
#> 
#> $categories[[1]]$assignments[[3]]$aggregation
#> [1] "none"
#> 
#> $categories[[1]]$assignments[[3]]$weight
#> [1] 0.3
#> 
#> $categories[[1]]$assignments[[3]]$assignments
#> [1] "Midterm"
#> 
#> 
#> $categories[[1]]$assignments[[4]]
#> $categories[[1]]$assignments[[4]]$category
#> [1] "Final Exam"
#> 
#> $categories[[1]]$assignments[[4]]$aggregation
#> [1] "none"
#> 
#> $categories[[1]]$assignments[[4]]$weight
#> [1] 0.3
#> 
#> $categories[[1]]$assignments[[4]]$assignments
#> [1] "Final"
#> 
#> 
#> 
#> 
#> 
```
