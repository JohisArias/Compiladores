#:/bin/bash

factorial=5
res=0
echo "FACTORIAL DE UN NÚMERO"
while [ $factorial -gt 1 ]; do
	res=`expr $res \* $factorial`
	factorial=`expr $factorial- 1`
	echo "$res"
done
echo "Fin del programa - JPAS"
	
