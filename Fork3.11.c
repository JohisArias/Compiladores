//Programa 3.11. Ejemplo de utilización de exit y atexit.
#include <stdio.h>
#include <stdlib.h>
void fin(void)
{
	printf("Fin de la ejecución del proceso %d\n", getpid());
	return;
}//fin fin()

void main(void)
{
	if (atexit(fin)!=0)
	{
		perror("atexit");
		exit(1);
	}//fin if
	exit(0);//provoca la ejecución de la función fin
}//fin main

