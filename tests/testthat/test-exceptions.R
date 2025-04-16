test_that("one exception - extra quiz drop", {
  categories <- list(
    category = "Overall Grade",
    aggregation = "weighted_mean",
    assignments = list(
      list(
        category = "Labs",
        weight = 0.5,
        aggregation = "equally_weighted",
        assignments = list(
          list(
            category = "Lab 1",
            aggregation = "weighted_by_points",
            assignments = c("Lab 1.1", "Lab 1.2")
          ),
          list(
            category = "Lab 2",
            aggregation = "weighted_by_points",
            assignments = c("Lab 2.1", "Lab 2.2")
          )
        )
      ),
      list(
        category = "Quiz",
        weight = 0.5,
        drop_n_lowest = 1,
        aggregation = "weighted_by_points",
        assignments = c("Quiz 1", "Quiz 2", "Quiz 3")
      )
    )
  )
  exceptions <- list(
    list(
      category = "Quiz",
      weight = 0.5,
      drop_n_lowest = 2,
      SID = c(111, 222),
      aggregation = "weighted_by_points",
      assignments = c("Quiz 1", "Quiz 2", "Quiz 3")
    )
  )
  policy <- list(categories = list(categories), exceptions = exceptions)
  
  gs <- tibble::tibble(SID = c(111,222,333,444,555),
                       `Lab 1.1` = c(0.2, 0.4, 0.6, 0.8, 0.9),
                       `Lab 1.1 - Max Points` = rep(5, 5),
                       `Lab 1.1 - Submission Time` = rep(NA, 5),
                       `Lab 1.1 - Lateness (H:M:S)` = rep(NA, 5),
                       
                       `Lab 1.2` = c(0.9, 0.4, 0.6, 0.7, 0.9),
                       `Lab 1.2 - Max Points` = rep(10, 5),
                       `Lab 1.2 - Submission Time` = rep(NA, 5),
                       `Lab 1.2 - Lateness (H:M:S)` = rep(NA, 5),
                       
                       `Lab 2.1` = c(0.2, 0.5, 0.9, 0.95, 0.9),
                       `Lab 2.1 - Max Points` = rep(15, 5),
                       `Lab 2.1 - Submission Time` = rep(NA, 5),
                       `Lab 2.1 - Lateness (H:M:S)` = rep(NA, 5),
                       
                       `Lab 2.2` = c(0.2, 0.4, 1, 0.7, 0.9),
                       `Lab 2.2 - Max Points` = rep(20, 5),
                       `Lab 2.2 - Submission Time` = rep(NA, 5),
                       `Lab 2.2 - Lateness (H:M:S)` = rep(NA, 5),
                       
                       `Quiz 1` = c(0.2, 0.4, 1, 0.7, 0.9),
                       `Quiz 1 - Max Points` = rep(20, 5),
                       `Quiz 1 - Submission Time` = rep(NA, 5),
                       `Quiz 1 - Lateness (H:M:S)` = rep(NA, 5),
                       
                       `Quiz 2` = c(0.9, 0.4, 0.6, 0.7, 0.9),
                       `Quiz 2 - Max Points` = rep(20, 5),
                       `Quiz 2 - Submission Time` = rep(NA, 5),
                       `Quiz 2 - Lateness (H:M:S)` = rep(NA, 5),
                       `Quiz 3` = c(0.2, 0.5, 0.9, 0.95, 0.9),
                       `Quiz 3 - Max Points` = rep(20, 5),
                       `Quiz 3 - Submission Time` = rep(NA, 5),
                       `Quiz 3 - Lateness (H:M:S)` = rep(NA, 5),
  )
  attr(gs, "source") <- "Gradescope"
  grades <- get_grades_with_exceptions(gs, policy)
})

test_that("one exception - adding new category to overall grade", {
  expect_equal(2 * 2, 4)
})

test_that("two exceptions - different students in each", {
  expect_equal(2 * 2, 4)
})


test_that("two exceptions - same students in both", {
  expect_equal(2 * 2, 4)
})

test_that("two exceptions - some overlapped students", {
  expect_equal(2 * 2, 4)
})

test_that("exceptions in overall grade", {
  expect_equal(2 * 2, 4)
})