register_sdtm_blocks <- function() { # nocov start
  register_blocks(
    c(
      "new_sdtm_block"
    ),
    name = c(
      "SDTM dataset block"
    ),
    description = c(
      "SDTM datasets as provided by 'pharmaversesdtm'"
    ),
    category = c(
      "data"
    ),
    package = utils::packageName(),
    overwrite = TRUE
  )
}

.onLoad <- function(libname, pkgname) {

  register_sdtm_blocks()

  invisible(NULL)
} # nocov end
