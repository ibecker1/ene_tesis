# Carga bbdd filtrada para jóvenes asalariadxs
ene <- readRDS(file="/cloud/project/Datos/DatosIntermedios/ene-filtro.rds")

# Recodificar variables ----
## Rama
# Recodificar en tres sectores por rangos: Primario, Secundario, Terciario
ene$rama <- as.numeric(ene$rama)
ene <- mutate(ene, rama = car::recode(ene$rama, "1:1 = 1;2:6 = 2;
                                            7:21 =3; else = NA"))
ene$rama <- factor(ene$rama, labels= c("Primario", "Secundario", "Terciario"))

## Sexo (nominal)
ene$sexo <- factor(ene$sexo, labels= c("Hombre", "Mujer"))

# Edad (intervalar)
#Recodificar en números asociados a tramo etarios jóvenes. 
ene$edad <- as.numeric(ene$edad)
ene <- mutate(ene, tramo_etario = car::recode(ene$edad, "15:19 = 1;20:24 = 2;
                                            25:29 =3; else = NA"))
ene$tramo_etario <- factor(ene$tramo_etario, labels= c("15-19", "20-24", "25-29"))

# Region
# Recodificar 16 regiones a 4 macrozonas: 
# 1. Norte (XV, I a IV)  / 2. Centro (V a VII y XIII) / 3. Sur (VIII a X, XIV y XVI) / 4. Austral (XI a XII)
ene$region <- as.numeric(ene$region)
ene <- mutate(ene, macroz = car::recode(ene$region, "1:4 = 1;5:7 = 2;
                                            8:10 =3; 11:12 = 4; 13=2; 14=3; 15=1; 16=3"))
ene$macroz <- factor(ene$macroz, labels= c("Norte", "Centro", "Sur", "Austral"))

# Posesión contrato (categórica)
ene$p_con <- as.numeric(ene$p_con)
ene <- mutate(ene, p_con = car::recode(ene$p_con, 
                                       "1=1; 2 = 0"))
ene$p_con <- factor(ene$p_con, labels= c("No tiene contrato", "Sí tiene contrato"))

# Tipo contrato (Nominal)
ene$t_con <- factor(ene$t_con, labels= c("Definido", "Indefinido"))

# Nivel educativo
# Variable de 9 categorías, recodificar en 4.
# 1. Sin estudios / 2. Secundaria e inferior / 3. Técnica / 4. Universitaria o superior
ene$cine <- as.numeric(ene$cine)
ene <- mutate(ene, cine = car::recode(ene$cine, "1:5 = 1; 6 = 2; 7:9 = 3; else = NA"))
ene$cine <- factor(ene$cine, labels= c("Secundaria e inferior", "Técnica", "Universitaria o superior"))
table(ene$cine)

# Para comprobar
dfSummary(ene, style = "grid")

# Guardar base en formato RDS, con bases listas para análisis
saveRDS(ene, file = "/cloud/project/Datos/DatosIntermedios/ene-editada.rds")

# Limpiar entorno de trabajo
rm(list=ls())