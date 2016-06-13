#:/bin/bash

echo "3 NÚMEROS CRECIENTES"
echo -n "Ingrese primer número "; read num1
echo -n "Ingrese segundo número "; read num2
echo -n "Ingrese terecr número "; read num3

if [ $num1 -lt $num2 ]; then
	if [ $num2 -lt $num3 ]; then
		echo "Están ordenados ascendentemente"
	else
		echo "No están ordenados ascendentemente"
	fi
else
	echo "No están ordenados ascendentemente"
fi

echo "Fin del programa - JPAS"
