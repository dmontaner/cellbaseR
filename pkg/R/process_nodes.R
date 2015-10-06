
is.array.node <- function (x) {
    all (sapply (x, is.list))
}

is.object.node <- function (x) {
    any (!sapply (x, is.list))
}


process.object.node <- function (x) {
    lista <- sapply (x, is.list)
    mat <- x[!lista]     ## this part is asumed NOT to be empty
    mat <- data.frame (mat, stringsAsFactors = FALSE)
    #colnames (mat) <- NULL  ## may not be the best way to do this
    ##
    ## jus one or zero nodes may be in lista
    if (any (lista)) {
        nod <- x[[which (lista)]]  ## REVISE: complete unlist may not be needed
    } else {
        nod <- NULL
    }
    return (list (mat = mat, nod = nod))
}


##' @param x a node in the annotation tree
##' @param prev vector of integer values with the precomputed previous nodes
##' 
process.array.node <- function (x, prev) {
    
    ## ## array of arrays
    ## while (all (sapply (x, is.array.node))) { desENCAPSULADO
    ##     print ("unlisting")
    ##     x <- unlist (x, recursive = FALSE)
    ## }

    ## array of arrays
    ## if (all (sapply (x, is.array.node))) { ALTERNATIVA: generar una salida con matriz vacia NO VALE PORQUE COMPLICA LA GENERACION DE LOS INDICES DE LA PROXIMA RONDA
    ##     print ("unlisting")
    ##     mat <- NULL
    ##     nod <- unlist (x, recursive = FALSE)
    ## } else {
        
    if (all (sapply (x, is.object.node))) { ## all objecs ideally have the same elements ESTO PUEDE FALLAR.... cuando no haya informacion aunque creo que sale vacia
        mat <- NULL
        nod <- list ()
        for (i in 1:length (x)) {   ## esto ya es equivalente a un unlist
            res <- process.object.node (x[[i]])
            mat <- rbind (mat, cbind (prev = prev[i], res$mat))  ## PUEDE FALLAR AQUI si no todos tienen la informacion... 
            nod <- c (nod, list (res$nod))
        }
    } else {
        stop ("PROBLEM arrays mezclados con objetos")
    }
    ##}  ## PARA la ALTERNATIVA...
    return (list (mat = mat, nod = nod))
}


## fomatNodo
## nodo2dataframe
## VER POR QUE NO PROCESA BIEN LOS TAGS SACADOS DEL JSON
cbFormat <- function (n, salidaLista = FALSE) {
    parar <- FALSE
    mat <- list ()
    
    row.pos <- rep (1, times = length (n))  ## seguramente se inicie para cuadrar con los IDS DE la query REVISAR
    
    while (!parar) {

        if (is.array.node (n)) {
            print ("processing Array Node")

            ## encapsulado lineal  IGUAL DEBERIA ESTAR DENTRO DEL PROXIMO IF
            ##while (all (sapply (n, length) == 1)) {
            while (is.array.node (n) & all (sapply (n, length) == 1)) {
                print ("encapsulado lineal")            
                n <- unlist (n, recursive = FALSE)
            } 
            
            ## array of arrays 
            if (all (sapply (n, is.array.node))) {
                print ("array de arrays")
                row.pos <- rep (row.pos, sapply (n, length))
                n <- unlist (n, recursive = FALSE)    ## VER POR QUE NECESITA DOS VECES.. pueden hacer falta mas... encapsulados lineales
            } else {
                print ("array de objetos")            
                res <- process.array.node (n, prev = row.pos)
                mat <- c (mat, list (res$mat))
                n <- res$nod
                row.pos <- rep (1:length (n), times = sapply (n, length))
                n <- unlist (n, recursive = FALSE) ## colapse nodes
                parar <- all (sapply (n, is.null))
            }
        } else {    ## solo deberia ocurrir la primera vez... creo  deberia ir al ELSE ver que pasa con los IDS si no
            print ("processing Object Node")
            res <- process.object.node (n)
            mat <- c (mat, list (res$mat))
            n <- res$nod
        }
    }
    
    ## single data frame TODO ESTO REPLICA LA MATRIZ... ver si se puede no replicar tanto
    L <- length (mat)
    res <- mat[[L]]
    for (i in (L-1):1) {
        print (i)
        prev <- res$prev
        res <- res[,-1]
        res <- cbind (mat[[i]][prev,], res)
    }
    rownames (res) <- NULL
    
    if (salidaLista) {
        return (list (mat = mat, res = res))  # CAMBIAR LA NOTACION DE MAT y RES
    } else {
        return (res)
    }
}
