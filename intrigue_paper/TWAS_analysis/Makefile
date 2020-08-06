all: intrigue plot 
intrigue: data/
	if [ ! -d "output" ]; then mkdir output; fi
	intrigue -d data/GIANT_vs_UKB_Height.muscle.TWAS.zval --zval -prefix output/GIANT_vs_UKB_Height.muscle.TWAS.meta --meta
	intrigue -d data/GIANT_vs_UKB_Height.muscle.TWAS.zval --zval -prefix output/GIANT_vs_UKB_Height.muscle.TWAS.cefn --cefn
	intrigue -d  data/UKB_Height.muscle_vs_blood.TWAS.zval --zval  --cefn  -prefix  output/UKB_Height.muscle_vs_blood.all.TWAS.cefn
	intrigue -d  data/UKB_Height.muscle_vs_blood.TWAS.zval --zval  --meta  -prefix  output/UKB_Height.muscle_vs_blood.all.TWAS.meta
	intrigue -d  data/UKB_Height.muscle_vs_blood.eGene.TWAS.zval --zval --cefn  -prefix output/UKB_Height.muscle_vs_blood.eGene.TWAS.cefn
	intrigue -d  data/UKB_Height.muscle_vs_blood.eGene.TWAS.zval --zval --meta  -prefix output/UKB_Height.muscle_vs_blood.eGene.TWAS.meta
	intrigue -d  data/UKB_Height.blood_vs_GIANT.muscle.eGene.TWAS.zval --zval  --cefn  -prefix  output/UKB_Height.blood_vs_GIANT.muscle.eGene.TWAS.cefn
	intrigue -d  data/UKB_Height.blood_vs_GIANT.muscle.eGene.TWAS.zval --zval  --meta  -prefix  output/UKB_Height.blood_vs_GIANT.muscle.eGene.TWAS.meta
	intrigue -d  data/UKB_Height.blood_vs_GIANT.muscle.TWAS.zval --zval  --cefn  -prefix  output/UKB_Height.blood_vs_GIANT.muscle.all.TWAS.cefn
	intrigue -d  data/UKB_Height.blood_vs_GIANT.muscle.TWAS.zval --zval  --meta  -prefix  output/UKB_Height.blood_vs_GIANT.muscle.all.TWAS.meta
	intrigue -d  data/UKB_Height.muscle_subsample_vs_blood.TWAS.zval --zval  --cefn  -prefix  output/UKB_Height.muscle_subsample_vs_blood.all.TWAS.cefn
	intrigue -d  data/UKB_Height.muscle_subsample_vs_blood.TWAS.zval --zval  --meta  -prefix  output/UKB_Height.muscle_subsample_vs_blood.all.TWAS.meta
	intrigue -d  data/UKB_Height.muscle_subsample_vs_blood.eGene.TWAS.zval --zval --cefn  -prefix output/UKB_Height.muscle_subsample_vs_blood.eGene.TWAS.cefn
	intrigue -d  data/UKB_Height.muscle_subsample_vs_blood.eGene.TWAS.zval --zval --meta  -prefix output/UKB_Height.muscle_subsample_vs_blood.eGene.TWAS.meta
analysis: scripts/plot_gwas.R scripts/plot_tissue.R scripts/gwas_power.R scripts/cochran.R
	if [ ! -d "results" ]; then mkdir results; fi
	Rscript scripts/plot_gwas.R
	Rscript scripts/plot_tissue.R
	Rscript scripts/gwas_power.R 
	Rscript scripts/cochran.R
idr:
	echo "warning: this analysis can take very long time for convergence issues ..."
	Rscript scripts/idr_twas.R
clean:
	rm -rf output 
