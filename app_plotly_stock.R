#################################################################################
# Layal Christine Lettry                                                        #
# Source: https://www.rstudio.com/blog/how-to-use-shinymatrix-and-plotly-graphs/#
#################################################################################
### Load packages
library(shiny)
library(tidyverse)
library(plotly)
library(shinyMatrix)
library(dplyr)
library(data.table)
#--- Import data ---------------------------------------------------------------

# Matrix
REF_VALUES <- data.table::fread(
  file = "data/ref_values.csv",
  stringsAsFactors = TRUE
) %>%
  as.matrix()


# Tibble
REF_VALUES_TIB <- data.table::fread(
  file = "data/ref_values.csv",
  stringsAsFactors = TRUE
) %>%
  as_tibble()

# Names of matrix = variable of tibble
rownames(REF_VALUES) <- REF_VALUES_TIB$variable

### Define UI
ui <- fluidPage(
  titlePanel("Stock-trading tools"),
  column(
    4,
    radioButtons(
      "toggleInputSelect",
      "Input Method:",
      choices = c(
        "Drag-and-Drop" = "dragDrop",
        "Hand Typed" = "handTyped"
      )
    ),
    br(),
    conditionalPanel(
      condition = "input.toggleInputSelect=='dragDrop'",
      plotlyOutput("speed_p", height = "250px")
    ),
    conditionalPanel(
      condition = "input.toggleInputSelect=='handTyped'",
      matrixInput(
        "REF_VALUES_MI",
        value = REF_VALUES,
        row = list(names = FALSE),
        class = "numeric"
      )
    )
  ),
  column(
    8,
    tabsetPanel(
      id = "tabs",
      tabPanel(
        "Algorithm Tab",
        value = "algorithmOutput",
        column(
          3, br(),
          tags$h4("Original Values"),
          tableOutput("table1")
        ),
        column(
          3, br(),
          tags$h4("Matrix Inputs"),
          tableOutput("table2")
        ),
        column(
          3, br(),
          tags$h4("Reactive Values"),
          tableOutput("table3")
        )
      )
    )
  )
)


### Define server logic
server <- function(input, output, session) {
  output$table1 <- renderTable({
    REF_VALUES
  })

  output$table2 <- renderTable({
    input$REF_VALUES_MI
  })

  output$table3 <- renderTable({
    req(rv$time)
    data.frame(rv$time, rv$speed)
  })

  # Creating Reactive Values
  rv <- reactiveValues()
}

### Run the application
shinyApp(ui = ui, server = server)
