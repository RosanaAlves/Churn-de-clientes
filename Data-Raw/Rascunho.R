Customer%>% 
  count(Gender) %>%
  # filter(!is.na(direcao)) %>% 
  slice_max(order_by = n, n = 10) %>% 
  # mutate(direcao = forcats::fct_reorder(direcao, n)) %>% 
  ggplot() +
  geom_col(aes(x = Gender, y = n, fill = Gender), show.legend = FALSE) +
  geom_label(aes(x = Gender, y = n/2, label = n)) +
  coord_flip()


Customer%>% 
  count(Gender) %>%
  slice_max(order_by = n, n = 10) %>% 
  ggplot() +
  geom_col(aes(x = Gender, y = n, fill = Gender), show.legend = FALSE) +
  geom_label(aes(x = Gender, y = n/2, label = n)) +
  coord_flip()+
  labs(
    y = "Número de clientes",
    x = "Gênero",
    color = "Lucro ($)",
    title = "Gráfico de barras",
    subtitle = "Clientes por Gênero"
  )


# Exemplos de App ---------------------------------------------------------


runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer
