
cbInfoPar <- function(tag) {
    p <- cbPar("infopar")
    
    # return all valid parameters
    if(missing(tag)) {  
        p <- p[p$is.final == TRUE, c("tag","par")]
        row.names(p) <- NULL
    }
    
    # return valid parameters for "tag"
    else {
        p <- p[p$tag == tag & p$is.final == TRUE, c("tag","par")]
        row.names(p) <- NULL
    }
    
    return(p)
}