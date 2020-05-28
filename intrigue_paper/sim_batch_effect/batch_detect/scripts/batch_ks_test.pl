@files = <data/*.dat>;
foreach $f (@files){
    $f =~/batch\_(\S+)\.dat/;
    $mag = $1;
    $out = `Rscript scripts/ks_test.R $f`;
    $out =~/\]\s*(\S+)\s*/;
    printf "%.2f  $1\n", $mag;
}
