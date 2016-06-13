#:/bin/bash

fila=1
echo "TRIÁNGULO RECTÁNGULO IZQUIERDO SUPERIOR"
echo "Ingrese la altura"
read altura
#filas
while [ $fila -le $altura ]; do
	#asteriscos
	columna=`expr $altura - $fila + 1`
	while [ $columna -ge 1 ]; do
		echo -n "* "
		columna=`expr $columna - 1`
	done
	echo "\n"
	fila=`expr $fila + 1`
done
echo "Fin del programa- JPAS"
