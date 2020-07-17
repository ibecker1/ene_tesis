# Carga base de datos
ene <- readRDS(file="/cloud/project/Datos/DatosIntermedios/ene-editada.rds")

### Debido a errores de formato cuando hago render en rmd con "ctable", los agregaré directamente en el escrito "reporte_reproducible.Rmd". 
### Los cálculos serán los siguientes:
# 1.1 posesión contrato por sexo
# 1.2 posesión contrato por tramo etario
# 1.3 posesión contrato por nivel educativo
# 2.1 tipo contrato por sexo

### Acá están los gráficos tanto por posesión de contrato (por sexo y macrozona) como del tipo de éste (también por sexo, y por rama). 
# ---- 1. GRÁFICOS ----
# Grafico 1: 
g1 <- ene %>%
  ggplot()+
  geom_bar(mapping = aes(x=p_con, y = (..count..)/sum(..count..), fill = factor(sexo), weight=fact_cal),
           position = "dodge") +
  geom_text(y)+
  scale_y_continuous(labels=scales::percent, limits = c(0,0.3)) +
  xlab("Posesión contrato") +
  scale_fill_manual("Género",
                    values = c("#E41A1C", "#377EB8"),
                    labels = c("Hombre", "Mujer")) +
  ylab("Porcentaje")+
  facet_wrap(~macroz)
g1

# Grafico 2: 
g2 <- ene %>%
  ggplot()+
  geom_bar(mapping = aes(x=t_con, y = (..count..)/sum(..count..), fill = factor(sexo), weight=fact_cal),
           position = "dodge") + 
  scale_y_continuous(labels=scales::percent, limits = c(0,0.3)) +
  xlab("Tipo de contrato") +
  scale_fill_manual("Género",
                    values = c("#E41A1C", "#377EB8"),
                    labels = c("Hombre", "Mujer")) +
  ylab("Porcentaje")+
  facet_wrap(~rama)

# Imprimir figuras
ggsave(g1, filename = "/cloud/project/Salidas/Figura1.png",
       dpi = 350, width = 6, height = 4)
ggsave(g2, filename = "/cloud/project/Salidas/Figura2.png",
       dpi = 350, width = 6, height = 4)

# ---- 2. COMPILAR RESULTADOS EN UN SÓLO OBJETO (LISTA) Y GUARDAR COMO ARCHIVO ----

resultados <- list(g1,g2)

saveRDS(resultados, file = "/cloud/project/Datos/DatosAnalisis/resultados-reporte.rds")

# Limpiar entorno de trabajo
rm(list=ls())
