
# Bibliotecas -------------------------------------------------------------

library(readr)
library(tidyverse)
library(patchwork) # Juntar gráficos na mesma visualização


# Carregando arquivo ------------------------------------------------------

Customer <- read_csv("Data-Raw/Customer-Churn-Records.csv")

cust_ex <- Customer%>%
  filter(Exited == '1')

total_pais <- as.numeric(table(Customer$Geography))

# Analise descritiva ------------------------------------------------------


# Proporção de clientes ---------------------------------------------------
 # representividade de saidas em relação ao total

repre_cust_ex <- (length(cust_ex$CustomerId)/length(Customer$CustomerId))*100
repre_cust_ex

total_pais_ex <- as.numeric(table(cust_ex$Geography)) # Quantidade de clientes por país
repre_cust_pais <- total_pais_ex/total_pais

p1 <- ggplot(cust_ex, aes(x = Geography, y = CreditScore, fill = Geography))+ 
        geom_boxplot(outlier.color = "red")+
        labs( title = "Representatividade de clientes que saíram por país")

p2 <- ggplot(Customer, aes(x = Geography, y = CreditScore, fill = Geography))+ 
          geom_boxplot(outlier.color = "red")+
          labs( title = "Representatividade do paises em relação ao total")
p1+p2
