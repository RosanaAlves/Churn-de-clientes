dados <- readr::read_csv("Data-Raw/Customer-Churn-Records.csv")

dashbody <- dashboardBody(
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
              
              # box(
              #   title = "Inputs", status = "warning", solidHeader = TRUE,
              #   "Box content here", br(), "More box content",
              #   sliderInput("slider", "Slider input:", 1, 100, 50),
              #   textInput("text", "Text input:")
              # ),
             
            )
            )
    )
  
