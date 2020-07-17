
## Carga paquetes

if (!require("pacman")) {
  install.packages("pacman")
}
pacman::p_load(haven,
               dplyr,
               car,
               summarytools,
               ggplot2)

# Cargar base de datos ----
# abre bbdd en .dta, trimestre MAM 2019 desde repositorio
ene0 <- readRDS(file= "/cloud/project/Datos/DatosBrutos/ene-mam19.rds")


# Seleccionar variables ----
# seleccionar variables de interés, en base a INE
## variables de empleo (cae_especifico, r_p_rev4cl_caenes, tipo y posesión contrato)
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

# Se eliminan NA para facilitar análisis
ene <-na.omit(ene)

# Se guarda df filtrada
saveRDS(ene, "/cloud/project/Datos/DatosIntermedios/ene-filtro.rds")

# Limpiar entorno de trabajo
rm(list=ls())
