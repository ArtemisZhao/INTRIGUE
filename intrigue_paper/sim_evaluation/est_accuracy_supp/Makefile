all: setup intrigue summary 
setup: scripts/sim_qtl_supp.R
	Rscript scripts/sim_qtl_supp.R
	if [ ! -d "data" ]; then mkdir data; fi 
	mv sim*.dat data/
intrigue: data/ scripts/run_intrigue.pl
	perl scripts/run_intrigue.pl > scripts/batch_run.cmd
	 if [ ! -d "output" ]; then mkdir output; fi 
	openmp_wrapper -d scripts/batch_run.cmd -t 10 

summary: output/ scripts/estimate.R
	if [ ! -d "results" ]; then mkdir results; fi
	cat output/SS1*meta*.est | grep -v Null > results/SS1.meta.est
	cat output/SS2*meta*.est | grep -v Null > results/SS2.meta.est
	cat output/SS3*meta*.est | grep -v Null > results/SS3.meta.est
	cat output/SS1*cefn*.est | grep -v Null > results/SS1.cefn.est
	cat output/SS2*cefn*.est | grep -v Null > results/SS2.cefn.est
	cat output/SS3*cefn*.est | grep -v Null > results/SS3.cefn.est
	Rscript scripts/estimate.R 
clean: 
	rm -rf output/ data/ results/ scripts/batch_run.cmd
