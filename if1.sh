#:/bin/bash
echo "Número mayor"

echo "Ingrese primer número "; read num1
echo "Ingrese segundo número "; read num2

if [ $num1 -gt $num2 ]; then
	echo "El mayor es $num1"
else
	echo "EL mayor es $num2"
fi

echo "Fin del programa -JPAS"
