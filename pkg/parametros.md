
__.$ref__ 

No hay ningún operador "$ref" de proyección implementado actualmente en CellBase.
Por lo general, lo que se pone en el parámetro "include" se le pasa directamente a la consulta de Mongo como operador de proyección para que devuelva únicamente los atributos que son de interés. El operador $, es un operador de proyección. Sin embargo, actualmente no se procesa en CellBase, lo que significa que no se hace nada con él.

http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest/v3/hsapiens/feature/protein/ALBU_HUMAN/info?include=reference.$ref