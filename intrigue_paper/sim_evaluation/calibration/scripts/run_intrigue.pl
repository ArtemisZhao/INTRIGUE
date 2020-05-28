@files = <data/sim*.dat>;

foreach $f (@files) {

    $f =~/sim\_(\S+)\.dat/;
    $prefix = $1;
    $prefix =~/(\d+)\_(\d+)\_\d+$/;
    $sz = " -n $1,$2 ";
    if ($ARGV[1] eq "meta"){
            $model = "--meta";
            $pm = "meta";
    }

    print "intrigue -d $f --cefn $sz -prefix output/$prefix\_cefn\n";
    print "intrigue -d $f --meta $sz -prefix output/$prefix\_meta\n";
}

