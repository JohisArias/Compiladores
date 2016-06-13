#:/bin/bash

fila=0
echo "CRUZ DE ASTERISCOS"
echo "Ingrese altura"
read altura

aux=`expr $altura % 2`
if [ $aux -eq 0 ]; then
	altura=`expr $altura + 1`
fi

while [ $fila -lt $altura ]; do
	columna=0
	while [ $columna -lt $altura ]; do
		aux1=`expr $altura \/ 2`
			if [ $fila -eq $aux1 ] || [ $columna -eq $aux1 ]; then
			if [ $fila -ne $columna ]; then
				echo -n "*"
			else
				echo -n " "
			fi
		else
			echo -n " "
		fi
		columna=`expr $columna + 1`
	done
	echo -n "\n"
	fila=`expr $fila + 1`
done
echo "Fin del programa - JPAS"
