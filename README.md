# NemoGB

An R package to make course grade calculations easy, fast, and most importantly,
correct. Course grades are produced from a data frame of assignment grades along
with a grading policy file that allows for accurate and systematic computations
of the final course letter grades. This R package also functions as the backend of the
[NemoGB Shiny app](https://github.com/gradebook-dev/gradebook-app.git), which lets the
which lets the user create their grading policy file in a straightforward way.

### Installation Instructions

To install `NemoGB`, make sure to install `devtools` first. The `pkgdown` website for this version is at [nemogb-dev.github.io/nemogb-r/](https://nemogb-dev.github.io/nemogb-r/).

``` r
# install.packages("devtools")
devtools::install_github("nemogb-dev/nemogb-r")
library(nemogb)
```

------------------------------------------------------------------------

### Example Usage

Load in your Gradescope data using `read_gs()`.
```r
library(nemogb)
gs_data <- read_gs("gs_demo.csv")
```

Start by building a policy file that reflects the assignments from your Gradescope file and the structure of the syllabus. 
More information and guidance on building your policy file in YAML format can be found in the [Building a Policy File vignette](https://nemogb-dev.github.io/nemogb-r/articles/policy-files.html).

This YAML policy file should be loaded in with `read_policy()`, and then course grades can be computed with `get_grades()`.
```r
policy <- read_policy("policy_demo.yaml")

grades <- get_grades(policy = policy, gs = gs_data)
```

------------------------------------------------------------------------

### Community Guidelines

We welcome the contribution and feedback of others in order to make grading an effective and informative task for any course. Please review our
[contributing](https://github.com/nemogb-dev/nemogb-r/blob/main/CONTRIBUTING.md) guidelines. By contributing to this project, you agree to abide by this guidelines.

------------------------------------------------------------------------

