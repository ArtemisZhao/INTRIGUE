for ($i = 0; $i<=2.01; $i+= 0.1){
    $out1 = `perl fdr.pl output/batch_$i.meta.intrigue.pip`;
    $out2 = `perl fdr.pl output/batch_$i.cefn.intrigue.pip`;
    chomp $out2;
    printf "%.2f $out2\t\t$out1", $i;
}
