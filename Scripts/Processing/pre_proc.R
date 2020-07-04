### Script Tarea 2
# Ignacio Becker Bozo
# Herramientas para la Investigación Social Cuantitativa: Ciencia Abierta y Software Libre

# Carga paquetes(e instala si no) ----
install.packages(c("plotly","summarytools", "pacman", "dplyr", "readxl", "tidyverse", "haven", "car", "sjmisc", "sjlabelled", "stargazer"))

# abre todos de manera simultánea
x <- c("plotly","summarytools", "pacman", "dplyr", "readxl", "tidyverse", "haven", "car", "sjmisc", "sjlabelled", "stargazer")
lapply(x, require, character.only = TRUE)

# Cargar base de datos ----
# abre bbdd en .dta, trimestre MAM 2019
ene0 <- read_dta('http://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/bbdd/2019/formato-stata/ene-2019-04.dta?sfvrsn=599190e8_6&download=true', encoding = NULL, col_select = NULL, skip = 0,
                 n_max = Inf, .name_repair = "unique")

# Guardar en github
#saveRDS(ene, "/cloud/project/Data/InputData/ene.rds")

# Seleccionar variables ----
# seleccionar variables de interés, en base a INE
## variables de empleo (cae_especifico, activ, r_p_rev4cl_caenes, ocup_form)
## variables sociodemográficas (sexo, tramo_edad, region, cine)
ene <- select(ene0, cae = cae_especifico, #situación ocupacional desagregada
              rama = r_p_rev4cl_caenes, #rama de actividad
              sexo, #sexo registral
              edad, #edad simple
              region, #región de residencia
              p_con = b8, #posesión contrato
              t_con = b9, #tipo contrato
              cine, #nivel educativo clasificado
              fact_cal) #ponderador

# Para comprobar
names(ene)

# Para guardar etiquetas
sjlabelled::get_label(ene)

# Se filtra df para jóvenes ocupadxs
ene <- filter(ene, (edad>=15&edad<=29)&(cae>=1&cae<=7))

# Recodificar variables ----
## Rama
# Recodificar en tres sectores por rangos: Primario, Secundario, Terciario
table(ene$rama)
class(ene$rama)

ene$rama <- as.numeric(ene$rama)

#Especificar paquete desde el cual queremos ejecutar la función 'recode' 
#para poder recodificar según tramos
ene <- mutate(ene, rama = car::recode(ene$rama, "1:1 = 1;2:6 = 2;
                                            7:21 =3; else = NA"))
table(ene$rama)

#Convertir a factor para poner etiquetas
ene$rama <- factor(ene$rama, labels= c("Primario", "Secundario", "Terciario"))
table(ene$rama)

## Sexo (nominal)

table(ene$sexo) #1 = hombre, 2 = mujer
class(ene$sexo)

ene$sexo <- factor(ene$sexo, labels= c("Hombre", "Mujer"))

table(ene$sexo)

# Edad (intervalar)

#Recodificar en números asociados a tramo etarios jóvenes. 
summary(ene$edad)
class(ene$edad)
ene$edad <- as.numeric(ene$edad)

#Especificar paquete desde el cual queremos ejecutar la función 'recode' 
#para poder recodificar según tramos
ene <- mutate(ene, tramo_etario = car::recode(ene$edad, "15:19 = 1;20:24 = 2;
                                            25:29 =3; else = NA"))
table(ene$tramo_etario)

#Convertir a factor para poner etiquetas
ene$tramo_etario <- factor(ene$tramo_etario, labels= c("15-19", "20-24", "25-29"))
table(ene$tramo_etario)

# Region
# Recodificar 16 regiones a 4 macrozonas: 
# 1. Norte (XV, I a IV)  / 2. Centro (V a VII y XIII) / 3. Sur (VIII a X, XIV y XVI) / 4. Austral (XI a XII)

class(ene$region)
ene$region <- as.numeric(ene$region)

#Especificar paquete desde el cual queremos ejecutar la función 'recode' 
#para poder recodificar según tramos
ene <- mutate(ene, macroz = car::recode(ene$region, "1:4 = 1;5:7 = 2;
                                            8:10 =3; 11:12 = 4; 13=2; 14=3; 15=1; 16=3"))
table(ene$macroz)

#Convertir a factor para poner etiquetas
ene$macroz <- factor(ene$macroz, labels= c("Norte", "Centro", "Sur", "Austral"))
table(ene$macroz)

# Posesión contrato (categórica)
table(ene$p_con)
class(ene$p_con)
ene$p_con <- as.numeric(ene$p_con)

ene <- mutate(ene, p_con = car::recode(ene$p_con, 
                                       "1=1; 2 = 0"))
#Convertir a factor para poner etiquetas
ene$p_con <- factor(ene$p_con, labels= c("No tiene contrato", "Sí tiene contrato"))
table(ene$p_con)

# Tipo contrato (Nominal)
table(ene$t_con) #1 = definido, 2 = indefinido
class(ene$t_con)

ene$t_con <- factor(ene$t_con, labels= c("Definido", "Indefinido"))

table(ene$t_con)

# Nivel educativo
# Variable de 9 categorías, recodificar en 4.
# 1. Sin estudios / 2. Secundaria e inferior / 3. Técnica / 4. Universitaria o superior

table(ene$cine)
class(ene$cine)
ene$cine <- as.numeric(ene$cine)

#Especificar paquete desde el cual queremos ejecutar la función 'recode' 
#para poder recodificar según tramos
ene <- mutate(ene, cine = car::recode(ene$cine, "1:5 = 1; 6 = 2; 7:9 = 3; else = NA"))
table(ene$cine)

#Convertir a factor para poner etiquetas
ene$cine <- factor(ene$cine, labels= c("Secundaria e inferior", "Técnica", "Universitaria o superior"))
table(ene$cine)

# Para comprobar
dfSummary(ene, style = "grid")

# Definición analítica ----

### Posesión de contrato por género, macrozona, edad y nivel educativo
### Tipo de contrato por género, tramo etario y rama

# Programar los resultados ----
# Antes, se eliminan los casos perdidos con na.omit. Se ven cuántos son, luego se eliminan.
dim(ene)
dim
#contamos el número de NA 
sum(is.na(ene))

# los borramos
ene <-na.omit(ene)

dim(ene)

# CONSTRUIR RESULTADOS DE NIVEL POBLACIONAL
### POSESIÓN DE CONTRATO
# Por género
ctable(ene$p_con, ene$sexo, prop = "c",
       weights = ene$fact_cal)

# Por macrozona
ctable(ene$p_con, ene$macroz, prop = "c",
       weights = ene$fact_cal)

# Por tramo etario
ctable(ene$p_con, ene$tramo_etario, prop = "c",
       weights = ene$fact_cal)

# Por nivel educativo
ctable(ene$p_con, ene$cine, prop = "c",
       weights = ene$fact_cal)

### TIPO DE CONTRATO, entre quienes tienen
## Por sexo, columna
ctable(ene$t_con, ene$sexo, prop = "c",
       weights = ene$fact_cal, rows=factor(ene$p_con==1))

## Por tramo etario
ctable(ene$t_con, ene$tramo_etario, prop = "c",
       weights = ene$fact_cal, rows=factor(ene$p_con==1))

## Por rama
ctable(ene$t_con, ene$rama, prop = "c",
       weights = ene$fact_cal, rows=factor(ene$p_con==1))

# ---- EXTRA: Gráficos resultados tipo contrato ---- 
## Me faltan aun.

g1 <- ene %>%
ggplot()+
        geom_bar(mapping = aes(x=p_con, y = (..count..)/sum(..count..), fill = factor(sexo)),
                 position = "dodge") + # Probar sacando "position"
        scale_y_continuous(labels=scales::percent) +
        xlab("Posesión contrato") +
        scale_fill_manual("Género",
                          values = c("#E41A1C", "#377EB8"),
                          labels = c("Hombre", "Mujer")) +
        ylab("Porcentaje")+
        facet_wrap(~rama, scale="free_y")

ggplotly(g1) #interactivo

# ---- Varios no revisar ----
# Guardar en github
saveRDS(proc_ene, "/cloud/project/Data/IntermediateData/proc_ene.rds")

# Para abrir
ene <- readRDS(file = "/cloud/project/Datos/IntermediateData/proc_ene.rds")

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

