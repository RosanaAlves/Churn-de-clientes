#require(quantmod)
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
                  titleWidth = 230),
        dashboardSidebar(  
          sidebarMenu(
            menuItem("Churn by country", tabName = "pagina1",icon = icon("map"))),
        dashboardBody(
                      tabItems(
              tabItem(tabName = "pagina1", 
                      fluidRow(
                        valueBox(round(mean(dados$CreditScore)), "Mean Credit Score", icon = icon("credit-card")),
                        valueBox(round(mean(dados$CreditScore)), "Mean Credit Score", icon = icon("credit-card")),
                        valueBox(round(mean(dados$CreditScore)), "Mean Credit Score", icon = icon("credit-card"))),
                      fluidRow( 
                        box(width = 4,
                            title = "Barplot Gender", solidHeader = TRUE,
                            plotOutput("plot1")
                        )),
                      
                    
              )
            )
          )
        )
        


server <- function(input, output, session) {
  # dados <- readr::read_csv("Data-Raw/Customer-Churn-Records.csv")
  # output$res <- renderText({
  #   req(input$sidebarItemExpanded)
  #   paste("Expanded menuItem:", input$sidebarItemExpanded)
  # })
}

shinyApp(ui,server)
