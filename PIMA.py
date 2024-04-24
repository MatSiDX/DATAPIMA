import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Especifica la URL del archivo en GitHub
#url = "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.te.csv"
#url = "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.tr.csv"
url = "https://raw.githubusercontent.com/MatSiDX/DATAPIMA/main/Pima.tr2.csv"

# Lee el archivo CSV desde GitHub y renombra las columnas
pima = pd.read_csv(url, dtype={"type": "object"})

pima.rename(columns={
    "X1": "numero_embarazos",
    "npreg": "numero_embarazos",
    "glu": "concentracion_glucosa",
    "bp": "presion_arterial",
    "skin": "espesor_pliegue_cutaneo",
    "bmi": "indice_masa_corporal",
    "ped": "funcion_pedigree_diabetes",
    "age": "edad",
    "type": "tipo_diabetes"
}, inplace=True)

# Análisis exploratorio de datos
print("Dimensiones del conjunto de datos:")
print(pima.shape)  # Dimensiones del conjunto de datos
print("\nNombres de las columnas:")
print(pima.columns)  # Nombres de las columnas
print("\nEstructura de los datos:")
print(pima.info())  # Estructura de los datos
print("\nResumen estadístico:")
print(pima.describe())  # Resumen estadístico

# Media de cada variable numérica
media = pima[["numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad"]].mean()

# Función para calcular la moda de manera adecuada
def calcular_moda(x):
    tab = x.value_counts()
    modas = tab[tab == tab.max()].index.tolist()
    return modas[0] if modas else None

# Moda de cada variable numérica
moda = pima[["numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad"]].apply(calcular_moda)

# Crear el DataFrame con la media y la moda
resultados = pd.DataFrame({"Media": media, "Moda": moda})
print("\nMedia y Moda de cada variable numérica:")
print(resultados)

# Análisis de asociación con la diabetes
medias_diabetes = pima.groupby("tipo_diabetes").mean()
print("\nMedias de cada variable por tipo de diabetes:")
print(medias_diabetes)

# Análisis de cada variable
print("\nAnálisis de cada variable:")
for col in ["numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad"]:
    print(pima[col].describe())

# Visualización de datos

# Generar los gráficos para cada variable en todo el conjunto de datos
for col_name in ["numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad"]:
    # Histograma
    plt.figure()
    sns.histplot(pima[col_name])
    plt.title("Histograma de " + col_name)
    plt.xlabel(col_name)
    plt.show()

    # Gráfico de dispersión
    plt.figure()
    sns.scatterplot(pima[col_name])
    plt.title("Gráfico de dispersión de " + col_name)
    plt.xlabel(col_name)
    plt.ylabel("Índice de masa corporal")
    plt.show()

    # Boxplot
    plt.figure()
    sns.boxplot(data=pima, x=col_name)
    plt.title("Boxplot de " + col_name)
    plt.ylabel(col_name)
    plt.show()

# Matriz de dispersión
sns.pairplot(pima[["numero_embarazos", "concentracion_glucosa", "presion_arterial", "espesor_pliegue_cutaneo", "indice_masa_corporal", "funcion_pedigree_diabetes", "edad"]])
plt.suptitle("Matriz de dispersión")
plt.show()
