#' SDTM data block constructor
#'
#' This block allows to selected data from a package,
#' the default being datasets.
#'
#' @param dataset Selected dataset
#' @param ... Forwarded to [new_block()]
#'
#' @export
new_sdtm_block <- function(dataset = character(), ...) {

  is_df <- function(x, pkg) {
    inherits(do.call("::", list(pkg, x)), "data.frame")
  }

  list_datasets <- function() {
    datasets <- utils::data(package = "pharmaversesdtm")
    datasets <- datasets$results[, "Item"]

    options <- gsub("\\s+\\(.+\\)$", "", datasets)

    options[vapply(options, is_df, logical(1L), "pharmaversesdtm")]
  }

  new_data_block(
    function(id) {
      moduleServer(
        id,
        function(input, output, session) {

          dat <- reactiveVal(dataset)

          observeEvent(input$dataset, dat(input$dataset))

          list(
            expr = reactive({
              eval(
                bquote(
                  as.call(c(as.symbol("::"), quote(.(pkg)), quote(.(dat)))),
                  list(pkg = as.name("pharmaversesdtm"), dat = as.name(dat()))
                )
              )
            }),
            state = list(dataset = dat)
          )
        }
      )
    },
    function(id) {
      selectInput(
        inputId = NS(id, "dataset"),
        label = "Dataset",
        choices = list_datasets(),
        selected = dataset
      )
    },
    class = "sdtm_block",
    ...
  )
}
