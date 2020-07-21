open FILE, "zcat UKB_Height_muscle.TWAS.torus.zval.gz |";
while(<FILE>){

    chomp;
    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;

    $rcd{$data[0]} = $data[-1];
}


open FILE, "zcat GIANT_Height_muscle.TWAS.torus.zval.gz |";
while(<FILE>){
    chomp;
    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    next if !defined($rcd{$data[0]});
    print "$data[0] $data[-1] $rcd{$data[0]}\n"; 
}
