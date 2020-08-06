all: simdata intrigue plot
simdata: scripts/sim_data_bias.R scripts/sim_data_unbias.R
	if [ ! -d "output" ]; then mkdir output; fi
	Rscript scripts/sim_data_bias.R
	Rscript scripts/sim_data_unbias.R
	mv bias.dat unbias.dat output/
intrigue: output/bias.dat output/unbias.dat
	intrigue -d output/unbias.dat --meta --bf -prefix output/unbias_dat -n 200,4000
	intrigue -d output/bias.dat --meta --bf -prefix output/bias_dat -n 200,4000
	intrigue -d output/unbias.dat  --bf -prefix output/unbias_dat.cefn -n 200,4000
	intrigue -d output/bias.dat  --bf -prefix output/bias_dat.cefn -n 200,4000
plot: output/
	if [ ! -d "results" ]; then mkdir results; fi
	Rscript scripts/plot.R
clean:
	rm -rf output results
