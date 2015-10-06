

##' Find depth of a list
##' 
depth <- function (l) {
    if (!is.list (l)) { 
        return (0)
    } else {
        return (1 + depth (unlist (l, recursive = FALSE)))
    }
}

## system.time (depth (jq))
## system.time (plotrix::listDesepth (jq))

## depth (jq)
## plotrix::listDepth (jq)
