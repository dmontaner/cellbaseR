
## http://HOST_URL/{version}/{species}/{category}/{subcategory}/{id}/{resource}?{filters}

## http://HOST_URL/swagger.json
## http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest/swagger.json

##' @param url cellbase url (for the REST web services)
##' @param swaggerPath path to the finanal json
##' 
swagger.url <- function (url = cbPar ("url"), swaggerPath = "swagger.json") {
    paste (url, swaggerPath, sep = "/")
}


##'
##' Get Swagger Info
##'
##' Extracts the most relevant information from the Swgger JSON object.
##'
##' Used to know which "models" are available

get.swagger.info <- function (url = cbPar ("url"), 
                              swaggerPath = "swagger.json") {
    
    urlSwagger <- swagger.url (url = url, swaggerPath = swaggerPath)
    jsn <- fromJSON (urlSwagger, simplifyVector = FALSE)
    
    ## names (jsn)  ## "swagger"     "info"        "basePath"    "tags"        "schemes"     "paths"       "definitions"
    ## "tags" & "definitions" may be interesting at some point
    ## unlist (jsn[["tags"]])

    pinfo <- data.frame (path = names (jsn[["paths"]]), stringsAsFactors = FALSE)
    ##pinfo[,"has.version"] <- grepl ("/\\{version}/", pinfo$path)   ## version is always present
    pinfo[,"has.species"] <- grepl ("/\\{species}/", pinfo$path)
    ##pinfo[,"has.v&s"]     <- grepl ("/\\{version}/\\{species}/", pinfo$path)
    pinfo[,"has.model"] <- grepl ("model", pinfo$path)
    ##
    limpio <- sub ("/\\{version}/\\{species}/", "", pinfo$path)
    limpio[!pinfo$has.species] <- NA
    pinfo[,"has.id"] <- grepl ("/\\{.*}/", limpio)
    ##
    pinfo[,"tag"] <- sapply (lapply (strsplit (limpio, split = "/"), "[", 1:2), paste, collapse = "/")
    pinfo[grep ("/NA", pinfo$tag), "tag"] <- NA
    
    pinfo[,"tail"] <- apply (pinfo[,c("path", "tag")], 1, function (x) try (unlist (strsplit (x[1], split = x[2]))[2],  silent = TRUE))
    pinfo[grep ("Error in strsplit", pinfo[,"tail"]), "tail"] <- NA
    pinfo[,"tail"] <- sub ("/", "", pinfo[,"tail"])

    return (pinfo)
}

## pinfo <- get.swagger.info ()
## sapply (pinfo, class)
## head (pinfo)
## pinfo[!pinfo$has.species,]
## pinfo[!pinfo$has.id,]

## table (pinfo[,"has.model"], pinfo[,"tail"] == "model", exclude = NULL)
## pinfo[pinfo$has.model,]
