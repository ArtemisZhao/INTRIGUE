open FILE, "sort -grk4 $ARGV[0] |";
$cumsum=0;
$count = 0;
$rej=0;

while(<FILE>){

    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;

    $cumsum += (1-$data[-1]);
    $count++;

    if($cumsum/$count > 0.05){
        last;
    }
    
    $rej++;
    $data[0]=~/gene(\d+)/;
    if($1<=200){
        $tp++;
    }else{
        $fp++;
    }

}


$fdr = 0;
if($rej>0){
    $fdr = $fp/$rej;
}

printf "%3d  %.3f  %.3f\n", $rej, $fdr, ($rej-$fp)/200;
