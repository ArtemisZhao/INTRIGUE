using namespace std;

#include <vector>
#include <string>
#include "GenEM_mixture.h"

class controller {

    public:
        
        void load_data(char *data_filei, int use_zval);
        void run_EM(double thresh=0.1);              
        void set_scale(double val){ scale = val; };
        void set_bf_only (int bf_only_value){ bf_only = bf_only_value;};
        void set_sample_size(vector<int> & ssize){ sample_size_vec = ssize; };
        void set_prior_type(int cefn_option) { use_cefn = cefn_option; };
        void set_prefix(char *str);

    private:

        int K;
        int N;
        
        vector<int> sample_size_vec;

        double scale; // define the minimum sig-to-noise ratio
        int use_cefn;
        int bf_only;
        vector<string> loc_vec;
        
        vector<double> het_vec; // heterogeneity parameter, defined by either k (cefn prior) or r (meta prior)
        vector<double> eff_vec;
        

        double prob_thresh;

        string prefix;

        vector<double> omg2_vec;
        vector<double> k2_vec;
        vector<double> prob_vec; // correpsonding prob values for heterogeneity parameters_

        vector<vector<double> > log10_BF_matrix;

        GenEM_mixture gem;

        void make_grid(double min, double max);
        void make_grid2(double min, double max);
        double log10_weighted_BF(vector<double> &bf_vec);
        void show_BF();

};

