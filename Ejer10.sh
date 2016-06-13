#:/bin/bash

i=0		#iterador
auxiliar1=0
auxiliar2=0
cont=0		#contador de palindromos
echo "NUMEROS PALINDROMOS"
echo "Ingrese el limite inferior"
read inferior
echo "Ingrese el limite superior"
read superior

echo "Los palindromos entre $inferior y $superior son"
i=`expr $inferior`
while [ $i -lt $superior ]; do
	auxiliar1=`expr $i`
	auxiliar2=0
	while [ $auxiliar1 -gt 0 ]; do
		A=`expr $auxiliar2 \* 10`
		B=`expr $auxiliar1 % 10`
		auxiliar2=`expr $A + $B`
		auxiliar1=`expr $auxiliar1 \/ 10`
	done
	if [ $auxiliar2 -eq $i ]; then
		echo "$auxiliar2"
		cont=`expr $cont + 1`
	fi

	i=`expr $i + 1`	#aumenta iterador
done

echo "Existen $cont palindromos"
echo "Fin del programa -JPAS"
