#:/bin/bash

i=0		#iterador del bucle
modulo=0	#modulo
c=0		#contador
suma=0
echo "PARES ENTRE LIMITES"
echo "Ingrese el limite menor"
read menor
echo "Ingrese el limite mayor"
read mayor

i=`expr $menor + 1`
while [ $i -le $mayor ]; do
	modulo=`expr $i % 2` 	#si es par
	if [ $modulo -eq 0 ]; then
		c=`expr $c + 1`
		suma=`expr $suma + $i`
		echo "$c° numero par es $i"
	fi
	i=`expr $i + 1`
done
echo "Existen $c numeros pares"
echo "y su suma es $suma"
echo "Fin del programa - JPAS"
