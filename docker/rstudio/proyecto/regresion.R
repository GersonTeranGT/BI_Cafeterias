library(DBI)
library(RPostgres)
library(ggplot2)

# ============================================================
# 1. CONEXIÓN A POSTGRESQL
# ============================================================

conexion <- dbConnect(
  RPostgres::Postgres(),
  host = Sys.getenv("DW_HOST", "localhost"),
  port = as.integer(Sys.getenv("DW_PORT", 5450)),
  dbname = Sys.getenv("DW_DATABASE", "datawarehouse"),
  user = Sys.getenv("DW_USER", "root"),
  password = Sys.getenv("DW_PASSWORD", "root")
)

# ============================================================
# 2. CONSULTAR CLIENTES ATENDIDOS POR MES (CORREGIDO)
# ============================================================

clientes_mes <- dbGetQuery(
  conexion,
  "
  SELECT 
      dt.anio_mes AS mes,
      COUNT(f.atencion_key)::integer AS clientes_atendidos
  FROM dw.fact_atencion f
  JOIN dw.dim_tiempo dt ON f.fecha_key = dt.fecha_key
  WHERE f.completada = TRUE
  GROUP BY dt.anio_mes
  ORDER BY dt.anio_mes
  "
)

dbDisconnect(conexion)

# ============================================================
# 3. VERIFICAR DATOS
# ============================================================

print("📊 Datos cargados:")
print(head(clientes_mes))

# ============================================================
# 4. PREPARAR DATOS (CONVERSIÓN A NUMERIC)
# ============================================================

# Convertir mes a fecha
clientes_mes$fecha <- as.Date(paste0(clientes_mes$mes, "-01"))

# Convertir clientes_atendidos a numeric (para evitar integer64)
clientes_mes$clientes_atendidos <- as.numeric(clientes_mes$clientes_atendidos)

# Crear variable de tiempo (días desde el primer mes)
clientes_mes$tiempo <- as.numeric(
  clientes_mes$fecha - min(clientes_mes$fecha)
)

# ============================================================
# 5. MODELO DE REGRESIÓN LINEAL
# ============================================================

modelo <- lm(clientes_atendidos ~ tiempo, data = clientes_mes)

# Resumen del modelo
print("📈 Resumen del modelo:")
print(summary(modelo))

# ============================================================
# 6. VISUALIZACIÓN CON GGPLOT2
# ============================================================

# Crear predicciones
clientes_mes$prediccion <- predict(modelo, newdata = clientes_mes)

# Gráfico
ggplot(clientes_mes, aes(x = fecha, y = clientes_atendidos)) +
  geom_point(size = 3, color = "blue") +
  geom_line(aes(y = prediccion), color = "red", size = 1.2) +
  labs(
    title = "Tendencia de Clientes Atendidos por Mes",
    subtitle = paste(
      "R² =", round(summary(modelo)$r.squared, 3),
      "| Pendiente =", round(coef(modelo)[2], 2),
      "clientes/mes"
    ),
    x = "Mes",
    y = "Clientes Atendidos"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5)
  )

# ============================================================
# 7. PREDICCIÓN PARA PRÓXIMOS MESES
# ============================================================

# Crear datos para predicción (próximos 6 meses)
ultima_fecha <- max(clientes_mes$fecha)
fechas_futuras <- seq(ultima_fecha, by = "month", length.out = 7)[-1]

nuevos_datos <- data.frame(
  fecha = fechas_futuras,
  tiempo = as.numeric(fechas_futuras - min(clientes_mes$fecha))
)

nuevos_datos$prediccion <- predict(modelo, newdata = nuevos_datos)

# Mostrar predicciones
print("🔮 Predicciones para los próximos 6 meses:")
print(data.frame(
  Mes = format(nuevos_datos$fecha, "%Y-%m"),
  Clientes_Predichos = round(nuevos_datos$prediccion, 0)
))

