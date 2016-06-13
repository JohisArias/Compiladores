#:/bin/bash

i=1
echo "POTENCIACIÓN"
echo "Ingrese la base"
read base
echo "Ingrese el exponente"
read exponente

resultado=`expr $base`
while [ $i -lt $exponente ]; do
	resultado=`expr $resultado \* $base`
	i=`expr $i + 1`
done	
echo "$base elevado a la $exponente es $resultado"
echo "Fin del programa - JPAS"
