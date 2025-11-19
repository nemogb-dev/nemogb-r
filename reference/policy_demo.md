# Policy Demo File

An example policy file that mimics a hypothetical class syllabus. Note
that this is a very minimal policy file, and information about more
specific grading criteria can be found via the vignettes.

## Usage

``` r
policy_demo
```

## Format

A list of two nested lists

- COURSEWIDE:

  First nested list with general information about the class

- course_name:

  Name of the course, saved as a string

- description:

  Any relevant course description, purely for the user, also saved as a
  single string

- CATEGORIES:

  Second nested list where syllabus is broken down into categories with
  their respective grading criteria

- category:

  Category name

- aggregation:

  How assignment scores are aggregated to calculate category score

- assignments:

  List of assignment names that fall into this category

## Examples

``` r
policy_demo
#> $coursewide
#> $coursewide$course_name
#> [1] "Stat 101"
#> 
#> $coursewide$description
#> [1] "syllabus for gs_demo"
#> 
#> 
#> $categories
#> $categories[[1]]
#> $categories[[1]]$category
#> [1] "Labs"
#> 
#> $categories[[1]]$aggregation
#> [1] "weighted_by_points"
#> 
#> $categories[[1]]$assignments
#> [1] "Lab 1" "Lab 2" "Lab 3" "Lab 4" "Lab 5" "Lab 6"
#> 
#> 
#> $categories[[2]]
#> $categories[[2]]$category
#> [1] "Discussion"
#> 
#> $categories[[2]]$aggregation
#> [1] "equally_weighted"
#> 
#> $categories[[2]]$assignments
#> [1] "Discussion 1" "Discussion 2"
#> 
#> 
#> $categories[[3]]
#> $categories[[3]]$category
#> [1] "Midterm Exam"
#> 
#> $categories[[3]]$aggregation
#> [1] "none"
#> 
#> $categories[[3]]$assignments
#> [1] "Midterm"
#> 
#> 
#> $categories[[4]]
#> $categories[[4]]$category
#> [1] "Final Exam"
#> 
#> $categories[[4]]$aggregation
#> [1] "none"
#> 
#> $categories[[4]]$assignments
#> [1] "Final"
#> 
#> 
#> $categories[[5]]
#> $categories[[5]]$category
#> [1] "Overall Grade"
#> 
#> $categories[[5]]$aggregation
#> [1] "weighted_mean"
#> 
#> $categories[[5]]$weights
#> [1] 0.3 0.1 0.3 0.3
#> 
#> $categories[[5]]$assignments
#> [1] "Labs"       "Discussion" "Midterm"    "Final"     
#> 
#> 
#> 
```
