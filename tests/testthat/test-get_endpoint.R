test_that("get_endpoint works for Loci", {

  with_mock_api({
    loci <- get_endpoint("Loci")
  })

  expect_equal(loci$lociId[1], 1L)
})
