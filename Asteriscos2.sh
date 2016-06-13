#:/bin/bash
i=0		#iterador
fila=2		#*         *

echo "CUADRADO VACÍO DE ASTERISCOS"
echo "Ingrese el tamaño del cuadrado"
read tamanio

#primera fila
columna=1
while [ $columna -le $tamanio ]; do	#*********...tamanio
	echo -n "*"
	columna=`expr $columna + 1`
done
echo "\n"

#filas inferiores
while [ $fila -lt $tamanio ]; do
	echo -n "*"
	columna=2	#desde columna2 se imprimen espacios
	while [ $columna -lt $tamanio ]; do 
		echo -n " "
		columna=`expr $columna + 1`
	done
	echo -n "*"
	echo "\n"	#salta a siguiente fila *        *
	fila=`expr $fila + 1`
done

#última fila
columna=1
while [ $columna -le $tamanio ]; do	#*********...tamanio
	echo -n "*"
	columna=`expr $columna + 1`
done
echo "\nFin del programa - JPAS"
