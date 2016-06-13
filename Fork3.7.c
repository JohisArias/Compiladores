//Programa 3.7. Programa que crea la estructura de procesos de la Figura 3.35.
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
main()
{
	pid_t pid;
	int i;
	int n = 10;
	for (i = 0; i < n; i++)
	{
		pid = fork();
		if (pid== 0)//proceso hijo
		break;
	}
	printf("El padre del proceso %d es %d\n", getpid(), getppid());
}
