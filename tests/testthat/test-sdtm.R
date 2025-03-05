test_that("sdtm block constructor", {

  blk <- new_sdtm_block("ae")

  expect_s3_class(blk, "sdtm_block")

  testServer(
    block_expr_server(blk),
    {
      expect_equal(dat(), "ae")
      session$setInputs(dataset = "dm")
      expect_equal(dat(), "dm")
    }
  )

  testServer(
    get_s3_method("block_server", blk),
    {
      session$flushReact()
      expect_identical(
        session$returned$result(),
        pharmaversesdtm::ae
      )
    },
    args = list(x = blk)
  )
})
