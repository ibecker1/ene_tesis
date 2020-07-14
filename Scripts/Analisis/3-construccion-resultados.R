# Programar los resultados ----
### Posesión de contrato
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