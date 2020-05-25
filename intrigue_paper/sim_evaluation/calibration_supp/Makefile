all: setup intrigue summary 
setup: scripts/sim_qtl_supp.R
	Rscript scripts/sim_qtl_supp.R
	if [ ! -d "data" ]; then mkdir data; fi 
	mv sim*.dat data/
intrigue: data/ scripts/run_intrigue.pl
	perl scripts/run_intrigue.pl > scripts/batch_run.cmd
	 if [ ! -d "output" ]; then mkdir output; fi 
	openmp_wrapper -d scripts/batch_run.cmd -t 10 

summary: output/ scripts/cali_rep.pl scripts/plot_cali.R
	if [ ! -d "results" ]; then mkdir results; fi
	perl scripts/cali_rep.pl meta | sort -grk2 > results/cali_rep_SS4.meta.sort.dat
	perl scripts/cali_rep.pl cefn | sort -grk2 > results/cali_rep_SS4.cefn.sort.dat
	Rscript scripts/plot_cali.R
	mv *.pdf results/
clean: 
	rm -rf output/ data/ results/ scripts/batch_run.cmd
