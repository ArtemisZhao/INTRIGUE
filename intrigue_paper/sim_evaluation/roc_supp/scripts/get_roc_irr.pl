#$scheme = $ARGV[0];
$model = $ARGV[0];

@files = <output/*$model\.intrigue.pip>;

foreach $f (@files){
    open FILE, "$f";
    $f =~/(\d+)\_(\d+)\_$model\./;
    $sim = $2;
    $K = $1;
    next if $K != $ARGV[1];
    while(<FILE>){
        next if $_ !~ /\d/;
        $rep_truth = $irr_truth = 0;
        s/\"//g;
        next if $_ !~ /\d/;
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;

        $gene = $data[0];

            if($gene >=701){
                $rep_truth = 1;
            }



        $id = "K$K:sim$sim:$data[0]";
        printf  "$id $data[-2] $rep_truth\n";
    }
}
