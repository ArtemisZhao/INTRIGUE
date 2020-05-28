@files = <data/sim*.dat>;

foreach $f (@files) {

    $f =~/sim\_(\S+)\.dat/;
    $prefix = $1;
    $sz = " -n 100 ";

    print "intrigue -d $f --cefn -n 100 -prefix output/$prefix\_cefn\n";
    print "intrigue -d $f --meta -n 100 -prefix output/$prefix\_meta\n";
}

