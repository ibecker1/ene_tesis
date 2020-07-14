#######AGREGAR IF PARA BBDD
### Y PACKETES SEGÚN CMC

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

# Se eliminan NA para facilitar análisis
ene <-na.omit(ene)
