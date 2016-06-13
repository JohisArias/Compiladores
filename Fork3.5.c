//Programa3.5. Programa que crea un proceso.
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
main ()
{
	pid_t pid;
	pid = fork();
 
	switch(pid) 
	{
		case -1: /* error del fork()*/
			perror("fork");
			break;
		case 0: /* proceso hilo */
			printf("Proceso %d; padre = %d\n", getpid(), getppid());
		 	break;
		default: /* padre */
			printf("Proceso %d; padre = %d\n", getpid(), getppid());
	}//fin switch
}//fin main
