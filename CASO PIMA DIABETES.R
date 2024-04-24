# Cargar paquetes y datos
library(curl)
library(readr)
library(DataExplorer)
library(dplyr)

# Especifica la URL del archivo en GitHub
#url <- "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.te.csv"
#url <- "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.tr.csv"
url <- "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.tr2.csv"

# Lee el archivo CSV desde GitHub y renombra las columnas
pima <- read_csv(url, col_types = cols(
  X1 = col_double(),
  npreg = col_double(),
  glu = col_double(),
  bp = col_double(),
  skin = col_double(),
  bmi = col_double(),
  ped = col_double(),
  age = col_double(),
  type = col_character()
)) %>% 
  rename(
    numero_embarazos = npreg,
    concentracion_glucosa = glu,
    presion_arterial = bp,
    espesor_pliegue_cutaneo = skin,
    indice_masa_corporal = bmi,
    funcion_pedigree_diabetes = ped,
    edad = age,
    tipo_diabetes = type
  )

# Análisis exploratorio de datos
dim(pima) # Dimensiones del conjunto de datos
names(pima) # Nombres de las columnas
str(pima) # Estructura de los datos
summary(pima) # Resumen estadístico

# Media de cada variable numérica
media <- sapply(pima[, c("numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad")], mean)

# Función para calcular la moda de manera adecuada
calcular_moda <- function(x) {
  tab <- table(x)
  modas <- names(tab)[tab == max(tab)]
  if (length(modas) == 0) {
    return(NA) # Si no hay moda, retornar NA
  } else {
    return(as.numeric(modas[1])) # Devolver solo la primera moda encontrada
  }
}

# Moda de cada variable numérica
moda <- sapply(pima[, c("numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad")], calcular_moda)

# Crear el data frame con la media y la moda
resultados <- data.frame(Media = media, Moda = moda)
print("Media y Moda de cada variable numérica:")
print(resultados)

# Análisis de asociación con la diabetes
medias_diabetes <- aggregate(. ~ tipo_diabetes, data = pima, mean)
print("Medias de cada variable por tipo de diabetes:")
print(medias_diabetes)

# Análisis de cada variable
print("Análisis de cada variable:")
for (col in c("numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad")) {
  print(summary(pima[[col]]))
}

# Visualización de datos

# Generar los gráficos para cada variable en todo el conjunto de datos
for (col_name in c("numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad")) {
  # Histograma
  hist(pima[[col_name]], main = paste("Histograma de", col_name), xlab = col_name)
  
  # Gráfico de dispersión
  plot(pima[[col_name]], main = paste("Gráfico de dispersión de", col_name), xlab = col_name, ylab = "Índice de masa corporal")
  
  # Boxplot
  boxplot(pima[[col_name]], main = paste("Boxplot de", col_name), ylab = col_name)
}

plot_histogram(pima)

# Matriz de dispersión
pairs(pima[, c("numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad")], main = "Matriz de dispersión")





