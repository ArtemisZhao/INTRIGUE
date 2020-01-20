using namespace std;

#include <iostream>
#include <fstream>
#include <sstream>
#include <string.h>
#include <math.h>
#include <algorithm>
#include "controller.h"
#include <gsl/gsl_cdf.h>
#include "BF.h"

#define NINF -999999

void controller::load_data(char *filename, int use_zval){


    ifstream dfile(filename);
    string line;
    istringstream ins;


    string loc_id;
    double beta;
    double se_beta;

    int loc_count = 0;


    vector<double> rcd_b2;
    vector<double> rcd_v2;

    vector<vector<double> > beta_matrix;
    vector<vector<double> > se_matrix;

    while(getline(dfile,line)){
        ins.clear();
        ins.str(line);

        ins>>loc_id;
        loc_vec.push_back(loc_id);

        vector<double> beta_vec;
        vector<double> se_vec;

        while(ins >> beta){
            if(!use_zval)
                ins>>se_beta;
            else 
                se_beta = 1;

            if(use_zval == -1) // pvalue is used
                beta = gsl_cdf_ugaussian_Qinv (beta/2);


            beta_vec.push_back(beta);
            se_vec.push_back(se_beta);
            rcd_b2.push_back(pow(beta,2));
            rcd_v2.push_back(pow(se_beta,2));
        }

        beta_matrix.push_back(beta_vec);
        se_matrix.push_back(se_vec);
    }

    dfile.close();

    // set the grid for overall effect size: (k+1)*omg2 or (r+1)*omg2
    std::sort(rcd_b2.begin(), rcd_b2.end());
    std::sort(rcd_v2.begin(), rcd_v2.end());

    int index1 = int(rcd_v2.size()/2);
    int index2 = int(0.9*rcd_b2.size());
    double phi_max = sqrt(rcd_b2[index2]);
    double phi_min = sqrt(scale*rcd_v2[index1]);
    
    if(phi_max<phi_min){
        phi_max = phi_min;
    }

    make_grid(phi_min, phi_max);
    K = k2_vec.size()+1;
    N = beta_matrix.size();



    // compute BF factors


    BF bfc;
    bfc.set_cefn(use_cefn);
    for(int i=0;i<N;i++){

        vector<double> bf_vec = bfc.compute_log10_BF(beta_matrix[i], se_matrix[i], k2_vec, omg2_vec);
        bf_vec.insert(bf_vec.begin(),0.0);
        log10_BF_matrix.push_back(bf_vec);

    }
}


void controller::make_grid(double phi_min, double phi_max){

    eff_vec.push_back(pow(phi_min,2)); //phi_max
    double phi = phi_min;
    while(phi <= phi_max){
        phi = phi*sqrt(2);
        eff_vec.push_back(phi*phi); //phi
    }
    std::sort(eff_vec.begin(),eff_vec.end());
    

    // fixed value corresponds DC probility values: 0.999, 0.975, 0.95, 0.90, 0.80, 0.70, 0.60

    vector<double> dc_prob_vec = vector<double>{0.99, 0.975, 0.95, 0.75, 0.70, 0.65};
    if(use_cefn){
        het_vec = vector<double>{0.105, 0.260, 0.369, 2.198, 3.636,  6.735};
    }else{
        het_vec = vector<double>{0, 6e-3, 0.024, 0.500, 0.655, 0.795};
    }
    
    prob_thresh = 0.90;


    double max = 0;
    for(int j=0;j<het_vec.size();j++){
        for(int i=0;i<eff_vec.size();i++){
            if(use_cefn){
                
                double omg2 = eff_vec[i];
                //double omg2 = eff_vec[i]/(1+het_vec[j]);
                
                k2_vec.push_back(het_vec[j]);
                omg2_vec.push_back(omg2);
                
                prob_vec.push_back(dc_prob_vec[j]);


                if((1+het_vec[j])*omg2 > max){
                    max = (1+het_vec[j])*omg2;
                }

            }else{
                
                double omg2 = eff_vec[i];
                double k2 = omg2*het_vec[j]/(1-het_vec[j]);
                k2_vec.push_back(k2);
                
                /*
                k2_vec.push_back(eff_vec[i]*het_vec[j]);
                double omg2 = eff_vec[i]*(1-het_vec[j]);
                */
    
                omg2_vec.push_back(omg2);
            

                prob_vec.push_back(dc_prob_vec[j]);

                if(omg2+k2 > max){
                    max = k2+omg2;
                }


            }
        }   
    }

    // grid to have the same overall large effect for better classification of large-effect observations
    double max_eff = 2*max;
    for(int j=0;j<het_vec.size();j++){
        if(use_cefn){
            double omg2 = max_eff/(1+het_vec[j]);
            k2_vec.push_back(het_vec[j]);
            omg2_vec.push_back(omg2);

            prob_vec.push_back(dc_prob_vec[j]);
        }else{
            k2_vec.push_back(max_eff*het_vec[j]);
            double omg2 = max_eff*(1-het_vec[j]);
            omg2_vec.push_back(omg2);


            prob_vec.push_back(dc_prob_vec[j]);
        }
    }

    return;

}


void controller::run_EM(double thresh){

    vector<double> wts_vec(K, 0.05/(K-1));
    wts_vec[0] = 0.95;
    double final_loglik = gem.EM_run(log10_BF_matrix, wts_vec, thresh);


    wts_vec = gem.get_estimate();
    double null_prob = wts_vec[0];
    double rep_prob = 0;
    double irp_prob = 0;
    for(int i=1;i<wts_vec.size();i++){
        if(prob_vec[i-1]>=prob_thresh)
            rep_prob += wts_vec[i];
        else
            irp_prob += wts_vec[i];
    }


    string  est_file = prefix + string("intrigue.est");
    FILE *fd = fopen(est_file.c_str(), "w");
    //fprintf(stderr, "\n\n%15s %7.3f\n%15s %7.3f\n%15s %7.3f\n\n", "Null:", null_prob, "Reproducible:", rep_prob, "Irreproducible:", irp_prob);;
    fprintf(fd, "Null\tIrreproducible\tReproducible\n");
    fprintf(fd, "%7.3e\t%7.3e\t%7.3e\n", null_prob, irp_prob, rep_prob);
    fclose(fd);

    // get posterior probabilities
    vector<vector<double> > P_matrix = gem.get_P_matrix();
    string pip_file = prefix + string("intrigue.pip");
    fd = fopen(pip_file.c_str(), "w");
    
    fprintf(fd, "Gene\tnull_prob\tirrep_prob\trep_prob\n"); 
    //vector<double> rp_vec;
    for(int i=0;i<N;i++){
        double rep_prob = 0;
        double irp_prob = 0;
        for(int k=1;k<K;k++){
            if(prob_vec[k-1]>=prob_thresh)
                rep_prob += P_matrix[i][k];
            else
                irp_prob += P_matrix[i][k];
        }

        fprintf(fd, "%10s   %7.3e %7.3e %7.3e\n", loc_vec[i].c_str(), P_matrix[i][0], irp_prob, rep_prob );
    }

    fclose(fd);


}

void controller::set_prefix(char *str){

    if(strlen(str) == 0){
        prefix = string("");
    }else{
        prefix = string(str)+string(".");
    }
}



