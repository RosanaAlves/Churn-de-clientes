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
