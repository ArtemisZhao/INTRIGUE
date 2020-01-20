using namespace std;

#include <vector>

class BF {

    private:

        vector<double> bhat_vec;
        vector<double> sd_vec;
        double *param_list;
        double log10_null_lik;
        
        // compute CEFN BF
        double compute_log10_BF_cefn(double k2, double oa2);
        double appx_log10_BF(void *params);    
        int prepare_params(double k2, double oa2);
        
        // compute META BF
        double compute_log10_BF_meta(double phi2, double oa2);

    
        // BF option
        int use_cefn;
    
    public:

        vector<double> compute_log10_BF(vector<double> &beta_vec, vector<double> &sde_vec, vector<double> &het_vec, vector<double> &omg2_vec);
        
        void set_cefn (int use_cefn_){
            use_cefn = use_cefn_;
        }
};

double target_f (double x, void *params);
