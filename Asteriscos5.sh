#:/bin/bash
fila=1

echo "TRIÁNGULO RECTÁNGULO IZQUIERDO"
echo "Ingrese la altura"
read altura
while [ $fila -le $altura ]; do
	columna=1
	while [ $columna -le $fila ]; do
		echo -n "* "
		columna=`expr $columna + 1`
	done
	echo "\n"
	fila=`expr $fila + 1`
done
echo "Fin del programa - JPAS"
