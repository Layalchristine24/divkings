############################################
# Layal Christine Lettry                   #
# Source: http://github.com/dataprofessor  #
############################################

library(shiny)
library(shinythemes)


####################################
# User Interface                   #
####################################
ui <- fluidPage(
  theme = shinytheme("superhero"),
  navbarPage(
    "Stock-trading tools:",
    tabPanel(
      "Home",
      # Input values
      sidebarPanel(
        HTML("<h3>Input parameters</h3>"),
        textInput(
          inputId = "ticker_symbol",
          label = "Ticker Symbol",
          value = ""
        ),
        radioButtons(
          inputId = "currency",
          label = "Currency",
          choices = list("USD", "EUR", "CHF", "GBP")
        ),
        numericInput(
          inputId = "dividend_yield",
          label = "Dividend Yield in percent",
          value = "",
          min = 0,
          max = 100,
          step = 0.1
        ),
        numericInput(
          inputId = "per",
          label = "Price-to-Earnings Ratio (PER)",
          value = "",
          min = 0,
          max = 100,
          step = 0.01
        ),
        numericInput(
          inputId = "eps",
          label = "Earnings Per Share (EPS)",
          value = "",
          min = 0,
          max = 100,
          step = 0.01
        ),
        numericInput(
          inputId = "eps",
          label = "EPS Observed Growth",
          value = "",
          min = 0,
          max = 100,
          step = 0.01
        ),
        numericInput(
          inputId = "roi",
          label = "Return On Investment (ROI) in Percent",
          value = "",
          min = 0,
          max = 100,
          step = 0.01
        ),
        numericInput(
          inputId = "payout_ratio",
          label = "Payout Ratio",
          value = "",
          min = 0,
          max = 100,
          step = 0.01
        ),
        radioButtons(
          inputId = "eps_obs_growth",
          label = "EPS Observed Growth",
          choices = list("Positive", "Negative")
        ),
        radioButtons(
          inputId = "eps_proj_growth",
          label = "EPS Projected Growth",
          choices = list("Positive", "Negative")
        ),
        radioButtons(
          inputId = "obs_total_earn_growth",
          label = "Total Earnings Observed Growth",
          choices = list("Positive", "Negative")
        ),
        actionButton("submitbutton",
                     "Submit",
                     class = "btn btn-primary"
        )
      ),
      mainPanel(
        tags$label(h3("Evaluation")), # Status/Output Text Box
        verbatimTextOutput("contents"),
        tableOutput("tabledata") # Results table
      ) # mainPanel()
    ), # tabPanel(), Home
    
    tabPanel(
      "About",
      titlePanel("About"),
      div(includeMarkdown("about.md"),
          align = "justify"
      ),
      tableOutput(outputId = "table")
    ) # tabPanel(), About
  ) # navbarPage()
) # fluidPage()

####################################
# Server                           #
####################################
server <- function(input, output, session) {


  # Input Data
  datasetInput <- reactive({
    final_eval <- if (
      input$dividend_yield >= 2 &
        input$per <= 20) {
      paste0(input$ticker_symbol, " stock ", "is a good opportunity.")
    } else {
      paste0(input$ticker_symbol, " stock ", "is not a good opportunity.")
    }
    print(final_eval)
  })

  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton > 0) {
      isolate("Calculation complete.")
    } else {
      return("Server is ready for calculation.")
    }
  })

  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton > 0) {
      isolate(datasetInput())
    }
  })
}


####################################
# Create Shiny App                 #
####################################
shinyApp(ui = ui, server = server)
