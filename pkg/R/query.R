
## http://HOST_URL/{version}/{species}/{category}/{subcategory}/{id}/{resource}?{filters}

##' @param ids character vector ids to get information from
##' @param info character vector the info you want to get
##' @param tag the type of "ids" introduced
##' @param
##' @param
##' @param
##'
##' Igual la utilidad final puede tener una funcion final de descarga para cada tipo de tag
##'
##' cbBuildQuery sera una funcion generica.... para:
##' character: base
##' matriz, dataframe, lista : todo toma los nombres com ids
##' expressionSet: para arrays
##' limma: a partir de los genes
##' iranges para las posiciones
##' ver otras cosas como objetos para snps
##'
##' el reparto de los IDS hacerlo en la funcion de ejecucion de la query

cb.build.query <- function (ids, 
                            info, ##filters
                            tag,
                            category, subcategory,
                            species = cbPar ("species"),
                            version = cbPar ("version"),
                            url = cbPar ("url"),
                            resource = "info",
                            filter = "include",
                            checkpars = TRUE
                            ) {
    
    ## ids
    ## eliminate whites ???
    ids <- paste (ids, collapse = ",")
    
    ## info
    if (checkpars){
        check.model.params (info)
    }
    info <- paste (info, collapse = ",")
    
    ## tag
    if (missing (tag)) {
        tag <- paste (category, subcategory, paste = "/")
    }

    ## http://HOST_URL/{version}/{species}/{category}/{subcategory}/{id}/{resource}?{filters}    
    link <- paste (url, version, species, tag, ids, resource, sep = "/")
    link <- paste0 (link, "?", filter, "=", info)

    return (link)
}

## ## example
## cb.build.query (ids = c ("uno", "dos", "tres"),
##                 info = c ("transcripts.id", "transcripts.exon.id"),
##                 tag = "feature/gene")

check.model.params <- function (info, trueval = cbPar ("infopar")[,"par"]) {
    nota <- !info %in% trueval
    if (any (nota)) {
        stop (info[nota], " is not a valid parameter")
    }
}        


##' Groups of identifiers.

chunk.ids <- function (ids, N = 100) {    
    
    ids.chunk <- list()  
    
    ## number of groups
    rep <- (length(ids) / N)    
    if(length(ids) %% N != 0)
        rep <- rep + 1    
    
    for(i in 1:rep) {
        start <- (i-1) * N + 1
        end <- i * N
        
        if(end > length(ids)) {
            end <- length(ids)
        }
        
        ids.chunk <- c(ids.chunk, list(ids[start:end]))
    }
    
    return(ids.chunk)
}


cbQuery <- function (ids, tag, attributes) {
    res <- NULL
    ids <- chunk.ids (ids)
    
    params <- cbPar("infopar")[,c("tag", "tag.simple")]
    tag <- unique(params$tag[params$tag.simple == tag])
    
    for(i in 1:length(ids)) {
        
        id <- paste (ids[[i]], collapse = ",")
        url <- cb.build.query(ids = id, tag = tag, info = attributes)
        
        #jsn <- fromJSON (url, simplifyVector = FALSE, flatten = TRUE)
        jsn <- getResult(url, simplifyVector = FALSE, flatten = TRUE)
        jsn <- jsn[["response"]]        
        nodo <- lapply (jsn, function (x) x[["result"]][[1]])
        
        res <- c(res, nodo)
    }
    
    res <- cbFormat (res)
    
    return(res)
}



