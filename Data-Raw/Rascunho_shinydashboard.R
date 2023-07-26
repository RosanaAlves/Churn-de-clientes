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



nyse <- read.csv("data/nyse.csv", stringsAsFactors = FALSE)
nasdaq  <- read.csv("data/nasdaqcsv.csv", stringsAsFactors = FALSE)
constituents <- read.csv("data/constituents.csv", stringsAsFactors = FALSE)
other <- read.csv("data/other-listed.csv", stringsAsFactors = FALSE)
sticker <- rbind(nasdaq, nyse[,c(1,2)], constituents[, c(1,2)], other[,c(1,2)])
sticker <- sticker[duplicated(sticker$symbol),]
sticker$choices <- paste0(sticker$symbol, ": ",sticker$name)

ui <- dashboardPage(
  skin =c("midnight"),
  dashboardHeader(title = "Bank Customer Churn",
      titleWidth = 310),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Churn por País", tabName = "pagina1",icon = icon("map")),
    menuItem("Clientes", tabName = "pagina2", icon = icon("user"))
  )
),
dashboardBody(
    fluidRow(
    box(
      title = "Histograma",
      status = "primary",
      solidHeader = TRUE,
      collapsible = TRUE,
      
    )
  ),
  
  fluidRow(
    box(
      title = "Inputs",
      status = "warning",
      solidHeader = TRUE,
    )
  )
),tabItems(
  tabItem(tabName = "pagina1", ),
  tabItem(tabName = "pagina2", )
)
)




server <- function(input, output, session) {
  dados <- readr::read_csv("Data-Raw/Customer-Churn-Records.csv")
  output$res <- renderText({
    req(input$sidebarItemExpanded)
    paste("Expanded menuItem:", input$sidebarItemExpanded)
  })
}


shinyApp(ui, server)



selectInput(
  inputId = "variavel",
  label = "Selecione uma variável",
  choices = names(mtcars)
),
plotOutput(outputId = "histograma")
)
#icon("credit-card")
#icon("venus-mars")
#icon("dollar")
