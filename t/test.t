BEGIN { 
   $::DEBUG_ = 0 ;
   push @INC, ".." if ( $::DEBUG_ ) ;
   }

use strict ;
use spice ;
$spice::verbose = 0 ;

my $spiceFile ;
if ( $::DEBUG_ ) {
   $spiceFile = "/home/rohit/eda_tools/spiner/t/netlist.sp" ;
   }
else {
   $spiceFile = "t/netlist.sp" ;
   }

print "1..8\n" ;
my $init ;
$init = spiceInit ( $spiceFile ) ;
if ( $init == -1 ) {
   print "$spice::error\n" ;
   print "not ok\n" ;
   }
else {
   print "ok\n" ;
   }

my @subckts ;
@subckts  = getTopSubckts( ) ;
my $subckts = join ' ', @subckts ;
print "@subckts" if ( $::DEBUG_ ) ;
if ( $subckts eq "mux2")  {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }

my $subckt = $subckts ;
undef @subckts ;
undef $subckts ;

my @list = getSubcktList ( )  ;
my $list = join ' ', @list ;
print "$list" if ( $::DEBUG_ ) ;
if ( $list eq "nor2 or2 nand2 mux2 and2 inv")  {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }
undef @list ;
undef $list ;

my $defn = getSubckt ( "inv" ) ;
my $inv = q(.subckt inv a y  wp=0 wn=0 lp=1.0e-07 ln=1.0e-07
m1 y a vdd vdd p l=lp w=wp m=1
m2 y a vss vss n l=ln w=wn m=1
.ends
) ;
if ( $defn =~ m/$inv/ ) {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }
undef $defn ;
undef $inv ;

my @res = getResistors ("mux2") ;
my $res = join ' ', @res ;
print "$res" if ( $::DEBUG_ ) ;
if ( $res eq q(R1 2.0M) ) {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }
undef $res ;
undef @res ;

my @cap = getCapacitors ("mux2") ;
my $cap = join ' ', @cap ;
print "$cap" if ( $::DEBUG_ ) ;
if ( $cap eq q(C1 3.5pF) ) {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }
undef $cap ;
undef @cap ;

my @tx = getTransistors ( "inv" ) ;
my $tx = join ' ', @tx ;
print "$tx" if ( $::DEBUG_ ) ;
if ( $tx eq q(m1 p m2 n) ) {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }
undef $tx ;
undef @tx ;

my @inst = getInstances ( "mux2" ) ;
my $inst = join ' ', @inst ;
print "$inst" if ( $::DEBUG_ ) ;
if ( $inst eq q(xo inv x1 and2 x2 and2 x3 or2) ) {
   print "ok\n" ;
   }
else {
   print "not ok\n" ;
   }
undef $inst ;
undef @inst ;
