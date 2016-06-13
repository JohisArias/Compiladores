//Programa3.12. Programa que imprime información sobre el estado de terminación de un proceso hijo
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
main(int argc, char **argv)
{
	pid_t pid;
	int valor;
	pid = fork();
	pid_t wait(int *status);
	switch(pid)
	{
		case -1: /* error del fork */
			exit(-1);
      		case 0: /* proceso hijo */
			if (execvp(argv[1], &argv[1]) < 0) 
                  		perror("exec");
      		default: /* padre */
			while(wait(&valor) != pid)
			{
				if (valor == 0) 
					printf("El mandato se ejecutó de forma normal\n");
				else
				{
					if (WIFEXITED(valor))
						printf("El hijo terminó normalmente y su valor devuelto fue %d\n", WEXITEDSTATUS(valor));
					if (WIFSIGNALED(valor))
						printf("El hijo terminó al recibir la señal %d\n", WTERMSIG(valor));
				} //else
			}//fin while
	} //switch
}//fin main

