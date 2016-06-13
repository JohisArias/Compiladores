//Ejercicio 3 (hojas)
#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>
void main()
{
	pid_t pid;
	int i;
	int n=10;
	for(i=0; i<n; i++)
	{
		pid=fork();
		if(pid==0)
		{
			printf("PROCESO NUMÉRICO: %d\t PID: %d\n", i, getpid());
			break;
		}
	}
	printf("EL padre del proceso es %d\n", getppid());
	
}//fin main
