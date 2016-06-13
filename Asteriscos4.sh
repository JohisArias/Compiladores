#:/bin/bash

fila=1
echo "TRIANGULO RECTANGULO DERECHO"
echo "Ingrese la altura"
read altura
while [ $fila -le $altura ]; do
	#espacios
	aux=`expr $altura - $fila`
	while [ $aux -ge 0 ]; do
		echo -n " "
		aux=`expr $aux - 1`
	done
	#asteriscos
	aux1=1
	while [ $aux1 -le $fila ]; do
		echo -n "*"
		aux1=`expr $aux1 + 1`
	done
	echo "\n"
	fila=`expr $fila + 1`
done
echo "Fin del programa - JPAS"

