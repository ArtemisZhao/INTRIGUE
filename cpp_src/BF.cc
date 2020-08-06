#include "BF.h"
#include <math.h>
#include <gsl/gsl_integration.h>
#include <gsl/gsl_cdf.h>
#include <stdio.h>
#define PI 3.1415926535
#define BASELINE 1


using namespace std;

double target_f (double x, void *params){

    double *p = (double *)params;
    int size = int(p[0]);
    double k2 = p[1];
    double oa2 = p[2];
    double val = BASELINE;
    for(int i=0;i<size;i++){
        double ds2 = pow(p[2*i+5],2.0);
        double beta = p[2*i+4];

        double num2 = pow(beta-x,2);
        double dnum = ds2 + k2*x*x;

        double fac = 1.0/(2*PI*dnum);
        val *= sqrt(fac)*exp(-0.5*num2/dnum);
    }
    val *= (1.0/sqrt(2*PI*oa2))*exp(-.5*x*x/oa2);
    return val;

}


int BF::prepare_params(double k2, double oa2){

    // find non-informative sets
    int info_size = 0;

    for(int i=0;i<sd_vec.size();i++){
        if(sd_vec[i] > 0)
            info_size++;
    }


    if(info_size==0)
        return info_size;



    param_list = new double[2*info_size+4];

    param_list[0] = info_size;
    param_list[1] = k2;
    param_list[2] = oa2;
    param_list[3] = BASELINE;
    double val = 0;
    int i=0;
    for(int j=0;j<bhat_vec.size();j++){

        if(sd_vec[j]<= 0)
            continue; 
        param_list[2*i+4] = bhat_vec[j];
        param_list[2*i+5] = sd_vec[j];
        i++;
    }

    return info_size;
}


double BF::compute_log10_BF_cefn(double k2, double oa2){

    if(oa2<1e-7)
        oa2 = 1e-7;

    int info_size = prepare_params(k2,oa2);

    if(info_size==0)
        return 0.0;

    // numerical integration
    gsl_integration_workspace *w = gsl_integration_workspace_alloc (5000);
    double result, error;
    gsl_function F;
    F.function = &target_f;
    F.params = param_list;

    gsl_integration_qagi (&F, 0, 1e-7, 5000,w, &result, &error); 

    gsl_integration_workspace_free (w);
    double log10_BF;

    if(result==0){
        log10_BF = appx_log10_BF(param_list);
    }else{
        log10_BF = log10(result)-log10_null_lik;
    }


    delete[] param_list;
    return  log10_BF;

}


double BF::appx_log10_BF(void *params){

    double *p = (double *)params;
    int size = int(p[0]);
    double k2 = p[1];
    double oa2 = p[2];

    double phi2 = oa2*k2;

    

    double bm = 0;
    double vm2 = 0;
    double sumw = 0;
    double log10_ABF = 0;
    for(int i=0;i<size;i++){
        double ds2 = pow(p[2*i+5],2.0);
        double w = 1/(ds2 + phi2);
        double beta = p[2*i+4];
        bm += beta*w;
        sumw += w;
        vm2 += w;;
        log10_ABF += 0.5*log(ds2/(ds2+phi2))+0.5*(pow(beta,2)/ds2)*(phi2/(ds2+phi2));
    }
    bm = bm/sumw;
    vm2 = 1/vm2;
    log10_ABF += 0.5*log(vm2/(oa2+vm2))+0.5*(pow(bm,2)/vm2)*(oa2/(vm2+oa2));

    return log10_ABF/log(10);

}


double BF::compute_log10_BF_meta(double phi2, double oa2){
    
    double bm = 0;
    double vm2 = 0;
    double sumw = 0;
    double log10_BF = 0;
    for(int i=0;i< bhat_vec.size() ;i++){
        double ds2 = pow(sd_vec[i],2.0);
        if(ds2 == 0)
            continue;
        double w = 1/(ds2 + phi2);
        double beta = bhat_vec[i];
        bm += beta*w;
        sumw += w;
        vm2 += w;;
        log10_BF += 0.5*log(ds2/(ds2+phi2))+0.5*(pow(beta,2)/ds2)*(phi2/(ds2+phi2));
    }
    bm = bm/sumw;
    vm2 = 1/vm2;
    log10_BF += 0.5*log(vm2/(oa2+vm2))+0.5*(pow(bm,2)/vm2)*(oa2/(vm2+oa2));

    return log10_BF/log(10);


}



vector<double> BF::compute_log10_BF(vector<double> & bhat, vector<double> & sd, vector<double> & k2_vec, vector<double> &omg2_vec){

    bhat_vec = bhat;
    sd_vec = sd;
    vector<double> rst_vec;
    log10_null_lik = 0;
    if(use_cefn){
        for(int i=0;i<bhat_vec.size();i++){
            double b = bhat_vec[i];
            double v=  pow(sd_vec[i],2);
            if(v==0)
                continue;
            log10_null_lik += (-0.5*log(2*PI*v) -0.5*b*b/v)/log(10);
        }   
    }

    for(int i=0;i<k2_vec.size();i++){
        double rst = 0;
        if(!use_cefn){
            rst = compute_log10_BF_meta(k2_vec[i], omg2_vec[i]);
        }else{
            rst = compute_log10_BF_cefn(k2_vec[i], omg2_vec[i]);
        }
        rst_vec.push_back(rst);
    }

    return rst_vec;

}


