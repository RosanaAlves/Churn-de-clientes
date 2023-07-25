#install.packages("shinycssloaders")
#install.packages("shinyWidgets")
library(readr)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(shinyWidgets)
library(shinycssloaders)# carregar uma animação
shiny::includeMarkdown()#incluir arquivo markdown

dados <-read_csv("Data-Raw/Customer-Churn-Records.csv")

nyse <- read.csv("data/nyse.csv", stringsAsFactors = FALSE)
nasdaq  <- read.csv("data/nasdaqcsv.csv", stringsAsFactors = FALSE)
constituents <- read.csv("data/constituents.csv", stringsAsFactors = FALSE)
other <- read.csv("data/other-listed.csv", stringsAsFactors = FALSE)
sticker <- rbind(nasdaq, nyse[,c(1,2)], constituents[, c(1,2)], other[,c(1,2)])
sticker <- sticker[duplicated(sticker$symbol),]
sticker$choices <- paste0(sticker$symbol, ": ",sticker$name)

ui <- dashboardPage(
  skin =c("midnight"),
  dashboardHeader(
    tags$li(
      class = "dropdown",
      tags$style(".main-header {max-height: 38px}"),
      tags$style(".main-header .logo {height: 38px}")
    ),
    title = div(
      span(
        img(
          src = "stock_header.png",
          height = 40,
          width = "20%"
        ),
        "Stock Market Forecasting"
      ),
      align = "left",
      width = "100%",
      style = "padding-right:0px;"
    ),
    titleWidth = 310
  ),
  dashboardSidebar(
    width = 310,
    div(class = "inlay", style = "height:10px;;"),
    div(style = "overflow: visible;width:inherit;",
        sidebarMenu(
          menuItem(
            "Stock Symbols Selection",
            tabName = "stock_symbol",
            icon = icon("dashboard"),
            hr(),
            pickerInput(
              inputId = "stickers",
              label = "Select Stock Symbols: ",
              choices = sticker$symbol,
              multiple = TRUE,
              selected = c("GOOGL", "FB", "AMZN", "AAPL"),
              options = list(
                `max-options` = 8,
                `actions-box` = TRUE,
                `live-search` = TRUE,
                `virtual-scroll` = 10,
                `multiple-separator` = "\n",
                size = 10
              ),
              choicesOpt = list(content = stringr::str_trunc(sticker$choices, width = 30))
            ),
            dateInput(
              "dt_frome",
              "Date from:",
              value = Sys.Date() - 720,
              max = Sys.Date() - 360
            ),
            dateInput("dt_to", "Date to:", value = Sys.Date(), min = Sys.Date() -
                        360),
            actionButton("submit", "Get Symbols", icon("paper-plane"),
                         style = "color: #fff; background-color: #32907c; border-color: #32907c"),
            br(),
            hr()
          )
        ))
  ),
  dashboardBody(
    shinyjs::useShinyjs(),
    shinyjs::extendShinyjs(text = jsRefreshCode, functions = "refresh"), 
    shinyalert::useShinyalert(),
    br(),
    fluidRow( uiOutput("boxes")),br(),
    fluidRow(column(width = 6,uiOutput("plot")),
             column(width = 6,uiOutput("plot_area"))),
    fluidRow(column(width = 10, offset = 1,uiOutput("plot_line")))
    
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)

#icon("credit-card")
#icon("venus-mars")
#icon("dollar")
shinyjs::useShinyjs()
shinyjs::extendShinyjs(text = jsRefreshCode, functions = "refresh")
shinyalert::useShinyalert(
  