//Programa 3.10. Programa que ejecuta el mandato recibido en la línea de mandatos.
#include<sys/types.h>
#include<stdio.h>
#include<stdlib.h>
main(int argc, char **argv)
{
	int status;
	char **argumentos;
	
	argumentos=&argv[1];
	pid_t pid = fork();
	switch(pid)
	{
		case -1: /* error del fork() */
			exit(-1);
		case 0: /* proceso hijo */
			if (execvp(argv[1], &argv[1]) < 0)
			sleep(2);
				excevp(argumentos[0], argumentos);
			perror("exec");
		default: /* padre */
			printf ("Proceso padre %d\n", getppid());
	}//fin switch
}//fin main
