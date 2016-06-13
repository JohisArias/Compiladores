#:/bin/bash

fila=1
echo "PIRÁMIDE DE ASTERISCOS"
echo "Ingrese la altura de la pirámide"
read altura

#numero filas
while [ $fila -le $altura ]; do
	#cuenta los espacios
	aux=`expr $altura - $fila` 
	while [ $aux -ge 0 ]; do
		echo -n " "
		aux=`expr $aux - 1`
	done
	#imprime *s
	columna=1
	aux1=`expr $fila \* 2`
	aux2=`expr $aux1 - 1`
	while [ $columna -le $aux2 ]; do
		echo -n "*"
		columna=`expr $columna + 1`
	done
	echo "\n"
	fila=`expr $fila + 1`
done
echo "Fin del programa -JPAS"
