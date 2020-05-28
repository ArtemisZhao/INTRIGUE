@files = <data/sim*.dat>;
foreach $f (@files){

    $f =~/batch\_(\S+)\.dat/;
    $eff = $1;
    print "intrigue -d data/sim_batch\_$eff.dat --cefn -n 40 -prefix output/batch\_$eff.cefn\n";
    print "intrigue -d data/sim_batch\_$eff.dat --meta -n 40 -prefix output/batch\_$eff.meta\n";
}
