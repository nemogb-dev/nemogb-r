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
            assignments = c("Lab 2.1", "Lab 2.2", "Lab 2.3")
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