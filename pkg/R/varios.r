
## The general structure of a CellBase RESTful call is:
## http://HOST_URL/{version}/{species}/{category}/{subcategory}/{id}/{resource}?{filters}

rm (list = ls ())

## Configuracion

## vale todo en el config
table (sapply (options (), length))
table (sapply (options (), class))

names (options ())
## leerlo de un yaml sin usar las dependencias
## <http://stackoverflow.com/questions/5272846/how-to-get-parameters-from-config-file-in-r-script>

cellbaseR
setCBoptions
getCBoptions

query

## http://HOST_URL/{version}/{species}/{category}/{subcategory}/{id}/{resource}?{filters}

cb <- list ()
cb$url = "http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest"
cb$version = "latest"
cb$species = "hsapiens"
category    #tag  BIOLOGICAL ENTITY
subcategory #tag
resource
type of elementx ??? categry + subcategory
cb$urlSwager <- paste (cb$url, "swagger.json", sep = "/")

cb

##
info / query parameters / attributes (como en Ensembl)
qpar
query


falta un parametro
resource
load ("/home/dmontaner/trabajos_mios/2015/cellbaseR/scripts3_github/datos_parametros.RData")
cbQpars <- pars
head (cbQpars)

tags <- sort (unique (cbQpars[,"tag"]))
tags

#' @export
showCBinfo <- function (tag = "all", 
                        url    = getCBpar ("url"),
                        vesion = getCBpar ("version"),
                        category, subcategory,    #altenrative to tag
                        verbose = TRUE) {
    cat (res)
    invisible (res)
}


##' @param ids character vector
##' deberia sergenerica... para poder definir al menos metodos para:
##' character: base
##' matriz, dataframe, lista : todo toma los nombres com ids
##' expressionSet: para arrays
##' limma: a partir de los genes
##' iranges para las posiciones
##' ver otras cosas como objetos para snps
##' 
#buildCBquery <- GENERIC FUNCTION 
buildCBurl
build.cb.query <- function (url, version, species,
                           tag, category, subcategory,  ## VER EL ORDEN DE PREFERENCIAS... CREO QUE MEJOR TAG QUE SE LO INVENTE NACHO
                           ids, 
                           resource = "info", ## revisar este valor por defecto... igual no vale la poena  ni ponerlo
                           ##filters)
                           info) { ## algun nombre listo para filtros
    
    ## cambiar el orden de los parametros seguramente
    ##ids <- as.character (ids)
    ## ojo con los factores
    ids <- paste (ids, collapse = ",")
    ## http://HOST_URL/{version}/{species}/{category}/{subcategory}/{id}/{resource}?{filters}
    if (mising (tag)) {
        tag <- paste (category, subcategory, paste = "/")
    }
    link <- paste (url, version, tag, ids, resource info, speciessep = "/")
    return (link)
}




x

checkCBconection <- function (url, version, species){
}

checkCBpars <- function (url, version, species) {
}

getBCspecies (url, version) {


}

##' fncion generica PRINCIPAL
getCBinfo <- function (ids, ...,
                       append.if.possible = FALSE# forma automatica de insertarlo en el objeto.... si hay una forma estandard
                       ) {
    
}
