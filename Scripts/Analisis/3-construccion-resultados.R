# Carga base de datos
ene <- readRDS(file="/cloud/project/Datos/DatosIntermedios/ene-editada.rds")

# ---- 1. ANÁLISIS ESTADÍSTICO DESCRIPTIVO ----
### Posesión de contrato
# Por género
tabla1.1 <- ctable(ene$p_con, ene$sexo, prop = "c",
       weights = ene$fact_cal)

# Por macrozona
tabla1.2 <- ctable(ene$p_con, ene$macroz, prop = "c",
       weights = ene$fact_cal)

# Grafico 1: 
g1 <- ene %>%
  ggplot()+
  geom_bar(mapping = aes(x=p_con, y = (..count..)/sum(..count..), fill = factor(sexo), weight=fact_cal),
           position = "dodge") + # Probar sacando "position"
  scale_y_continuous(labels=scales::percent, limits = c(0,0.3)) +
  xlab("Posesión contrato") +
  scale_fill_manual("Género",
                    values = c("#E41A1C", "#377EB8"),
                    labels = c("Hombre", "Mujer")) +
  ylab("Porcentaje")+
  facet_wrap(~macroz)
g1
# Por tramo etario
tabla1.3 <- ctable(ene$p_con, ene$tramo_etario, prop = "c",
       weights = ene$fact_cal)

# Por nivel educativo
tabla1.4 <- ctable(ene$p_con, ene$cine, prop = "c",
       weights = ene$fact_cal)

### TIPO DE CONTRATO, entre quienes tienen
## Por sexo, columna
tabla2.1 <- ctable(ene$t_con, ene$sexo, prop = "c",
       weights = ene$fact_cal, rows=factor(ene$p_con==1))

## Por tramo etario
tabla2.2 <- ctable(ene$t_con, ene$tramo_etario, prop = "c",
       weights = ene$fact_cal, rows=factor(ene$p_con==1))

## Por rama
tabla2.3 <- ctable(ene$t_con, ene$rama, prop = "c",
       weights = ene$fact_cal, rows=factor(ene$p_con==1))

# Grafico 2: 
g2 <- ene %>%
  ggplot()+
  geom_bar(mapping = aes(x=t_con, y = (..count..)/sum(..count..), fill = factor(sexo)),
           position = "dodge") + # Probar sacando "position"
  scale_y_continuous(labels=scales::percent) +
  xlab("Tipo de contrato") +
  scale_fill_manual("Género",
                    values = c("#E41A1C", "#377EB8"),
                    labels = c("Hombre", "Mujer")) +
  ylab("Porcentaje")+
  facet_wrap(~rama, scale="free_y")

# Imprimir figuras
ggsave(g1, filename = "/cloud/project/Salidas/Figura1.png",
       dpi = 350, width = 6, height = 4)
ggsave(g2, filename = "/cloud/project/Salidas/Figura2.png",
       dpi = 350, width = 6, height = 4)

# ---- 3. COMPILAR RESULTADOS EN UN SÓLO OBJETO (LISTA) Y GUARDAR COMO ARCHIVO ----

resultados <- list(tabla1.1, tabla1.2, tabla1.3, g1,tabla1.4,
                   tabla2.1, tabla2.2, tabla2.3,g2)

saveRDS(resultados, file = "/cloud/project/Datos/DatosAnalisis/resultados-reporte.rds")

# Limpiar entorno de trabajo
rm(list=ls())
