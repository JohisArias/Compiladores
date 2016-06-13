//Ejercicio 5 (hojas)
#include<errno.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
int main()
{
	int pid;
	int i;
	int estado;
	pid=fork();
	switch(pid)
	{
		case -1:
			printf("No se ha podico crear el proceso hijo\n");
			break;
		case 0:
			for(i=0;i<10;i++)
			{
				printf("Soy el hijo, mi PID es %d\n", getpid());
			}
			break;
		default:	
			for(i=0;i<10;i++)
			{
				printf("Soy el padre, mi PID es %d\n", getppid());
			}
			wait(estado);
			printf("Mi proceso hijo ya ha terminado\n");
	}//fin switch
}//fin main
