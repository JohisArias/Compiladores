#:/bin/bash
echo "MAYOR, MENOR O IGUAL (3 NÚMEROS)"
echo -n "Ingrese primer número "; read uno
echo -n "Ingrese segundo número "; read dos
echo -n "Ingrese tercer número "; read tres

if [ $uno -gt $dos ] && [ $uno -gt $tres ]; then
	if [ $dos -gt $tres ]; then
		echo "El mayor es $uno y el menor es $tres"
	elif [ $tres -gt $dos ]; then
		echo "El mayor es $uno y el menor es $dos"
	else
		echo "$dos y $tres son iguales"
	fi
elif [ $dos -gt $uno ] && [ $dos -gt $tres ]; then
	if [ $uno -gt $tres ]; then
		echo "EL mayor es $dos y el menor es $tres"
	elif [ $tres -gt $uno ]; then
		echo "EL mayor es $dos y el menor es $uno"
	else
		echo "$tres y $uno son iguales"
	fi
elif [ $tres -gt $uno ] && [ $tres -gt $dos ]; then
	if [ $uno -gt $dos ]; then
		echo "El mayor es $tres y el menor es $dos"
	elif [ $dos -gt $uno ]; then
		echo "El mayor es $tres y el menor es $uno"
	else
		echo "$uno y $dos son iguales"
	fi
else
	echo "$uno, $dos y $tres son iguales"
fi
echo "Fin del programa - JPAS"
