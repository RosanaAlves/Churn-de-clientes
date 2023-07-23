
# Bibliotecas -------------------------------------------------------------

library(readr)
library(tidyverse)
library(patchwork) # Juntar gráficos na mesma visualização


# Carregando arquivo ------------------------------------------------------

Customer <- read_csv("Data-Raw/Customer-Churn-Records.csv")

cust_per <-  Customer%>%
  filter(Exited == '0')


cust_ex <- Customer%>%
  filter(Exited == '1')

total_pais <- as.numeric(table(Customer$Geography)) # Total de clientes por país
table(Customer$Geography)

## A França é o que tem mais representatividade

# Analise descritiva ------------------------------------------------------

# Proporção de clientes por País e CredScore ---------------------------------------------------
# representividade de saidas em relação ao total
# Saíram

repre_cust_ex <- (length(cust_ex$CustomerId)/length(Customer$CustomerId))*100
repre_cust_ex

repre_cust_per <- (length(cust_per$CustomerId)/length(Customer$CustomerId))*100
repre_cust_per


# Proporção de clientes que saíram por pais -------------------------------


prop.table(table(cust_ex$Geography))

# Do total de clientes que saíram 40 % são da França.

# representatividade de clientes que saíram por pais  --------------------------------

total_pais_ex <- as.numeric(table(cust_ex$Geography))
# Quantidade de clientes por país
prop.table(table(cust_ex$Geography))*100
repre_cust_pais <- total_pais_ex/total_pais*100
repre_cust_pais
prop.table(table(cust_ex$Geography))


## Dos clientes que saíram  16 % correspondem ao total de clientes presentes na França.


# Dos clientes 

# Graficos boxplot por país -----------------------------------------------
# Comparação entre o grupo que saiu, o que permaneceu e o total

p1 <- ggplot(cust_ex, aes(x = Geography, y = CreditScore, fill = Geography))+ 
        geom_boxplot(outlier.color = "red")+
        labs( title = "Representatividade de clientes que saíram por país")

p2 <- ggplot(cust_per, aes(x = Geography, y = CreditScore, fill = Geography))+ 
  geom_boxplot(outlier.color = "red")+
  labs( title = "Representatividade de clientes que permaneceram por país")


p3 <- ggplot(Customer, aes(x = Geography, y = CreditScore, fill = Geography))+ 
          geom_boxplot(outlier.color = "red")+
          labs( title = "Representatividade do paises em relação ao total")
p1+p2+p3

summary(cust_ex$CreditScore)
summary(cust_per$CreditScore)
summary(Customer$CreditScore)


# Clientes que saíram com baixo CreditScore  ------------------------------
# Considerei baixo os valores dentro do primeiro quartil que equivalem a 25% dos
# dados 

Credit_baixo <- cust_ex %>% # Clientes que saíram com Creditscore no q1
    filter(CreditScore < 578)

pairs(select_if(Credit_baixo,is.numeric))

summary(Credit_baixo)

p1 <- ggplot(Credit_baixo, aes(x = Geography, y = CreditScore, fill = Geography))+ 
  geom_boxplot(outlier.color = "red")+
  labs( title = "Representatividade de clientes que saíram por país e estao no q1 CredScore")
p1

Credit_B <- table(Credit_baixo$Geography)
repre_cred_ba_ex <- (length(Credit_baixo$CustomerId)/length(cust_ex$CustomerId))*100
repre_cred_ba_ex

table(Credit_baixo$Geography)/table(cust_ex$Geography)

# porcentagem de clientes que saíram com creditscore baixo por pais
# 25% dos clientes da França que saíram do banco possuem creditscore baixo


# Idade -------------------------------------------------------------------

par(mfrow = c(2,2))
hist(cust_ex$Age)
hist(cust_per$Age)
hist(Customer$Age)
summary(cust_ex$Age)

# Gênero ------------------------------------------------------------------

prop.table(table(cust_ex$Gender))
Gender_Total <- table(Customer$Gender)

 table(cust_ex$Gender)/table(Customer$Gender) # 25% dos clientes femininos saíram do banco
# Há mais clientes mulheres que sáiram do banco (55%), porém há mais homens no total geral.

cust_ex_fem <- cust_ex %>% 
                  filter(Gender == "Female")

p1 <- ggplot(cust_ex_fem, aes(x = Geography, y = CreditScore, fill = Geography))+ 
  geom_boxplot(outlier.color = "red")+
  labs( title = "Representatividade de clientes femininas que saíram por país")
p1

Geography_Ex_Fe <- table(cust_ex_fem$Geography)
Geography_Ex <- table(cust_ex$Geography)
Fem <- data.frame(Geography_Ex_Fe, Geography_Ex, Geography_Ex_Fe/Geography_Ex*100)

hist(cust_ex_fem$Age)
fem_idade <- cust_ex_fem %>% filter(Age>30)
hist(fem_idade$CreditScore)
barplot(table(fem_idade$`Card Type`))
table(fem_idade$Complain)
hist(fem_idade$Balance)
hist(Customer$Balance)


# Clientes que cancelaram -------------------------------------------------

Gender_ex <- cust_ex%>% 
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
    title = "Clientes que saíram",
    subtitle = "Por Gênero"
  )

hist(cust_ex$Balance)
hist(cust_per$Balance)

hist(cust_ex$`Satisfaction Score`)
summary(cust_ex$`Satisfaction Score`)
summary(cust_ex$Age)
table(cust_ex$`Satisfaction Score`)
table(cust_ex$Complain)
barplot(table(cust_ex$`Card Type`))
hist(cust_ex$EstimatedSalary)
hist(cust_ex$`Point Earned`)
table(cust_ex$IsActiveMember)
table(cust_ex$NumOfProducts)
table(cust_ex$HasCrCard)
hist(cust_ex$Tenure)
sort(table(cust_ex$Tenure))

nrow(filter(cust_ex, Age > 35 & Age <55))
mean(cust_ex$EstimatedSalary); sd(cust_ex$EstimatedSalary)
mean(cust_ex$CreditScore); sd(cust_ex$CreditScore)
mean(cust_ex$`Point Earned`); sd(cust_ex$`Point Earned`)


# Clientes que permaneceram -----------------------------------------------

Gender_per <- cust_per%>% 
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
    title = "Clientes que permaneceram",
    subtitle = "Por Gênero"
  )
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

barplot(prop.table(table(Customer$Gender))*100)
prop.table(table(Customer$NumOfProducts == 1))*100
prop.table(table(Customer$IsActiveMember))*100
prop.table(table(Customer$Complain))*100
prop.table(table(Customer$HasCrCard))*100
sort(prop.table(table(Customer$Tenure))*100)

hist(Customer$Age)
nrow(filter(Customer, Age > 35 & Age <55))/nrow(Customer)
mean(Customer$EstimatedSalary); 
mean(Customer$CreditScore); 
mean(Customerv$`Point Earned`)

# Analisando German -------------------------------------------------------
Germany_Ex <- filter(cust_ex, Geography=="Germany")
barplot(prop.table(table(Germany_Ex$Gender))*100)
prop.table(table(Germany_Ex$NumOfProducts == 1))*100
prop.table(table(Germany_Ex$Complain))*100
prop.table(table(Germany_Ex$HasCrCard))*100
sort(prop.table(table(Germany_Ex$Tenure))*100)

hist(Germany_Ex$Age)
nrow(filter(Germany_Ex, Age > 35 & Age <55))/nrow(Germany_Ex)
mean(Germany_Ex$EstimatedSalary); 
mean(Germany_Ex$CreditScore); 
mean(Germany_Ex$`Point Earned`)

Gender_ex + Gender_per + Gender_total

