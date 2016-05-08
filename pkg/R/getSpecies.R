
##' Get all species
##'
##' http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest/latest/meta/species
##' http://HOST_URL/{version}/meta/species
##' 

#urlSpecies <- "http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest/latest/meta/species"

get.cb.species <- function (url = cbPar ("url"),
                            version = cbPar ("version"),
                            speciesPath = "meta/species") {
    
    urlSpecies <- paste (url, version, speciesPath, sep = "/")
    
    #jsn <- fromJSON (urlSpecies, simplifyVector = TRUE, flatten = TRUE)
    #jsn <- fromJSON (urlSpecies, simplifyVector = FALSE)
    jsn <- getResult (urlSpecies, simplifyVector = FALSE)
    jsn <- jsn$response
    jsn <- unlist(jsn, recursive = FALSE)$result
    
    jsn <- process.object.node(jsn)
    jsn <- jsn$nod
    
    res <- NULL
    for(js in 1:length(jsn)) {
        n <- names(jsn[js])
        js <- unlist(jsn[js][[1]], recursive=FALSE)
        res <- rbind(res, cbind(group = n, id = js[names(js)=="id"], name = js[names(js)=="scientificName"])) 
    }
    
    res <- as.data.frame (res, stringsAsFactors = FALSE)
    rownames (res) <- NULL
    
    return(res)
}


##' Show species

cbSpecies <- function (group) {
    species <- get.cb.species()
    
    if(missing(group)) species
    else(species[species$group==group,])
}

#getSpecies()
#getSpecies("plants")
