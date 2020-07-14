# Instalación de paquetes
## Instalar paquetes para el espacio de trabajo
if (!require("pacman")) {
  install.packages("pacman")
}
pacman::p_load(haven,
               dplyr,
               car,
               summarytools,
               ggplot2)

# Ejecuta código 1: lectura base datos
# Expulsa archivo de datos para editar
source("/cloud/project/Scripts/Procesamiento/1-lectura-base.R")

# Ejecuta código 2: preparación de datos
# Carga datos para editar, expulsa archivo de datos editados
source("/cloud/project/Scripts/Procesamiento/2-preparacion-datos.R")

# Ejecuta código 3: construcción de resultados
# Carga datos editados, expulsa lista de resultados como archivo
source("/cloud/project/Scripts/Analisis/3-construccion-resultados.R")

# Ejecuta código 4: construcción de reporte reproducible
# En base a lista de resultados, crea archivo de reporte en PDF
rmarkdown::render('reporte_reproducible.Rmd')

# Limpiar entorno de trabajo
rm(list=ls())