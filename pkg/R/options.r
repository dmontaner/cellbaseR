
## ver:
## http://stackoverflow.com/questions/9913905/how-to-store-package-specific-settings-in-r-options-vs-referenceclasses
## https://cran.r-project.org/web/packages/settings

eval (parse (text = expression ('options (hola = "hola3")')))

setCBpar <- function (...) {
    do.call (options, args = list (...))
}
setCBpar

setCBpar (hola = "SADFASF")
options ("hola")



setCBpar ("hola" = "SADFASF")

do.call (options, args = list (hola = "sdfafl"))


, quote = FALSE, envir = parent.frame())





setCBpar <- function (...) {
    print (as.expression (...))
    #eval (parse (text = ...))
}

call (options, ...)







setCBpar (hola = "HOLA")

setCBpar (hola = "HOLA")

setCBpar (hola = "HOLA")

eval(parse(text="5+5"))




options ("hola")

setCBpar (hola = "hola")

setCBpar (hola = "hola")



options ("hola" = "hola2")
options ("hola", "hola2")



options ()$hola <- "hola3"

