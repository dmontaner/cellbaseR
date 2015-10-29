
##' @title Generic query function.
##' 
##' @description
##' This function gets the information related to the call.
##' 
##' @param url Complete url generate with the information specified by user.
##' 
##' @return List of information returned by the call.
##' 

getResult <- function(url, simplifyVector = FALSE, flatten = FALSE) {
    
    result <- tryCatch ({
        getURL(url)
    }, error = function(w) {"Request to Cellbase web service failed."})
    
    if(!is.null(result)) {
        parsed_result <- try (fromJSON (result, simplifyVector = simplifyVector, flatten = flatten))
        
        if("try-error" %in% class(parsed_result)) parsed_result <- NULL
    }    
    #res <- parsed_result$response$result   
    
    return(parsed_result)
}

