
# carga paquetes
install.packages(c("readxl", "tidyverse", "haven", "car"))

# abre todos de manera simultánea
x <- c("readxl", "tidyverse", "haven", "car")
lapply(x, require, character.only = TRUE)

# abre bbdd en .dta, trimestre MAM 2019

ene <- read_dta('http://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/bbdd/2019/formato-stata/ene-2019-04.dta?sfvrsn=599190e8_6&download=true', encoding = NULL, col_select = NULL, skip = 0,
                n_max = Inf, .name_repair = "unique")
d <- ene$cae_especifico>=8 & ene$cae_especifico<=9

fdt <- ene$cae_especifico>=1 & ene$cae_especifico<=9

# seleccionar variables de interés para generar stock, en base a INE
    ## filtrar edad (15 a 29 años)
    ## variables de empleo (cae_especifico, activ, r_p_rev4cl_caenes, ocup_form)
    ## variables sociodemográficas (sexo, tramo_edad, region, cine)

