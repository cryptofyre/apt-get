#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define pacman_install "pacman -S "
#define pacman_remove "pacman -Rs "
#define confirm " --noconfirm"


int cmdV(const char *command) {

  FILE *fp;
  char path[1035];

  /* Open the command for reading. */
  fp = popen(command, "r");
  if (fp == NULL) {
    printf("Failed to run command\n" );
    exit(1);
  }

  /* Read the output a line at a time - output it. */
  while (fgets(path, sizeof(path), fp) != NULL) {
    printf("%s", path);
  }

  /* close */
  pclose(fp);

  return 1;
}

void help(){
    printf("usage: \n");
    printf("apt-get <install|remove> package\n");
    exit(0);
}

int main(int argc, const char* argv[]){
    puts("APT wrapper by Brandon Plank v1.1");
    const char* todo_cmd = argv[1];

    if(argc<3){
        help();
    }

    char finished[10000];   // big
    if(strcmp(todo_cmd, "install")==0){
        strcpy(finished,pacman_install); // copy string one into the result.
        for(int i = 0; i<argc; i++){
            if(argv[i] > argv[1]){
                strcat(finished,argv[i]);
                strcat(finished, " ");
            }
        }
    } else if (strcmp(todo_cmd, "remove")==0){
        strcpy(finished,pacman_remove); // copy string one into the result.
        for(int i = 0; i<argc; i++){
            if(argv[i] > argv[1]){
                strcat(finished,argv[i]);
                strcat(finished, " ");
            }
        }
    } else {
        help();
    }

    strcat(finished, confirm);
    cmdV(finished);
    return 0;
}
