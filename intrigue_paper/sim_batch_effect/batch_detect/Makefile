all: setup intrigue analysis
setup: scripts/batch_sim.pl scripts/sim_batch_detect.R
	perl scripts/batch_sim.pl > scripts/batch_sim.cmd
	openmp_wrapper -d scripts/batch_sim.cmd -t 10 
	if [ ! -d "data" ]; then mkdir data; fi
	mv sim*.dat data/
intrigue: data/ scripts/run_intrigue.pl
	perl scripts/run_intrigue.pl > scripts/batch_run.cmd
	if [ ! -d "output" ]; then mkdir output; fi
	openmp_wrapper -d scripts/batch_run.cmd -t 10 
analysis: output/ scripts/summarize_meta.pl scripts/summarize_cefn.pl scripts/ks_test.R scripts/batch_ks_test.pl scripts/plot_detection.R
	if [ ! -d "results" ]; then mkdir results; fi
	perl scripts/summarize_cefn.pl > results/cefn.detect.out
	perl scripts/summarize_meta.pl > results/meta.detect.out
	perl scripts/batch_ks_test.pl | sort -nk1 > results/2sample.ks.out
	Rscript scripts/plot_detection.R
clean:
	rm -rf data/ output/ results/ scripts/*.cmd

