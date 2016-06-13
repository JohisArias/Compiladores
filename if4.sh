#:/bin/bash

echo "PAR O IMPAR"
echo "Ingrese un número"
read numero

i=`expr $numero % 2`
if [ $i -eq 0 ]; then
	echo "El número $numero es par"
else
	echo "El número $numero es impar"
fi
echo "Fin del programa - JPAS"
