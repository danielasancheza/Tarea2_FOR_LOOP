#borrando las variables 
rm(list =ls())
#install.packages("readxl")
install.packages("ggplot2")

library(readr)

#borrando las variables 
rm(list =ls())
#install.packages("readxl")
#install.packages("ggplot2")

library(readr)

# 1 Cargue las bases de datos incoporando en cada una de ellas la variable "tamanio",donde indique de que tama�o es la empresa de ese pa�s
CLEL <- data.frame(read.csv("grandes_chile.csv",header = TRUE, sep = ";" ),tamanio="grande")
CLEM <- data.frame(read.csv("medianas_chile.csv", sep = ";" ),tamanio="mediana")
CLES <- data.frame(read.csv("pequena_chile.csv", sep = ";" ),tamanio="pequena")
CLEXS <- data.frame(read.csv("micro_chile.csv", sep = ";" ),tamanio="micro")


PEEL <- data.frame(read.csv("grandes_peru.csv", sep = ";" ),tamanio="grande")
PEEM <- data.frame(read.csv("medianas_peru.csv", sep = ";" ),tamanio="mediana")
PEES <- data.frame(read.csv("pequena_peru.csv", sep = ";" ),tamanio="pequena")
PEEXS <- data.frame(read.csv("micro_peru.csv", sep = ";" ),tamanio="micro")

COEL <- data.frame(read.csv("grandes_colombia.csv", sep = ";" ),tamanio="grande")
COEM <- data.frame(read.csv("medianas_colombia.csv", sep = ";" ),tamanio="mediana")
COES <- data.frame(read.csv("pequena_colombia.csv", sep = ";" ),tamanio="pequena")
COEXS <- data.frame(read.csv("micro_colombia.csv", sep = ";" ),tamanio="micro")


# 2 Reuna todas las bases en una sola y defina de qu� tipolog�a (tipo de datos) son cada una de las variables que se encuentran en la data.

#Agrupamos por pais
dbChile <- rbind (CLEL,CLEM,CLES,CLEXS)
dbPeru <- rbind (PEEL,PEEM,PEES,PEEXS)
dbColombia <- rbind (COEL,COEM,COES,COEXS)
#unimos todas
dbTodos <- rbind(dbChile,dbPeru,dbColombia)
#trasnformamos segun tipo de datos
dbTodos<-transform(
  dbTodos,
  fecha = as.Date.character(fecha, format = "%d-%m-%Y"),
  ingresos =as.numeric(gsub(",",".",ingresos)),
  costos =as.numeric(gsub(",",".",costos)),
  porcentaje_mujeres = as.numeric((gsub(",",".",porcentaje_mujeres))),
  exportaciones =as.numeric((gsub(",",".",exportaciones))),
  importaciones =as.numeric((gsub(",",".",importaciones))),
  endeudamiento =as.numeric((gsub(",",".",endeudamiento))),
  morosidad =as.numeric((gsub(",",".",morosidad))),
  reservas =as.numeric((gsub(",",".",reservas))),
  spread=as.numeric((gsub(",",".",spread))),
  tasa_interes=as.numeric((gsub(",",".",tasa_interes))))


#3)Determine a trav�s del uso de condicionales y/o for cu�ntas obervaciones tiene Peru versus Chile.(2 pto)
#Definimos variables para contar cuantas son de chile vs de peru
CL <-0
PE <-0
CLIng <-0
PEIng <-0
COIng <-0

#5) Genere una variable(columna) , donde si el pa�s es Chile multiplique la tasa de interes por 0,1, cuando sea Peru le sume 0,3 y, y finalmente si es Colombia divida por 10 (2ptos).Use condicionales y/o for.
#Agregamos la columna para punto 5

#recorremos todo
for (i in 1:nrow(dbTodos)) {
  ingreso =((dbTodos[i, "ingresos"]))
  tasa_interes =(dbTodos[i, "tasa_interes"])
  exportaciones =round((dbTodos[i, "exportaciones"]), digits = 1)
  if(exportaciones>2.1){
    dbTodos[i, "exportaciones"]=1
  }else if(exportaciones<2.1){
    dbTodos[i, "exportaciones"]=2
  }else if(exportaciones==2.1){
    dbTodos[i, "exportaciones"]=3
  }
  #6)Reemplace en la columna exportaciones con 1 cuando es mayor a 2,1, con un 2
  #cuando es menor 2,1y un 3 cuando es igual a 2,1, redondee al primer decimal la
  #variable(2 ptos). Use condicionales y/o for.
  
  #validamos si el pais es chile
  if(dbTodos[i, "pais"] =="chile"){
    #sumamos la variable CL
    CL = CL+1
    CLIng =CLIng+ingreso
    dbTodos[i,"columna"] = tasa_interes* 0.1
    #validamos si el pais es peru
  }else if(dbTodos[i, "pais"] =="peru"){
    #sumamos la variable PE
    PE=PE+1
    PEIng =PEIng +ingreso
    dbTodos[i,"columna"] = tasa_interes+0.3
    
    #validamos si el pais es colombia
  }else if(dbTodos[i, "pais"] =="colombia"){
    COIng =COIng + ingreso
    dbTodos[i,"columna"] = tasa_interes/10
  }
}

mayorIngreso="Chile"
if(CLIng<PEIng){
  mayorIngreso="Peru"
}
if(COIng>PEIng){
  mayorIngreso="Colombia"
}

#4)Determine a trav�s del uso de condicionales y/o for �cu�l es el pa�s con mayor ingresos de explotaci�n para los a�os que considera la muestra.(2 pto)

print(paste("El Pais con mayor ingresos es ",mayorIngreso))



library(ggplot2)

#7)Determine los ingresos de todas las empresas de chile, colombia y peru

hist(dbTodos$ingresos)












