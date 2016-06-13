//Ejercicio 4 (hojas)
#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>
void main()
{
	printf("EL ejemplo de proceso huérfano \n");
	printf("Inicio del proceso padre, PID %d\n", getppid());

	if (fork==0)
	{
		printf("Inicio del proceso hijo, PID %d\n, PPID %d\n", getpid(), getppid());
		sleep(1);
		printf("El proceso huéfano, PID %d\n, PPID %d\n", getpid(), getppid());
	}
	else
	{
		printf("Continuación del padre, PPID %d\n", getppid());
		printf("Fin del proceso %d\n", getpid());
	}
}//fin main
