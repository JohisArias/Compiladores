#:/bin/bash

i=0
modulo=0
echo "DIGITO MAYOR DE UN NUMERO"
echo "Ingrese un numero"
read numero

while [ $numero -gt 0 ]; do
	modulo=`expr $numero % 10`
	if [ $modulo -gt $i ]; then
		i=`expr $modulo` 
	fi
	numero=`expr $numero  \/ 10`
done

echo "EL digito mayor es $i"
echo "Fin del programa - JPAS"
