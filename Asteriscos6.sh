#:/bin/bash

fila=1
echo "TRIÁNGULO RECTÁNGULO DERECHO SUPERIOR"
echo "Ingrese la altura"
read altura
#filas
while [ $fila -le $altura ]; do
	#espacios
	columna=0
	aux=`expr $fila - 1`
	while [ $columna -lt $aux ]; do
		echo -n "  "
		columna=`expr $columna + 1`
	done
	#asteriscos
	aux1=`expr $altura - $fila`
	while [ $aux1 -ge 0 ]; do
		echo -n "* "
		aux1=`expr $aux1 - 1`
	done
	echo "\n"
	fila=`expr $fila + 1`
done
echo "Fin del programa - JPAS"

