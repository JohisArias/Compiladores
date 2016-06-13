#:/bin/bash

echo "PIRÁMIDE INVERTIDA"
echo "Ingrese la altura"
read altura

#filas
fila=`expr $altura`
while [ $fila -ge 1 ]; do
	#espacios
 	c=1
	aux=`expr $altura - $fila`
	while [ $c -le $aux ]; do
		echo -n " "
		c=`expr $c + 1`
	done
	#asteriscos
	columna=1
	while [ $columna -le $fila ]; do
		echo -n "* "
		columna=`expr $columna + 1`
	done
	echo "\n"
	fila=`expr $fila - 1`
done
echo "Fin del programa - JPAS"
