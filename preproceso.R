Dataset.30122020 <- read.csv2("Dataset 30122020.csv", sep=";")
datos <- Dataset.30122020
datos$Indicator <- trimws(datos$Indicator)
datos$Country <- trimws(datos$Country)
write.csv(unique(datos$Indicator),"indicadores.csv",row.names = FALSE)
write.csv(unique(datos$Country),"paises.csv",row.names = FALSE)
indicadores_codigos <- read.csv("indicadores_codigos.csv")
datos$CodigoPais=""
datos <- datos[c(1,2,ncol(datos),seq(3,ncol(datos)-1))]
datos$CodigoInd = ""
for (i in 1:nrow(indicadores_codigos))
  datos[datos$Indicator == indicadores_codigos$Indicador[i],]$CodigoInd = as.character(indicadores_codigos$CodigoInd[i])
datos <- datos[c(1,2,ncol(datos),seq(3,ncol(datos)-1))]
estadisticas <- data.frame("Country"=c(),"Index"=c(),"Year"=c(),"Value"=c())
print(paste("Hay",(ncol(datos)-5)*nrow(datos),"datos"))
ndatos <- (ncol(datos)-5)*nrow(datos)
Country <- rep(" ",ndatos)
Index <- rep("NA",ndatos)
Year <- rep(0,ndatos)
Value <- rep(0,ndatos)
estad <- data.frame("Country"=Country,"Index"=Index,
                    "Year"=Year,"Value"=Value)
estad$Country <- as.character(estad$Country)
estad$Index <- as.character(estad$Index)
estad$Year <- as.integer(estad$Year)
estad$Value <- as.numeric(estad$Value)
k=1
for (i in 1:nrow(datos))
  for (j in 5:ncol(datos))
  {
    if (k%%1000 == 0)
      print(k)
    # if (!is.na(datos[i,j]))
    # estadisticas = rbind(estadisticas,
    #                         data.frame("Country"=datos$Country[i],
    #                         "Index" = datos$CodigoInd[i],
    #                         "Year" = 1960+j-5,
    #                         "Value" = datos[i,j]))
    estad$Country[k]=datos$Country[i]
    estad$Index[k]=datos$CodigoInd[i]
    estad$Year[k]=1960+j-5
    estad$Value[k]=datos[i,j]
    k = k+1
  }
write.csv(estad,"estadisticas.csv",row.names = FALSE)