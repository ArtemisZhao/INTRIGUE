@files = <data/*.brm.dat>;
foreach $f (@files){
    $f =~/batch\_(\S+)\.brm\.dat/;
    $mag = $1;
    $out = `Rscript scripts/qvalue.R $f`;
    $out =~/\]\s*(.*)$/;
    $p1 = $1;
    my @data = split /\s+/, $p1;
    shift @data until $data[0]=~/^\S/;

    $out = `Rscript scripts/qvalue.R data/sim\_batch\_$mag\.dat`;
    $out =~/\]\s*(.*)$/;
     my @data1 = split /\s+/, $1;
    shift @data1 until $data1[0]=~/^\S/;
    printf "%.2f  %3d %3d  %.3f %.3f       %3d %3d  %.3f %.3f\n", $mag,$data1[0], $data1[1], $data1[2], $data1[3], $data[0], $data[1], $data[2], $data[3] ;
}
