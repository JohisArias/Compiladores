//Programa 3.8. Programa que ejecuta el mandato ls —l.
#include<sys/types.h>
#include<stdio.h>
#include<stdlib.h> //para la función exit
#include<unistd.h>
int main()
{
	pid_t pid;
	int status;
	pid = fork();
	switch(pid)
	{
		case -1: /* error del fork() */
			exit(-1);
		case 0 :/* proceso hijo */
			execlp("ls", "ls", "-l" , NULL);
			perror("Error");
			break;
		default: /* padre */
			printf ("Proceso padre %d\n", getppid());
	}//fin switch
}//fin main
