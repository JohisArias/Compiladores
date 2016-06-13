//Ejercicio 2 (hojas)
#include<stdio.h>
#include<unistd.h>
int main()
{
	int pid;
	printf("Padre: soy el proceso padre y mi PID es %d\n", getppid());
	pid = fork();
	if(pid != 0)
		printf("Padre: soy el proceso padre y mi PID sigue siendo %d\n", getppid());
	else
		printf("Hijo: soy el proceso hijo y mi PID es %d\n", getpid());
		printf("Hijo: mi padre tiene el PID %d\n", getppid());
}//fin main
