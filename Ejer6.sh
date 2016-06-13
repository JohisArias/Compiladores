#:/bin/bash

i=0
modulo=0
auxiliar=0
echo "CONTADOR DE DIGITOS"
echo "Ingrese un numero"
read numero
echo "El numero $numero tiene"
while [ $numero -gt 0 ]; do
	modulo=`expr $numero % 10`
	auxiliar=`expr $numero - $modulo`
	numero=`expr $auxiliar \/ 10`
	i=`expr $i + 1`
done
echo "$i digitos"
echo "Fin del programa - JPAS"
