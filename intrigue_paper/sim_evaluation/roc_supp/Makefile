all: setup intrigue summary 
setup: scripts/sim_qtl_roc_supp.R scripts/batch_sim.pl
	perl scripts/batch_sim.pl > scripts/batch_sim.cmd
	openmp_wrapper -d scripts/batch_sim.cmd -t 10 
	if [ ! -d "data" ]; then mkdir data; fi 
	mv sim*.dat data/
intrigue: data/ scripts/run_intrigue.pl
	perl scripts/run_intrigue.pl > scripts/batch_run.cmd
	 if [ ! -d "output" ]; then mkdir output; fi 
	openmp_wrapper -d scripts/batch_run.cmd -t 10 
summary: output/ scripts/get_roc_rep.pl scripts/get_roc_irr.pl scripts/plot_roc.R
	if [ ! -d "results" ]; then mkdir results; fi
	perl scripts/get_roc_rep.pl meta 2 > results/meta_rep_K2.roc.dat
	perl scripts/get_roc_rep.pl cefn 2 > results/cefn_rep_K2.roc.dat
	perl scripts/get_roc_irr.pl meta 2 > results/meta_irr_K2.roc.dat
	perl scripts/get_roc_irr.pl cefn 2 > results/cefn_irr_K2.roc.dat
	perl scripts/get_roc_rep.pl meta 3 > results/meta_rep_K3.roc.dat
	perl scripts/get_roc_rep.pl cefn 3 > results/cefn_rep_K3.roc.dat
	perl scripts/get_roc_irr.pl meta 3 > results/meta_irr_K3.roc.dat
	perl scripts/get_roc_irr.pl cefn 3 > results/cefn_irr_K3.roc.dat
	perl scripts/get_roc_rep.pl meta 5 > results/meta_rep_K5.roc.dat
	perl scripts/get_roc_rep.pl cefn 5 > results/cefn_rep_K5.roc.dat
	perl scripts/get_roc_irr.pl meta 5 > results/meta_irr_K5.roc.dat
	perl scripts/get_roc_irr.pl cefn 5 > results/cefn_irr_K5.roc.dat
	perl scripts/get_roc_rep.pl meta 10 > results/meta_rep_K10.roc.dat
	perl scripts/get_roc_rep.pl cefn 10 > results/cefn_rep_K10.roc.dat
	perl scripts/get_roc_irr.pl meta 10 > results/meta_irr_K10.roc.dat
	perl scripts/get_roc_irr.pl cefn 10 > results/cefn_irr_K10.roc.dat
	Rscript scripts/plot_roc.R
clean: 
	rm -rf output/ data/ results/ scripts/*.cmd
