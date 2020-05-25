all: setup intrigue summary 
setup: scripts/sim_qtl.R
	Rscript scripts/sim_qtl.R
	if [ ! -d "data" ]; then mkdir data; fi 
	mv sim*.dat data/
intrigue: data/ scripts/run_intrigue.pl
	perl scripts/run_intrigue.pl > scripts/batch_run.cmd
	 if [ ! -d "output" ]; then mkdir output; fi 
	openmp_wrapper -d scripts/batch_run.cmd -t 10 

summary: output/ scripts/estimate.R
	if [ ! -d "results" ]; then mkdir results; fi
	cat output/S1*meta*.est | grep -v Null > results/S1.meta.est
	cat output/S2*meta*.est | grep -v Null > results/S2.meta.est
	cat output/S3*meta*.est | grep -v Null > results/S3.meta.est
	cat output/S1*cefn*.est | grep -v Null > results/S1.cefn.est
	cat output/S2*cefn*.est | grep -v Null > results/S2.cefn.est
	cat output/S3*cefn*.est | grep -v Null > results/S3.cefn.est
	Rscript scripts/estimate.R 
clean: 
	rm -rf output/ data/ results/ scripts/batch_run.cmd
