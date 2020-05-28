for ($i=0;$i<=2.01;$i+=0.1){

    $out1 = `perl scripts/fdr.pl  output/batch\_$i.cefn.intrigue.pip`;
    chomp $out1;
    $out2 = `perl scripts/fdr.pl  output/batch\_$i.brm.cefn.intrigue.pip`;
    printf "%.2f  $out1\t\t$out2", $i;
}
