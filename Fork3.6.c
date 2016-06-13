//Programa 3.6. Programa que crea la cadena de procesos de la Figura 3.34.
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
main ()
{
	pid_t pid;
	int i;
	int n = 10;
	for (i = 0; i < n; i++)
	{
		pid = fork();
		if (pid!= 0)//proeso padre
			break;
	}
	printf("E1 padre del proceso %d es %d\n", getpid(), getppid());
}
