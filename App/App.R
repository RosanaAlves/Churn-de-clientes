library(tidyverse)
library(dplyr)
library(readr)
library(shiny)
library(shinydashboard)

link <- "https://raw.githubusercontent.com/RosanaAlves/Churn-de-clientes/main/Data-Raw/Customer-Churn-Records.csv"

dados <- readr::read_csv(link)
pais <- c(unique(dados$Geography))
  
# Selecionar a base coom clientes que sairam ou nao


ui <- dashboardPage(
         dashboardHeader(title = "Bank Customer",
                  titleWidth = 230),
        dashboardSidebar(  
          sidebarMenu(
            menuItem("Customer by country", tabName = "pagina1",icon = icon("map"))),
          selectInput(
            inputId = "pais_A",
            label = "Country",
            choices = pais )),
        dashboardBody(
                      tabItems(
              tabItem(tabName = "pagina1", 
                      fluidRow( valueBoxOutput('Exited'),
                                valueBoxOutput('Salary'),
                                valueBoxOutput('Score'),
                                valueBoxOutput('Earned'),
                                valueBoxOutput('Complain'),
                                valueBoxOutput('ComplainExited')),
                      fluidRow( 
                        box(width = 12,
                            title = "Age", solidHeader = TRUE,
                            plotOutput(outputId = "Age")),
                        box(width = 6,
                            title = "Credit Card", solidHeader = TRUE,
                            plotOutput(outputId = "Card")),
                        box(width = 6,
                            title = "Gender", solidHeader = TRUE,
                            plotOutput(outputId = 'Gender'))
                  )
                )
              )
            )
          )
        
        


server <- function(input, output, session) {
  
  output$Exited <- renderValueBox({
    valueBox((dados %>%
                filter(Geography == input$pais_A & Exited == "1") %>%
                count(Exited))[2],icon = icon("times"),"Churn", color = "red")
  })
  output$Salary <- renderValueBox({
    valueBox(round(dados %>%
                     filter(Geography == input$pais_A) %>%
                     select(EstimatedSalary) %>% summarise(mean(EstimatedSalary))
    ),icon = icon("dollar"),"Average Salary", color = "purple")
  })
  output$Score <- renderValueBox({
    valueBox(round(dados %>%
                     filter(Geography == input$pais_A) %>%
                     select(CreditScore) %>% summarise(mean(CreditScore))
    ),icon = icon("credit-card"),"Average Credit Score",  color = "blue")
  })
  output$Earned <- renderValueBox({
    valueBox( round(dados %>%
                      filter(Geography == input$pais_A) %>%
                      select(`Point Earned`) %>% summarise(mean(`Point Earned`))
    ),icon = icon("star"),"Point Earned Average",  color = "green")
  })
  
  output$Complain <- renderValueBox({
    valueBox((dados %>%
                filter(Geography == input$pais_A & Complain == '1') %>%
                count(Complain))[2], icon = icon("volume-up"), "Count Complain",  color = "yellow")
  })
  output$ComplainExited <- renderValueBox({
    valueBox((dados %>%
                filter(Geography == input$pais_A & Complain == '1' & Exited=="1") %>%
                count(Complain))[2], icon = icon("volume-up"), "Count Complain and Exited",  color = "yellow")
  })
  
  # Gráficos
  output$Age <- renderPlot({
      dados %>%
      filter(Geography == input$pais_A) %>% 
      ggplot( ) +
      geom_histogram(aes(x = Age),color = "white", fill = "lightblue") +
      scale_x_continuous(breaks = seq(from = 20,to = 80, by = 10), limits = c(18,80)) +
      xlab("Age") + 
      ylab("Frequency")
    
  })
  
  output$Card <- renderPlot({
    dados %>%
      filter(Geography == input$pais_A) %>%
      count(`Card Type`) %>%
      ggplot( ) +
      geom_col(aes(x = `Card Type`, y = n, fill = `Card Type`), show.legend = FALSE) +
      geom_label(aes(x = `Card Type`, y = n/2, label = n)) +
      labs(
        y = "Frequency",
        x = "Card Type",
        color = "Card Type)",
        title = "Card Type")
    
  })
  output$Gender <- renderPlot({
      dados %>%
      filter(Geography == input$pais_A) %>%
      count(Gender) %>%
      ggplot( ) +
      geom_col(aes(x = Gender, y = n, fill = Gender), show.legend = FALSE) +
      geom_label(aes(x = Gender, y = n/2, label = n)) +
      labs(
        y = "Frequency",
        x = "Gender",
        color = "Gender",
        title = "Gender")
    
  })
  
}

shinyApp(ui,server)
