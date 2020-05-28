#include <fstream>
#include <sstream>
#include <vector>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "controller.h"

#define LENGTH 1024

void show_banner(){

}



int main(int argc, char **argv){

    // creating the grid

    //olist.push_back(0.1);
    //phlist.push_back(0.05);

    char data_file[LENGTH];
    char prefix[LENGTH];

    double EM_thresh = 0.1;
    
    memset(data_file,0, LENGTH);
    memset(prefix, 0, LENGTH);
    
    int use_zval = 0;
    double scale = 1.0; 
    
    int use_cefn = 1;
    int bf_only = 0;

    // sample size
    vector<int> ssize_vec;

    for(int i=1;i<argc;i++){

        if(strcmp(argv[i], "-d")==0 || strcmp(argv[i], "-data")==0){
            strcpy(data_file,argv[++i]);
            continue;
        }


        if(strcmp(argv[i], "--zval")==0 ){
            use_zval = 1;
            continue;
        }


        if(strcmp(argv[i], "--use_cefn")==0 || strcmp(argv[i], "--cefn")==0){
            use_cefn = 1;
            continue;
        }


        if(strcmp(argv[i], "--use_meta")==0 || strcmp(argv[i], "--meta")==0){
            use_cefn = 0;
            continue;
        }


        if(strcmp(argv[i], "--BF")==0 || strcmp(argv[i], "--bf")==0){
            bf_only = 1;
            continue;
        }



        if(strcmp(argv[i], "-scale")==0 ){
            scale = atof(argv[++i]);
            continue;
        }


        if(strcmp(argv[i], "-t")==0 || strcmp(argv[i], "-thresh") ==0 ){
            EM_thresh = atof(argv[++i]);
            continue;
        }
        
        if(strcmp(argv[i], "-prefix")==0){
            strcpy(prefix,argv[++i]);
            continue;
        }


        if(strcmp(argv[i], "-n")==0 || strcmp(argv[i], "-N")==0){
            char *str = argv[++i];
            const char s[2] = ","; 
            char *token = strtok(str, s);
        
            ssize_vec.push_back(atoi(token));
            while(1) {
                token = strtok(NULL, s);
                if(token != NULL){
                    ssize_vec.push_back(atoi(token));
                }else{
                    break;
                }
            }

            continue;
        }


        fprintf(stderr, "Error: undefined option %s\n", argv[i]);
        show_banner();
        exit(0);

    }    


    // checking mandatory arguments
    if(strlen(data_file)==0){
        fprintf(stderr,"Error: data file unspecified\n");
        show_banner();
        exit(0);
    }


    // a global variable 
    controller con;

    fprintf(stderr, "Loading data ...\n");
    con.set_prefix(prefix);
    con.set_scale(scale);
    con.set_bf_only(bf_only);
    con.set_prior_type(use_cefn);
    con.set_sample_size(ssize_vec);
    con.load_data(data_file, use_zval);
    if(!bf_only)
        fprintf(stderr, "Starting EM algorithm ...\n");
    con.run_EM(EM_thresh);

}
