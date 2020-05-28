@files = <data/sim*.brm.dat>;
foreach $f (@files){

    $f =~/batch\_(\S+)\.brm.dat/;
    $eff = $1;
    print "intrigue -d $f --cefn -n 40 -prefix output/batch\_$eff.brm.cefn\n";
    print "intrigue -d data/sim_batch\_$eff.dat --cefn -n 40 -prefix output/batch\_$eff.cefn\n";
    print "intrigue -d $f --meta -n 40 -prefix output/batch\_$eff.brm.meta\n";
    print "intrigue -d data/sim_batch\_$eff.dat --meta -n 40 -prefix output/batch\_$eff.meta\n";
}
