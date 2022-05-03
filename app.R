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
        textInput(
          inputId = "currency",
          label = "Currency",
          value = ""
        ),
        numericInput(
          inputId = "dividend_yield",
          label = "Dividend Yield in percent",
          value = 2,
          min = 0,
          max = 100,
          step = 0.1
        ),
        numericInput(
          inputId = "per",
          label = "Price Earnings Ratio",
          value = 10,
          min = 0,
          max = 100,
          step = 0.01
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
      )
    ) # tabPanel(), About
  ) # navbarPage()
) # fluidPage()


####################################
# Server                           #
####################################
server <- function(input, output, session) {


  # Input Data
  datasetInput <- reactive({

    # bmi <- input$weight/( (input$height/100) * (input$height/100) )
    # bmi <- data.frame(bmi)
    # names(bmi) <- "BMI"
    # print(bmi)
    # print(paste0(input$ticker_symbol, ": ",
    #              input$dividend_yield, " ", input$currency, " Dividend Yield"))
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
