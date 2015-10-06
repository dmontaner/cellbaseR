
## ver esto:
## http://stackoverflow.com/questions/9913905/how-to-store-package-specific-settings-in-r-options-vs-referenceclasses
## https://cran.r-project.org/web/packages/settings

## ESTO FUNCIONA
options (cellbaseR.url     = "http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest")
options (cellbaseR.version = "latest")
options (cellbaseR.species = "hsapiens")

################################################################################

##' same pattern as
##' options ("cosa")
##' @export
getCBpar <- function (parname) {
    parnameOPT <- paste0 ("cellbaseR.", parname)
    ret <- options (parnameOPT)
    names (ret) <- sub ("cellbaseR.", "", names (ret))
    if (!parnameOPT %in% names (options ())) print (paste (parname, "is not set/available"))
    return (ret)
}

##' @examples
getCBpar ("url")
getCBpar ("cosa")

################################################################################

setCBpar <- function (...) {
    li <- list (...)
    names (li) <- paste0 ("cellbaseR.", names (li))
    print (li)
    do.call (options, args = li)
}

setCBpar (url = "hola")
getCBpar ("url")

setCBpar (nuevo = "hola")
getCBpar ("nuevo")


bcPar ()
