
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
        check.model.params (tag, info)
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

check.model.params <- function (tag, info) {
    #trueval <- cbPar("infopar")[cbPar("infopar")$tag == tag,]
    trueval <- cbPar("infopar")
    trueval <- trueval[trueval$tag == tag,]
    invalid <- !info %in% trueval[trueval$is.final == TRUE, "par"]   
    
    if (any (invalid)) {
        stop (sapply(info[invalid], function(x) paste(x, "is not a valid parameter\n")))
    }
    
    #info_level <- sapply(info, function(x) trueval[trueval$par==x, "level"])
    info_sep <- strsplit(info, "[.]")
    levels <- sapply(info_sep, length)
    
    M <- max(levels)
    if(!M == 1) {
        
        for(i in 1:(M-1)) {
            info_sep[levels == i] <- NULL  ## remove level i
            levels <- levels[!levels == i]
            
            compare <- sapply(info_sep, function(x) x[i])  ## check that all params have the same root
            
            if(!length(unique(compare)) == 1) {
                stop ("Different groups of parameters: ", paste(unique(compare), collapse = ", "), 
                      "\n  Please use only one group in each query.")
            }
        }
    }
    
    #return("OK")
}

