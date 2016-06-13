#:/bin/bash

echo "NÚMERO PRIMO ENTRE 1-5"
echo "Ingrese un número entre 1 y 5"
read num

if [ $num -ne 4 ]; then
	echo "$num es primo"
else
	echo "$num no es primo"
fi
echo "Fin del programa - JPAS"
