#:/bin/bash

i=2		#el numero no se divide ni para 1 ni para 0
modulo=0	#para calcular modulo
contador=0	#cuenta el numero de ceros
echo "VERIFICADOR DE NUMEROS PRIMOS"
echo "Ingrese un numero"
read numero
while [ $i -lt $numero ]; do
	modulo=`expr $numero % $i`
	if [ $modulo -eq 0 ]; then
		contador=`expr $contador + 1`
	fi
	i=`expr $i + 1 `
done
if [ $contador -gt 0 ]; then
	echo "El numero $numero no es primo"
else
	echo "El numero $numero es primo"
fi
echo "Fin del programa - JPAS"
