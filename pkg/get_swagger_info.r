##get_swagger_info_.r
##2015-09-10 dmontaner@cipf.es

date ()
Sys.info ()[c("nodename", "user")]
commandArgs ()
rm (list = ls ())
R.version.string ##"R version 3.2.2 (2015-08-14)"
library (jsonlite); packageDescription ("jsonlite", fields = "Version") #"0.9.16"
library (RCurl); packageDescription ("RCurl", fields = "Version") #"1.95-4.7"
#help (package = RCurl)

options (width = 170)

sapply (file.path ("R", dir ("R", recursive = TRUE, pattern = ".R$")), source)
ls ()


################################################################################
### Swagger WS
################################################################################

swag <- get.swagger.info ()
swag
sapply (swag, class)
dim (swag)
head (swag)


## QUERY MOMDELS
q1 <- cb.query.models  (tags = "feature/gene")
q1
