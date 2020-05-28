@kv = (2,3,5,10);


for $i (1..100){
    for $k (@kv){
        print "Rscript scripts/sim_qtl_roc_supp.R $k $i\n";
    }

}
