#:/bin/bash
#
i=1
echo "DIVISORES DE UN NUMERO"
echo "Ingrese un numero"
read numero
echo "Los divisores de $numero son: "
while [ $i -le $numero ]; do
	n=`expr $numero % $i`
	if [ $n -eq 0 ]; then
		echo "$i \t"
	fi
	i=`expr $i + 1`
done	
echo "Fin del programa - JPAS"
