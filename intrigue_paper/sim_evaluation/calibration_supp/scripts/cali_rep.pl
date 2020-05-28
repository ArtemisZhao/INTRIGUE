#$scheme = $ARGV[0];
$model = $ARGV[0];

@files = <output/*$model\.intrigue.pip>;

foreach $f (@files){
    open FILE, "$f";
    $scheme =~/(\d+)/;
    $f =~/(\d+)\_$model\./;
    $sim = $1;
    while(<FILE>){
        next if $_ !~ /\d/;
        $rep_truth = $irr_truth = 0;
        s/\"//g;
        next if $_ !~ /\d/;
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;

        $gene = $data[0];

            if($gene >=401 && $gene <=700){
                $rep_truth = 1;
            }



        $id = "sim$sim:$data[0]";
        printf  "$id $data[-1] $rep_truth\n";
    }
}
