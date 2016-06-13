#:/bin/bash

i=1	#iteracion para el bucle
c=0	#contador
auxiliar=0
n=0	#de formula original
echo "CUADRADO DE UN NUMERO"
echo "Ingrese el numero del que desea el cuadrado"
read numero

auxiliar=`expr $numero \* 2`	#2n
n=`expr $auxiliar - 1`		#2n-1
while [ $i -le $n ]; do
	c=`expr $c + $i`
	i=`expr $i + 2`
done

echo "El cuadrado de $numero es $c"
echo "Fin del programa - JPAS"
