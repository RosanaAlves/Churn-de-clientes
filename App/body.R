dashboardBody(
  tabItems(
    tabItem(tabName = "pagina1", 
            fluidRow(
              box(
                title = "Histogram", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("plot3", height = 250)
              ),
              
              box(
                title = "Inputs", status = "warning", solidHeader = TRUE,
                "Box content here", br(), "More box content",
                sliderInput("slider", "Slider input:", 1, 100, 50),
                textInput("text", "Text input:")
              ),
              # A static valueBox
              valueBox(10 * 2, "New Orders", icon = icon("credit-card")),
              
              # Dynamic valueBoxes
              valueBoxOutput("progressBox"),
              
              valueBoxOutput("approvalBox")
            )),
    tabItem(tabName = "pagina2", fluidRow(
      # Clicking this will increment the progress amount
      box(width = 4, actionButton("count", "Increment progress"))
    )))
))