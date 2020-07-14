### Script Tarea 2
# Ignacio Becker Bozo
# Herramientas para la Investigación Social Cuantitativa: Ciencia Abierta y Software Libre

# Carga paquetes(e instala si no) ----
install.packages(c("plotly","summarytools", "pacman", "dplyr", "readxl", "tidyverse", "haven", "car", "sjmisc", "sjlabelled", "stargazer"))

# abre todos de manera simultánea
x <- c("plotly","summarytools", "pacman", "dplyr", "readxl", "tidyverse", "haven", "car", "sjmisc", "sjlabelled", "stargazer")
lapply(x, require, character.only = TRUE)



# Definición analítica ----

### Posesión de contrato por género, macrozona, edad y nivel educativo
### Tipo de contrato por género, tramo etario y rama

# ---- EXTRA: Gráficos resultados tipo contrato ---- 
## Me faltan aun.



ggplotly(g1) #interactivo

# ---- Varios no revisar ----
# Guardar en github
saveRDS(ene, "/cloud/project/Datos/IntermediateData/proc_ene.rds")

# Para abrir
ene <- readRDS(file = "/cloud/project/Datos/IntermediateData/proc_ene.rds")

ene <- 
# Stock trabajadorxs

# Stock

ene <- mutate(ene, d = car::recode(ene$cae_especifico, 
                                   "8:9=1; else = 0"))
ene$d <- factor(ene$d, labels = c("NO D", "D"))
table(ene$d)

d


ene$d <- cae_especifico>=8&cae_especifico<=9
ene$o <- cae_especifico>=1 & cae_especifico<=7
ene$fdt <- cae_especifico>=1 & cae_especifico<=9


# Ponderar base
## Primero cargar paquete muestras complejas
install.packages("survey")

library(survey)

enep <- svydesign(data = ene, id=~1, weights = ~fact_cal)

## Ocupadxs (categórica)

table(ene$cae)
class(ene$cae)
ene$cae <- as.numeric(ene$cae)

ene <- mutate(ene, cae = car::recode(ene$cae, 
                                     "1:7=1; else = 0"))

#Convertir a factor para poner etiquetas
ene$cae <- factor(ene$cae, labels= c("No ocupadx", "Ocupadx"))

table(ene$cae)

