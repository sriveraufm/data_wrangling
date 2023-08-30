library(dplyr)
library(ggplot2)
library(plotly)

data <- read.csv("tabla_completa.csv")
data$UNIDAD <- gsub(pattern = '<f1>','n',data$UNIDAD)
ventas_por_mes <- data %>%
  group_by(MES) %>%
  summarise(VentasTotal = sum(Q))

ventas_por_cliente <- data %>%
  group_by(CLIENTE) %>%
  summarise(VentasTotal = sum(Q)) %>%
  top_n(n = 10, wt = VentasTotal)

#ventas por mes
ventas_plot <- plot_ly(ventas_por_mes, x = ~MES, y = ~VentasTotal, type = 'bar') %>%
  layout(title = "Tendencia de Ventas a lo largo del Tiempo", xaxis = list(title = "Mes"), yaxis = list(title = "Ventas"))

#ventas por clientes
clientes_plot <- plot_ly(ventas_por_cliente, labels = ~CLIENTE, values = ~VentasTotal, type = 'pie', textinfo = 'percent') %>%
  layout(title = "Distribución de Ventas por Clientes", showlegend = TRUE, legend = list(font = list(size = 8)))

empleados <- data %>%
  group_by(PILOTO) %>%
  summarize(total_entregas = sum(Q))
mean(empleados$total_entregas)

vehiculos <- data %>%
  group_by(UNIDAD) %>%
  summarize(total_entregas = sum(Q))


necesidad_vehiculos <- vehiculos %>%
  summarize(total_entregas = sum(total_entregas)) %>%
  mutate(vehiculos_necesarios = total_entregas / mean(vehiculos$total_entregas))
necesidad_vehiculos



clientes_80_20 <- data %>%
  group_by(CLIENTE) %>%
  summarize(total_ventas = sum(Q)) %>%
  arrange(desc(total_ventas)) %>%
  mutate(acumulado = cumsum(total_ventas),
         porcentaje_acumulado = acumulado / sum(total_ventas) * 100)
total_ventas = sum(data$Q)
ventas20 = total_ventas * 0.80

View(clientes_80_20 %>% filter(acumulado >= ventas20))

#mejores pilotos
pilotos_unicos <- unique(data$PILOTO)

ventas_por_piloto <- data %>%
  group_by(PILOTO) %>%
  summarise(total_ventas = sum(Q))

pilotos_ordenados <- ventas_por_piloto %>%
  arrange(desc(total_ventas))

mejores_pilotos <- head(pilotos_ordenados, n = 4)

avg = mean(ventas_por_piloto$total_ventas)
mejores_pilotos$cambio = mejores_pilotos$total_ventas/avg -1

barplot <- plot_ly(ventas_por_piloto, x = ~reorder(PILOTO, -total_ventas), y = ~total_ventas, type = 'bar', text = ~paste(total_ventas)) %>%
  layout(title = "Ventas Totales de los Mejores Pilotos", xaxis = list(title = "Piloto"), yaxis = list(title = "Ventas"))

entregas_por_piloto <- data %>%
  group_by(PILOTO) %>%
  count() %>%
  top_n(n = 10, wt = n)

barplot_entregas <- plot_ly(entregas_por_piloto, x = ~reorder(PILOTO, -n), y = ~n, type = 'bar', text = ~paste("Entregas:", n)) %>%
  layout(title = "Q de Entregas de los Mejores Pilotos", xaxis = list(title = "Piloto"), yaxis = list(title = "Q de Entregas"))

barplot_entregas

entregas_por_piloto_mes <- data %>%
  group_by(PILOTO, MES) %>%
  count()

promedio_entregas_por_piloto <- entregas_por_piloto_mes %>%
  group_by(PILOTO) %>%
  summarise(PromedioEntregas = mean(n))

barplot_promedio_entregas <- plot_ly(promedio_entregas_por_piloto, x = ~PromedioEntregas, y = ~PILOTO, type = 'bar', orientation = 'h', text = ~paste("Promedio Entregas:", round(PromedioEntregas, 2))) %>%
  layout(title = "Promedio de Entregas por Piloto", xaxis = list(title = "Promedio de Entregas"), yaxis = list(title = "Piloto"), showlegend = FALSE)

barplot_promedio_entregas

#nos estan robando?
ventas_por_piloto <- data %>%
  group_by(PILOTO) %>%
  summarise(ventas_promedio = mean(Q), ventas_desviacion = sd(Q))

desviaciones_estandar = 2
ventas_anomalas <- ventas_por_piloto %>%
  filter(ventas_promedio > mean(ventas_promedio) + desviaciones_estandar * ventas_desviacion)

ventas_anomalas



entregas_ventas_pilotos <- data %>%
  group_by(PILOTO, MES) %>%
  summarise(Entregas = n(), VentasTotal = sum(Q))


patrones_inusuales <- entregas_ventas_pilotos %>%
  mutate(Z_Entregas = (Entregas - mean(Entregas)) / sd(Entregas),
         Z_Ventas = (VentasTotal - mean(VentasTotal)) / sd(VentasTotal)) %>%
  filter(abs(Z_Entregas) > 2 | abs(Z_Ventas) > 2)


patrones_inusuales

leyenda_pilotos <- patrones_inusuales %>%
  mutate(Leyenda = paste("Piloto:", PILOTO))


scatter_plot <- plot_ly(leyenda_pilotos, x = ~Z_Entregas, y = ~Z_Ventas, text = ~paste("Piloto:", PILOTO, "<br>Entregas:", Entregas, "<br>Ventas:", VentasTotal)) %>%
  add_markers(marker = list(size = 10), hoverinfo = "text", texttemplate = '%{text}<extra></extra>') %>%
  layout(title = "Patrones Inusuales en Entregas y Ventas de Pilotos",
         xaxis = list(title = "Z-score Entregas"),
         yaxis = list(title = "Z-score Ventas"),
         showlegend = FALSE) %>%
  add_trace(data = leyenda_pilotos,
            x = ~Z_Entregas,
            y = ~Z_Ventas,
            text = ~Leyenda,
            mode = 'text',
            textfont = list(size = 10, color = "black"),
            showlegend = FALSE)

scatter_plot



transportes_ventas <- data %>%
  group_by(UNIDAD) %>%
  summarise(VentasTotal = sum(Q))

transportes_ventas <- transportes_ventas %>%
  arrange(desc(VentasTotal))


bar_plot <- plot_ly(transportes_ventas, x = ~VentasTotal, y = ~UNIDAD, type = 'bar', orientation = 'h') %>%
  layout(title = "Transportes Más Efectivos en Ventas",
         xaxis = list(title = "Ventas Totales"),
         yaxis = list(title = "Transporte"))

bar_plot


promedio_libras_por_camion <- data %>%
  group_by(UNIDAD) %>%
  summarise(PromedioLibrasPorViaje = mean(CANTIDAD))

promedio_libras_por_camion <- promedio_libras_por_camion %>%
  arrange(desc(PromedioLibrasPorViaje))

print(promedio_libras_por_camion)


bar_plot <- plot_ly(promedio_libras_por_camion, x = ~PromedioLibrasPorViaje, y = ~UNIDAD, type = 'bar', orientation = 'h') %>%
  add_trace(text = ~paste("Promedio: ", round(PromedioLibrasPorViaje, 2), " libras"),
            hoverinfo = "text", 
            textposition = "auto") %>%
  layout(title = "Promedio de Libras Movidas por Viaje por Tipo de Camión",
         xaxis = list(title = "Promedio de Libras por Viaje"),
         yaxis = list(title = "Tipo de Camión"))

bar_plot


data <- data %>%
  mutate(EfectividadVentas = Q / CANTIDAD)

efectividad_por_camion <- data %>%
  group_by(UNIDAD) %>%
  summarise(PromedioEfectividadVentas = mean(EfectividadVentas))

efectividad_por_camion <- efectividad_por_camion %>%
  arrange(desc(PromedioEfectividadVentas))

print(efectividad_por_camion)


bar_plot_efectividad <- plot_ly(efectividad_por_camion, x = ~PromedioEfectividadVentas, y = ~UNIDAD, type = 'bar', orientation = 'h') %>%
  # add_trace(text = ~paste("Efectividad: ", round(PromedioEfectividadVentas, 2)),
  #           hoverinfo = "text", 
  #           textposition = "auto") %>%
  layout(title = "Efectividad por Ventas por Camión",
         xaxis = list(title = "Efectividad por Ventas"),
         yaxis = list(title = "Tipo de Camión")) %>% add_annotations(text = paste0('Q.', efectividad_por_camion$PromedioEfectividadVentas, '     -'),
                          x = ~PromedioEfectividadVentas,
                          y = ~UNIDAD,
                          xref = "x",
                          yref = "y",
                          font = list(family = 'Arial',
                                      size = 14,
                                      color = 'rgba(245, 246, 249, 1)'),
                          showarrow = TRUE)

bar_plot_efectividad
