#:/bin/bash

echo "NÚMEROS DESCENNDENTES"
echo "¿De qué número desea partir?"
read inicio
i=`expr $inicio`

echo "\n"
while [ $i -ge 0 ]; do
	echo "$i"
	i=`expr $i - 1`
done
echo "Fin del programa - JPAS"
