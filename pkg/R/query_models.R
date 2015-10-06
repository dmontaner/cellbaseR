
##' Gets all parameters for the models
##'
##' FALTA HACER LA DEPURACION DE HOJAS FINALES
##'
##' @param tags list of tags to be used to get models
##'
##' 
cb.query.models <- function (tags,
                             category, subcategory,        ## ver si quitamos esto
                             species = cbPar ("species"),
                             version = cbPar ("version"),
                             url = cbPar ("url"),
                             resource = "model") {

    pinfo <- get.swagger.info ()
    tags0 <- pinfo[pinfo$has.model, "tag"]
    
    ## tags
    if (missing (tags)) {
        print ("hola")
        if (missing (category) & missing (subcategory)) {
            print ("adios")
            tags <- tags0
        } else {
            tags <- paste (category, subcategory, sep = "/")
        }
    }
    
    ## revise tags
    nota <- !tags %in% tags0
    if (any (nota)){
        warning ("unknown tags: ", tags[nota])
    }

    print (tags)
    
    ##tag <- "feature/gene"
    ##ta <- "feature/transcript"
    ##ta <- "genomic/variant"
    res <- NULL
    for (tag in tags) {
        ## http://HOST_URL/{version}/{species}/{category}/{subcategory}/model
        link <- paste (url, version, species, tag, resource, sep = "/")
        print (link)
        jsn <- fromJSON (link, simplifyVector = TRUE, flatten = TRUE)
        par0 <- names (jsn[["response"]])
        res <- rbind (res, cbind (tag = tag, par0 = par0))
    }
    res <- as.data.frame (res, stringsAsFactors = FALSE)
    
    ## parse parameters
    res[,"par"] <- res[,"par0"]

    res[res$par == "id",               "par"] <- NA
    res[grep ("items.type$", res$par), "par"] <- NA
    res[grep ("items.id$",   res$par), "par"] <- NA
    
    res[,"par"] <- sub  ("^properties.",      "", res$par)  ## solo el primero por ahora
    res[,"par"] <- sub  (".type$",            "", res$par)  ## solo el ultimo
    res[,"par"] <- gsub ("items.properties.", "", res$par)

    res <- res[,c ("tag", "par", "par0")]  ## CAMBIAR ESTO PARA QUE NO ESTE EL PAR0
    #res <- res[,c ("tag", "par")]
    res <- res[!is.na (res$par),]
}
