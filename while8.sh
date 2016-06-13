#:/bin/bash

i=1
suma=0
echo "SUMA DE NÚMEROS"
echo "¿De cuántos números desea la sumatoria?"
read limite

while [ $i -le $limite ]; do
	suma=`expr $suma + $i`
	i=`expr $i + 1`
done
echo "La suma de los $limite primeros números es $suma"
echo "Fin del programa - JPAS"
