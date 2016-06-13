#:/bin/bash
i=0	#iterador
echo "ROMBO"
echo "Ingrese un numero"
read numero
while [ $i -lt $numero ]; do
	j=0
	a=`expr $numero - $i - 1`
	while [ $j -lt $a ]; do
		echo -n " "
		j=`expr $j + 1`
	done
	j=0
	b=`expr $i \* 2 + 1`
	while [ $j -lt $b ]; do
		echo -n "*"	
		j=`expr $j + 1`
	done
	echo -n "\n"
	i=`expr $i + 1`
done
i=`expr $numero - 2`
while [ $i -ge 0 ]; do
	k=0
	c=`expr $numero - $i - 1`
	while [ $k -lt $c ]; do
		echo -n " "
		k=`expr $k + 1`
	done
	k=0
	d=`expr $i \* 2 + 1`
	while [ $k -lt $d ]; do
		echo -n "*"
		k=`expr $k + 1`
	done
	echo -n "\n"
	i=`expr $i - 1`
done
echo "Fin del programa - JPAS"

