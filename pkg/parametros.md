
__.$ref__ 

No hay ning�n operador "$ref" de proyecci�n implementado actualmente en CellBase.
Por lo general, lo que se pone en el par�metro "include" se le pasa directamente a la consulta de Mongo como operador de proyecci�n para que devuelva �nicamente los atributos que son de inter�s. El operador $, es un operador de proyecci�n. Sin embargo, actualmente no se procesa en CellBase, lo que significa que no se hace nada con �l.

http://bioinfodev.hpc.cam.ac.uk/cellbase/webservices/rest/v3/hsapiens/feature/protein/ALBU_HUMAN/info?include=reference.$ref