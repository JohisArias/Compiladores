#:/bin/bash
#
modulo=0
auxiliar=0
echo "CONJETURA DE COLLATZ"
echo "Ingrese un numero"
read numero
echo "La orbita es"
echo "$numero"
while [ $numero -ne 1 ]; do
	modulo=`expr $numero % 2 `
	if [ $modulo -eq 0 ]; then	#si es par
		numero=`expr $numero \/ 2`
		echo "$numero"
	else				#si es impar
		auxiliar=`expr $numero \* 3`
		numero=`expr $auxiliar + 1`
		echo "$numero"
	fi
done
echo "Fin del programa - JPAS"
