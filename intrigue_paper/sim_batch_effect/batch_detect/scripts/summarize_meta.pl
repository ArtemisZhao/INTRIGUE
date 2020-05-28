for ($i=0;$i<=2.01;$i+=0.1){

    $out1 = `grep -v Null  output/batch\_$i.meta.intrigue.est`;
    #chomp $out1;
    #$out2 = `grep -v Null  output/batch\_$i.brm.meta.intrigue.est`;
    printf "%.2f  $out1", $i;
}
