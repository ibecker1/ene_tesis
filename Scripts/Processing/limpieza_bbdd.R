### Script Tarea 1
# Ignacio Becker Bozo
# Herramientas para la Investigación Social Cuantitativa: Ciencia Abierta y Software Libre

# carga paquetes
install.packages(c("pacman", "dplyr", "readxl", "tidyverse", "haven", "car", "sjmisc", "sjlabelled", "stargazer"))

# abre todos de manera simultánea
x <- c("pacman", "dplyr", "readxl", "tidyverse", "haven", "car", "sjmisc", "sjlabelled", "stargazer")
lapply(x, require, character.only = TRUE)

# abre bbdd en .dta, trimestre MAM 2019
ene <- read_dta('http://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/bbdd/2019/formato-stata/ene-2019-04.dta?sfvrsn=599190e8_6&download=true', encoding = NULL, col_select = NULL, skip = 0,
                n_max = Inf, .name_repair = "unique")

# Guardar en github
saveRDS(ene, "/cloud/project/Data/InputData/ene.rds")

# seleccionar variables de interés, en base a INE
    ## variables de empleo (cae_especifico, activ, r_p_rev4cl_caenes, ocup_form)
    ## variables sociodemográficas (sexo, tramo_edad, region, cine)
proc_ene <- ene %>% select(cae_especifico, #situación ocupacional desagregada
                           activ, #situación ocupacional recodificada
                           r_p_rev4cl_caenes, #rama de actividad
                           ocup_form, #situación de formalidad de la ocupación
                           sexo, #sexo registral
                           edad, #edad simple
                           region, #región de residencia
                           cine) #nivel educativo clasificado
# Para comprobar
names(proc_ene)

# Para guardar etiquetas
sjlabelled::get_label(proc_ene)

# Guardar en github
saveRDS(proc_ene, "/cloud/project/Data/IntermediateData/proc_ene.rds")

# Para abrir
readRDS(proc_ene, "/cloud/project/Data/IntermediateData/proc_ene.rds")
