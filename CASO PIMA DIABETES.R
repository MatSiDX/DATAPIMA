library(curl)
library(readr)

# Especifica la URL del archivo en GitHub
#url <- "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.te.csv"
#url <- "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.tr.csv"
url <- "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.tr2.csv"

# Lee el archivo CSV desde GitHub e imprime la especificación de las columnas
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
))

# Analysis exploratorio de datos
dim(pima)
names(pima)
str(pima)
attributes(pima)
summary(pima)

# Visualización de datos
table(pima$npreg)
hist(pima$npreg)
plot(density(pima$npreg))
plot(pima$npreg, pima$age)
pairs(pima[,4:8])