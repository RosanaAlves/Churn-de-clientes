require(quantmod)
library(readr)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(shinyWidgets)
library(shinycssloaders)# carregar uma animação
#shiny::includeMarkdown()

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
    tabItems(
    tabItem(tabName = "pagina1", ),
    tabItem(tabName = "pagina2", )
  )
)
)

server <- function(input, output, session) {
  dados <- readr::read_csv("Data-Raw/Customer-Churn-Records.csv")
  output$res <- renderText({
    req(input$sidebarItemExpanded)
    paste("Expanded menuItem:", input$sidebarItemExpanded)
  })
}

shinyApp(ui,server)
