test_that("get_endpoint works for Loci", {

  with_mock_api({
    loci <- get_endpoint_JSON("Loci")
  })

  expect_equal(loci[[1]]$lociId, 1L)
})
