library(dplyr)
library(tidyverse)
library(patchwork)

dados <- readr::read_csv("Data-Raw/Customer-Churn-Records.csv")
pais <- unique(dados$Geography)[1]
ndados <- dados %>%filter(Geography == pais & Exited ==1 )

salario_med <- round(mean(dados$EstimatedSalary))
creditScore_med <- round(mean(dados$CreditScore))
pointEarned_med <- round(mean(dados$`Point Earned`))


gggender <- ndados%>% 
  count(Gender) %>%
  slice_max(order_by = n, n = 10) %>% 
  ggplot() +
  geom_col(aes(x = Gender, y = n, fill = Gender), show.legend = FALSE) +
  geom_label(aes(x = Gender, y = n/2, label = n)) +
  coord_flip()+
  labs(
    y = "Total Customer Churn", 
    x = "Gender",
    color = "Lucro ($)",
    title = "Churn by Gender",
     )

ggAge <- ggplot(ndados, aes(x = Age)) +
  geom_histogram(color = "white", fill = "lightblue") +
  scale_x_continuous(breaks = seq(from = 18,to = 80, by = 10), limits = c(18,80)) +
  xlab("Age") + 
  ylab("Frequency")

ggprodut <- ndados%>% 
  count(`Card Type`) %>%
  ggplot() +
  geom_col(aes(x = `Card Type`, y = n, fill = `Card Type`), show.legend = FALSE) +
  geom_label(aes(x = `Card Type`, y = n/2, label = n)) +
  # coord_flip()+
  labs(
    y = "Frequency",
    x = "Card Type",
    color = "Lucro ($)",
    title = "Card Type",
  )

ggAge+
gggender
ggprodut


IsActiveMember <- count(filter(dados, IsActiveMember =="1"))
has_card <- count(filter(dados, HasCrCard == "1"))
Complain <- count(filter(dados, Complain == "1"))
length(unique(dados$CustomerId))

