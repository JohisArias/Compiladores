#:/bin/bash

primero=0
segundo=1
i=2
suma=0

echo "SUCESION FIBONACCI"
echo "Ingrese el numero de terminos que desea"
read limite
echo "La sucesion Fibonacci de los $limite primeros terminos es:"
echo "\t$primero";echo "\t$segundo"
while [ $i -lt $limite ]; do
	suma=`expr $primero + $segundo`
	echo "\t$suma"
	primero=`expr $segundo`
	segundo=`expr $suma`
	i=`expr $i + 1`
done

echo "Fin del programa - JPAS"
