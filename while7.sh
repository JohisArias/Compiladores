#:/bin/bash

contador=0
echo "DIVISIÓN"
echo "Ingrese el divisor"
read divisor
echo "Ingrese el dividendo"
read dividendo
i=`expr $divisor`

while [ $i -gt 1 ]; do
	i=`expr $i - $dividendo`
	contador=`expr $contador + 1`
done
echo "El resultado de la división entre $divisor y $dividendo es $contador con residuo $i"
echo "Fin del programa - JPAS"
