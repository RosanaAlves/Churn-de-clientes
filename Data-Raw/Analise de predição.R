library(readr)
library(tidyverse)
library(patchwork)


# Leitura da base de dados
base  <- read_csv("Data-Raw/Customer-Churn-Records.csv")

# Verificação das variaveis

summary(base)

# retirando as variaveis de ID

base <- base[,4:18]# Os dados que ficaram fazen sentido para a análise

# Preparando a base para treinar um modelo --------------------------------
## Transformação de dados categóricos

base$Geography <- factor(base$Geography, levels = c("Spain", "Germany","France"), labels = c(1,2,3))
base$Gender <- factor(base$Gender, levels = c("Male","Female"), labels = c(0,1))
base$`Card Type` <- factor(base$`Card Type`, levels = c("DIAMOND","GOLD","PLATINUM","SILVER"), labels = c(1,2,3,4))

categ <- c("Geography", "Gender", "Card Type")
data1 <- base %>% select(categ)
data2 <- base %>% select(-categ)
## Escalonamento

data2[, 1:12] = scale(data2[, 1:12])

base <- data.frame(data1, data2)

# -------------------------------------------------------------------------

# Divis?o entre treinamento e teste
library(caTools)

set.seed(1)
divisao = sample.split(base$Exited, SplitRatio = 0.75)
base_treinamento = subset(base, divisao == TRUE)
base_teste = subset(base, divisao == FALSE)

classificador = glm(formula = Exited ~Age+Complain+Point.Earned, family = gaussian , data = base_treinamento)
probabilidades = predict(classificador, type = 'response', newdata = base_teste[-12])
previsoes = ifelse(probabilidades > 0.5, 1, 0)
matriz_confusao = table(base_teste[, 12], previsoes)
library(caret)
confusionMatrix(matriz_confusao)

# ZeroR 
table(base_teste$Exited)
