@files = <data/*.brm.dat>;
foreach $f (@files){
    $f =~/batch\_(\S+)\.brm\.dat/;
    $mag = $1;
    $out = `Rscript scripts/ks_test.R $f`;
    $out =~/\]\s*(\S+)\s*/;
    $p1 = $1;

    $out = `Rscript scripts/ks_test.R data/sim\_batch\_$mag\.dat`;
    $out=~/\]\s*(\S+)\s*/;
    printf "%.2f  $1  $p1\n", $mag;
}
