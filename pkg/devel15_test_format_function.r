## devel15_test.r
## 2015-09-15 david.montaner@gmail.com
## loads R functions to start developing a package

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.2.2 (2015-08-14)"
library (jsonlite); packageDescription ("jsonlite", fields = "Version") #"0.9.16"
library (RCurl); packageDescription ("RCurl", fields = "Version") #"1.95-4.7"
#help (package = RCurl)

options (width = 170)

sapply (file.path ("R", dir ("R", recursive = TRUE, pattern = ".R$")), source)
ls ()

################################################################################
genes <- c ("ENSG00000158014", "ENSG00000210107", "ENSG00000241599") ## varios transcritos
infos <- c ("id", "start", "chromosome", "transcripts.id", "transcripts.end", "transcripts.exons.id", "transcripts.exons.strand")
#infos <- c ("id", "start", "chromosome", "transcripts.exons.id", "transcripts.exons.strand")  ## asi transcrito es un array
mitag <- "feature/gene"

miurl <- cb.build.query (ids = genes, info = infos, tag = mitag)   ## esto se puede medio computar todo menos los GENES pensando en la iteracion global
miurl

cb.build.query (ids = genes, info = "cosa", tag = mitag)   ## e

#browseURL (miurl)

## TODO ESTEPROCESO HAY QUE EMPEZAR A EMPAQUETARLO YA para bajar la query

jsn0 <- fromJSON (miurl)
jsn0 <- jsn0[["response"]]
class (jsn0)
sapply (jsn0, class)
jsn0[['id']]
class (jsn0[['result']])

jsn <- fromJSON (miurl, simplifyVector = FALSE, flatten = TRUE)
jsn <- jsn[["response"]]
length (jsn)
sapply (jsn, names)## dentro de cada objeto del array de objetos
sapply (jsn, function (x) x[["id"]]) ## los identificadores de la query
#sapply (jsn, function (x) x[["result"]]) ## los identificadores de la query

nodo <- lapply (jsn, function (x) x[["result"]][[1]])
length (nodo)

#nodo <- jsn[[1]][["result"]][[1]] ## OK UN UNICO GEN
#nodo <- jsn[[1]][["result"]]      ## OK CON UN UNICO GEN encapsulado
#nodo

################################################################################

is.object.node (nodo)
is.array.node  (nodo)

cbFormat (nodo)
