
load ("/home/dmontaner/trabajos_mios/2015/cellbaseR/pkg/R/datos_parametros.RData")
ls ()

.cbOptions <- list ()
.cbOptions$url     = "http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest"
.cbOptions$version = "latest"
.cbOptions$species = "hsapiens"
.cbOptions$infopar = pars
rm (pars)


## no export 
get.cb.par <- function (x) {
    .cbOptions[[x]]
}

## no export
set.cb.par <- function (x, y) {
    .cbOptions[[x]] <<- y
}

cbPar <- function (...) {
    li <- list (...)
    if (length (li) == 0) {
        sapply (.cbOptions, function (x) (print (head (x))))  ## MAKE MORE CLEAR THAT IT IS JUST THE HEADER
    } else {
        if (length (li) > 1) {
            stop ("just a parameter at a time: REVISAR ESTO")
        } else {
            if (is.null (names (li))) {
                get.cb.par (x = li[[1]])
            } else {
                set.cb.par (x = names (li[1]), y = li[[1]])
            }
        }
    }
}


## EXAMPLES
## ## examples
## get.cb.par ("url")
## get.cb.par ("cosa")

## set.cb.par ("url", "nuevo")
## .cbOptions

## ###

## cbPar ()
## cbPar ("url")
## cbPar ("url" = "HOLA")

## cbPar ("url")
## .cbOptions
