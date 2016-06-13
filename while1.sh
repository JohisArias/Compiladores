#:/bin/bash

cont=1
echo "Listado de los 20 primeros números"
while [ $cont -le 20 ]; do
	echo -n "$cont"
	cont=`expr $cont + 1`
done
echo "Fin del programa - JPAS"

