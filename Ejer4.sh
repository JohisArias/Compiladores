#!/bin/bash

echo "NUMEROS ORDENADOS O NO"
echo "Ingrese numero1: "; read num1
echo "Ingrese numero2: "; read num2
echo "Ingrese numero3: "; read num3
echo "Ingrese numero4: "; read num4
echo "Ingrese numero5: "; read num5

if [ $num1 -lt $num2 ] && [ $num2 -lt $num3 ] && [ $num3 -lt $num4 ] %% [ $num4 -lt $num5]; then
	echo "Los numeros están ordenados ascendentemente"
else
	echo "Los numeros no están ordenados"
fi
echo "Fin del programa - JPAS"

