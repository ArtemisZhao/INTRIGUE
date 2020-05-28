#include "GenEM.h"

class GenEM_mixture : public GenEM {

    private:

        int K; // number of parameters

        vector<double> wts_matrix; //  (Kx1)
        vector<double> BF_avg;     //  (Nx1)
        vector<vector<double> > P_matrix;   //  (NxK) 

        void EM_init(vector<vector<double> >& BF_in, vector<double> & init_wts);
        vector<double> pseudo_count_vec;
        double EM_update();

        double pseudo_count;

    public:

        double EM_run(vector<vector<double> >& BF_in, vector<double> & init_wts, double thresh,double pseudo = 0);
        vector<double> get_estimate(){
            return wts_matrix;
        }
        double compute_loglik(vector<double> & input_wts);
        vector<vector<double> > get_P_matrix(){
            return P_matrix;
        }

};


