# Total -------------------------------------------------------------------

Gender_total <- Customer%>% 
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
    title = "Total de clientes",
    subtitle = "Por Gênero"
  )

Gender_total

Produto <- prop.table(table(Customer$NumOfProducts))*100
Membro <- prop.table(table(Customer$IsActiveMember))*100
Reclama <- prop.table(table(Customer$Complain))*100
Cartao <- prop.table(table(Customer$HasCrCard))*100
Tempo_contrato <- sort(prop.table(table(Customer$Tenure))*100) #selecionar o ranking com mais valores

  Produto;Membro;Reclama;Cartao;Tempo_contrato

  ggplot(Customer, aes(x=Age))+
  geom_histogram(
   # binwidth = 5,
    color = "white" )+
    labs(
      x = "Idades",
      y = "Número de Clientes",
      color = " ",
      title = "Clientes por idade",
      # subtitle = "Receita vs Orçamento"
    )

  
hist(Customer$Age)
nrow(filter(Customer, Age > 35 & Age <55))/nrow(Customer)
mean(Customer$EstimatedSalary); 
mean(Customer$CreditScore); 
mean(Customerv$`Point Earned`)