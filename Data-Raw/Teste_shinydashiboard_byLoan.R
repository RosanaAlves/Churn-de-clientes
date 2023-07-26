require(quantmod)
library(readr)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(shinyWidgets)
library(shinycssloaders)# carregar uma animação
shiny::includeMarkdown()


nyse <- read.csv("data/nyse.csv", stringsAsFactors = FALSE)
nasdaq  <- read.csv("data/nasdaqcsv.csv", stringsAsFactors = FALSE)
constituents <- read.csv("data/constituents.csv", stringsAsFactors = FALSE)
other <- read.csv("data/other-listed.csv", stringsAsFactors = FALSE)
sticker <- rbind(nasdaq, nyse[,c(1,2)], constituents[, c(1,2)], other[,c(1,2)])
sticker <- sticker[duplicated(sticker$symbol),]
sticker$choices <- paste0(sticker$symbol, ": ",sticker$name)

ui = dashboardPage(
  skin = "midnight",
  header = source("/home/rosana/Documents/Meus_Projetos/shiny/Churn Clientes/Churn-de-clientes/Data-Raw/header.R", local = TRUE)$value,
  sidebar = source("/home/rosana/Documents/Meus_Projetos/shiny/Churn Clientes/Churn-de-clientes/Data-Raw/sidebar.R", local = TRUE)$value,
  body = dashboardBody(
    shinyjs::useShinyjs(),
    shinyjs::extendShinyjs(text = jsRefreshCode, functions = "refresh"), 
    shinyalert::useShinyalert(),
    br(),
    fluidRow( uiOutput("boxes")),br(),
    fluidRow(column(width = 6,uiOutput("plot")),
             column(width = 6,uiOutput("plot_area"))),
    fluidRow(column(width = 10, offset = 1,uiOutput("plot_line")))
    
  ),
  controlbar = dashboardControlbar(
    tagList(
      fluidRow(column(width = 8, offset = 2,br(),
                      actionButton("refresh","Refresh",icon("refresh", lib = "font-awesome"), 
                                   width = "100%",
                                   style = "color: #fff; background-color: #DD6B55; border-color: #DD6B55"))),
      helpText("This is refresh button, it will help you to reset your application 
               back to default.", 
               style = "padding-left : 10px; padding-right : 10px;")
    )
  ),
  footer = dashboardFooter(left = HTML("<span style='font-size:12px;'>
  <a href='https://www.loankimrobinson.com'>Author: Loan Kim Robinson </a></span><br>
  <span style='font-size:12px;'>Email: loankimrobinson@gmail.com</span><br>"),
                           right = "San Diego, Feb 7th 2019")
)   
