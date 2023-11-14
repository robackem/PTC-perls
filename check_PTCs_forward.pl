#!/usr/bin/perl

# load needed modules
use strict;
use warnings;
use Getopt::Std;
use Data::Dumper;

# define the usage statement variable that will be read if not all the options are met
  my $usage = "\n$0 -i input_file (generated in first step) -o output_file -h help\n";

# call the options from the command line (no : after h means it is not required) 
  our ($opt_i, $opt_o, $opt_h);
  getopts("i:o:h") or die "$usage";

# print the usage statement and exit the script if not all the options are met or if -h is used
  if ( (!(defined $opt_i)) or (!(defined $opt_o)) or (defined $opt_h) )
  { print "$usage"; exit; }

# open the two input files
  open (my $in_file, '<', $opt_i) or die "Cannot open input file\n";

# open output file
  open (my $out_file, '>', $opt_o) or die "Cannot open output file \n";

################################################################################################

my %codons;

while (my $line = <$in_file>)
  {  chomp($line);
     my @fields = split('\t', $line);
     my $Choy_1 = join (':', $fields[2], $fields[3]);
my $Choy_10 = join (':', $fields[2], $fields[5]);
my $Choy_11 = join (':', $fields[2], $fields[7]);
my $Choy_12 = join (':', $fields[2], $fields[9]);
my $Choy_13 = join (':', $fields[2], $fields[11]);
my $Choy_14 = join (':', $fields[2], $fields[13]);
my $Choy_5 = join (':', $fields[2], $fields[15]);
my $Choy_6 = join (':', $fields[2], $fields[17]);
my $Choy_9 = join (':', $fields[2], $fields[19]);
my $Escon_1 = join (':', $fields[2], $fields[21]);
my $Escon_2 = join (':', $fields[2], $fields[23]);
my $Escon_3 = join (':', $fields[2], $fields[25]);
my $Escon_4 = join (':', $fields[2], $fields[27]);
my $Escon_5 = join (':', $fields[2], $fields[29]);
my $Escon_6 = join (':', $fields[2], $fields[31]);
my $Escon_7 = join (':', $fields[2], $fields[33]);
my $Escon_8 = join (':', $fields[2], $fields[35]);
my $Escondido2 = join (':', $fields[2], $fields[37]);
my $Mante_T6151_S25 = join (':', $fields[2], $fields[39]);
my $Mante_T6152_S24 = join (':', $fields[2], $fields[41]);
my $Mante_T6153_S28 = join (':', $fields[2], $fields[43]);
my $Mante_T6154_S29 = join (':', $fields[2], $fields[45]);
my $Mante_T6155_S26 = join (':', $fields[2], $fields[47]);
my $Mante_T6156_S27 = join (':', $fields[2], $fields[49]);
my $Mante_T6157_S22 = join (':', $fields[2], $fields[51]);
my $Mante_T6158_S20 = join (':', $fields[2], $fields[53]);
my $Mante_T6159_S23 = join (':', $fields[2], $fields[55]);
my $Mante_T6160_S21 = join (':', $fields[2], $fields[57]);
my $Molino1B = join (':', $fields[2], $fields[59]);
my $Molino2B = join (':', $fields[2], $fields[61]);
my $Molino4B = join (':', $fields[2], $fields[63]);
my $Molino6 = join (':', $fields[2], $fields[65]);
my $Molino_10b = join (':', $fields[2], $fields[67]);
my $Molino_11a = join (':', $fields[2], $fields[69]);
my $Molino_12a = join (':', $fields[2], $fields[71]);
my $Molino_13b = join (':', $fields[2], $fields[73]);
my $Molino_14a = join (':', $fields[2], $fields[75]);
my $Molino_15b = join (':', $fields[2], $fields[77]);
my $Molino_2a = join (':', $fields[2], $fields[79]);
my $Molino_7a = join (':', $fields[2], $fields[81]);
my $Molino_9b = join (':', $fields[2], $fields[83]);
my $Molinos_2Boro = join (':', $fields[2], $fields[85]);
my $Molinos_D3POG = join (':', $fields[2], $fields[87]);
my $Montecillos_T5775_S24 = join (':', $fields[2], $fields[89]);
my $Montecillos_T5776_S27 = join (':', $fields[2], $fields[91]);
my $Montecillos_T5777_S19 = join (':', $fields[2], $fields[93]);
my $Montecillos_T5779_S12 = join (':', $fields[2], $fields[95]);
my $Montecillos_T5780_S15 = join (':', $fields[2], $fields[97]);
my $Montecillos_T5781_S18 = join (':', $fields[2], $fields[99]);
my $Montecillos_T5782_S21 = join (':', $fields[2], $fields[101]);
my $Montecillos_T5785_S22 = join (':', $fields[2], $fields[103]);
my $Montecillos_T5786_S29 = join (':', $fields[2], $fields[105]);
my $Pach_11 = join (':', $fields[2], $fields[107]);
my $Pach_12 = join (':', $fields[2], $fields[109]);
my $Pach_14 = join (':', $fields[2], $fields[111]);
my $Pach_15 = join (':', $fields[2], $fields[113]);
my $Pach_17 = join (':', $fields[2], $fields[115]);
my $Pach_3 = join (':', $fields[2], $fields[117]);
my $Pach_7 = join (':', $fields[2], $fields[119]);
my $Pach_8 = join (':', $fields[2], $fields[121]);
my $Pach_9 = join (':', $fields[2], $fields[123]);
my $Pachon2B = join (':', $fields[2], $fields[125]);
my $Pachon_1Gross = join (':', $fields[2], $fields[127]);
my $Pachon_2Gross = join (':', $fields[2], $fields[129]);
my $Pachon_3Gross = join (':', $fields[2], $fields[131]);
my $Pachon_6Boro = join (':', $fields[2], $fields[133]);
my $Pachon_E2POG = join (':', $fields[2], $fields[135]);
my $Pachon_F2POG = join (':', $fields[2], $fields[137]);
my $Pachon_G2POG = join (':', $fields[2], $fields[139]);
my $Pachon_H2POG = join (':', $fields[2], $fields[141]);
my $Pachon_ref = join (':', $fields[2], $fields[143]);
my $Palmaseca_T5512_S13 = join (':', $fields[2], $fields[145]);
my $Palmaseca_T5514_S8 = join (':', $fields[2], $fields[147]);
my $Palmaseca_T5515_S17 = join (':', $fields[2], $fields[149]);
my $Palmaseca_T5517_S9 = join (':', $fields[2], $fields[151]);
my $Palmaseca_T5518_S10 = join (':', $fields[2], $fields[153]);
my $Palmaseca_T5519_S11 = join (':', $fields[2], $fields[155]);
my $Palmaseca_T5522_S30 = join (':', $fields[2], $fields[157]);
my $Palmaseca_T5523_S11 = join (':', $fields[2], $fields[159]);
my $Rascon1 = join (':', $fields[2], $fields[161]);
my $Rascon2 = join (':', $fields[2], $fields[163]);
my $Rascon3 = join (':', $fields[2], $fields[165]);
my $Rascon3B = join (':', $fields[2], $fields[167]);
my $Rascon4 = join (':', $fields[2], $fields[169]);
my $Rascon5 = join (':', $fields[2], $fields[171]);
my $Rascon_12 = join (':', $fields[2], $fields[173]);
my $Rascon_13 = join (':', $fields[2], $fields[175]);
my $Rascon_15 = join (':', $fields[2], $fields[177]);
my $Rascon_16 = join (':', $fields[2], $fields[179]);
my $Rascon_2 = join (':', $fields[2], $fields[181]);
my $Rascon_4 = join (':', $fields[2], $fields[183]);
my $Rascon_6 = join (':', $fields[2], $fields[185]);
my $Rascon_8 = join (':', $fields[2], $fields[187]);
my $T5879_Tigre_S31 = join (':', $fields[2], $fields[189]);
my $T5882_Tigre_S30 = join (':', $fields[2], $fields[191]);
my $Tigre2 = join (':', $fields[2], $fields[193]);
my $Tigre_T5881_S20 = join (':', $fields[2], $fields[195]);
my $Tigre_T5883_S23 = join (':', $fields[2], $fields[197]);
my $Tigre_T5884_S26 = join (':', $fields[2], $fields[199]);
my $Tigre_T5885_S28 = join (':', $fields[2], $fields[201]);
my $Tigre_T5890_S14 = join (':', $fields[2], $fields[203]);
my $Tigre_T5891_S1 = join (':', $fields[2], $fields[205]);
my $Tigre_T5893_S2 = join (':', $fields[2], $fields[207]);
my $Tinaja1B = join (':', $fields[2], $fields[209]);
my $Tinaja2B = join (':', $fields[2], $fields[211]);
my $Tinaja3 = join (':', $fields[2], $fields[213]);
my $Tinaja3B = join (':', $fields[2], $fields[215]);
my $Tinaja4 = join (':', $fields[2], $fields[217]);
my $Tinaja4B = join (':', $fields[2], $fields[219]);
my $Tinaja_11 = join (':', $fields[2], $fields[221]);
my $Tinaja_12 = join (':', $fields[2], $fields[223]);
my $Tinaja_1Boro = join (':', $fields[2], $fields[225]);
my $Tinaja_1Gross = join (':', $fields[2], $fields[227]);
my $Tinaja_2 = join (':', $fields[2], $fields[229]);
my $Tinaja_2Gross = join (':', $fields[2], $fields[231]);
my $Tinaja_3 = join (':', $fields[2], $fields[233]);
my $Tinaja_3Gross = join (':', $fields[2], $fields[235]);
my $Tinaja_5 = join (':', $fields[2], $fields[237]);
my $Tinaja_6 = join (':', $fields[2], $fields[239]);
my $Tinaja_B = join (':', $fields[2], $fields[241]);
my $Tinaja_C = join (':', $fields[2], $fields[243]);
my $Tinaja_D = join (':', $fields[2], $fields[245]);
my $Tinaja_E = join (':', $fields[2], $fields[247]);
my $Vanquez3 = join (':', $fields[2], $fields[249]);
my $Vasquez_V10_S9 = join (':', $fields[2], $fields[251]);
my $Vasquez_V3_S3 = join (':', $fields[2], $fields[253]);
my $Vasquez_V5_S4 = join (':', $fields[2], $fields[255]);
my $Vasquez_V6_S5 = join (':', $fields[2], $fields[257]);
my $Vasquez_V7_S6 = join (':', $fields[2], $fields[259]);
my $Vasquez_V8_S7 = join (':', $fields[2], $fields[261]);
my $Vasquez_V9_S8 = join (':', $fields[2], $fields[263]);
my $Yerbaniz_T5800_S7 = join (':', $fields[2], $fields[265]);
my $Yerbaniz_T5802_S16 = join (':', $fields[2], $fields[267]);
my $Yerbaniz_T5804_S3 = join (':', $fields[2], $fields[269]);
my $Yerbaniz_T5805_S25 = join (':', $fields[2], $fields[271]);
my $Yerbaniz_T5806_S4 = join (':', $fields[2], $fields[273]);
my $Yerbaniz_T5808_S5 = join (':', $fields[2], $fields[275]);
my $Yerbaniz_T5809_S6 = join (':', $fields[2], $fields[277]);
push @{ $codons{$Choy_1} }, $fields[4];
push @{ $codons{$Choy_10} }, $fields[6];
push @{ $codons{$Choy_11} }, $fields[8];
push @{ $codons{$Choy_12} }, $fields[10];
push @{ $codons{$Choy_13} }, $fields[12];
push @{ $codons{$Choy_14} }, $fields[14];
push @{ $codons{$Choy_5} }, $fields[16];
push @{ $codons{$Choy_6} }, $fields[18];
push @{ $codons{$Choy_9} }, $fields[20];
push @{ $codons{$Escon_1} }, $fields[22];
push @{ $codons{$Escon_2} }, $fields[24];
push @{ $codons{$Escon_3} }, $fields[26];
push @{ $codons{$Escon_4} }, $fields[28];
push @{ $codons{$Escon_5} }, $fields[30];
push @{ $codons{$Escon_6} }, $fields[32];
push @{ $codons{$Escon_7} }, $fields[34];
push @{ $codons{$Escon_8} }, $fields[36];
push @{ $codons{$Escondido2} }, $fields[38];
push @{ $codons{$Mante_T6151_S25} }, $fields[40];
push @{ $codons{$Mante_T6152_S24} }, $fields[42];
push @{ $codons{$Mante_T6153_S28} }, $fields[44];
push @{ $codons{$Mante_T6154_S29} }, $fields[46];
push @{ $codons{$Mante_T6155_S26} }, $fields[48];
push @{ $codons{$Mante_T6156_S27} }, $fields[50];
push @{ $codons{$Mante_T6157_S22} }, $fields[52];
push @{ $codons{$Mante_T6158_S20} }, $fields[54];
push @{ $codons{$Mante_T6159_S23} }, $fields[56];
push @{ $codons{$Mante_T6160_S21} }, $fields[58];
push @{ $codons{$Molino1B} }, $fields[60];
push @{ $codons{$Molino2B} }, $fields[62];
push @{ $codons{$Molino4B} }, $fields[64];
push @{ $codons{$Molino6} }, $fields[66];
push @{ $codons{$Molino_10b} }, $fields[68];
push @{ $codons{$Molino_11a} }, $fields[70];
push @{ $codons{$Molino_12a} }, $fields[72];
push @{ $codons{$Molino_13b} }, $fields[74];
push @{ $codons{$Molino_14a} }, $fields[76];
push @{ $codons{$Molino_15b} }, $fields[78];
push @{ $codons{$Molino_2a} }, $fields[80];
push @{ $codons{$Molino_7a} }, $fields[82];
push @{ $codons{$Molino_9b} }, $fields[84];
push @{ $codons{$Molinos_2Boro} }, $fields[86];
push @{ $codons{$Molinos_D3POG} }, $fields[88];
push @{ $codons{$Montecillos_T5775_S24} }, $fields[90];
push @{ $codons{$Montecillos_T5776_S27} }, $fields[92];
push @{ $codons{$Montecillos_T5777_S19} }, $fields[94];
push @{ $codons{$Montecillos_T5779_S12} }, $fields[96];
push @{ $codons{$Montecillos_T5780_S15} }, $fields[98];
push @{ $codons{$Montecillos_T5781_S18} }, $fields[100];
push @{ $codons{$Montecillos_T5782_S21} }, $fields[102];
push @{ $codons{$Montecillos_T5785_S22} }, $fields[104];
push @{ $codons{$Montecillos_T5786_S29} }, $fields[106];
push @{ $codons{$Pach_11} }, $fields[108];
push @{ $codons{$Pach_12} }, $fields[110];
push @{ $codons{$Pach_14} }, $fields[112];
push @{ $codons{$Pach_15} }, $fields[114];
push @{ $codons{$Pach_17} }, $fields[116];
push @{ $codons{$Pach_3} }, $fields[118];
push @{ $codons{$Pach_7} }, $fields[120];
push @{ $codons{$Pach_8} }, $fields[122];
push @{ $codons{$Pach_9} }, $fields[124];
push @{ $codons{$Pachon2B} }, $fields[126];
push @{ $codons{$Pachon_1Gross} }, $fields[128];
push @{ $codons{$Pachon_2Gross} }, $fields[130];
push @{ $codons{$Pachon_3Gross} }, $fields[132];
push @{ $codons{$Pachon_6Boro} }, $fields[134];
push @{ $codons{$Pachon_E2POG} }, $fields[136];
push @{ $codons{$Pachon_F2POG} }, $fields[138];
push @{ $codons{$Pachon_G2POG} }, $fields[140];
push @{ $codons{$Pachon_H2POG} }, $fields[142];
push @{ $codons{$Pachon_ref} }, $fields[144];
push @{ $codons{$Palmaseca_T5512_S13} }, $fields[146];
push @{ $codons{$Palmaseca_T5514_S8} }, $fields[148];
push @{ $codons{$Palmaseca_T5515_S17} }, $fields[150];
push @{ $codons{$Palmaseca_T5517_S9} }, $fields[152];
push @{ $codons{$Palmaseca_T5518_S10} }, $fields[154];
push @{ $codons{$Palmaseca_T5519_S11} }, $fields[156];
push @{ $codons{$Palmaseca_T5522_S30} }, $fields[158];
push @{ $codons{$Palmaseca_T5523_S11} }, $fields[160];
push @{ $codons{$Rascon1} }, $fields[162];
push @{ $codons{$Rascon2} }, $fields[164];
push @{ $codons{$Rascon3} }, $fields[166];
push @{ $codons{$Rascon3B} }, $fields[168];
push @{ $codons{$Rascon4} }, $fields[170];
push @{ $codons{$Rascon5} }, $fields[172];
push @{ $codons{$Rascon_12} }, $fields[174];
push @{ $codons{$Rascon_13} }, $fields[176];
push @{ $codons{$Rascon_15} }, $fields[178];
push @{ $codons{$Rascon_16} }, $fields[180];
push @{ $codons{$Rascon_2} }, $fields[182];
push @{ $codons{$Rascon_4} }, $fields[184];
push @{ $codons{$Rascon_6} }, $fields[186];
push @{ $codons{$Rascon_8} }, $fields[188];
push @{ $codons{$T5879_Tigre_S31} }, $fields[190];
push @{ $codons{$T5882_Tigre_S30} }, $fields[192];
push @{ $codons{$Tigre2} }, $fields[194];
push @{ $codons{$Tigre_T5881_S20} }, $fields[196];
push @{ $codons{$Tigre_T5883_S23} }, $fields[198];
push @{ $codons{$Tigre_T5884_S26} }, $fields[200];
push @{ $codons{$Tigre_T5885_S28} }, $fields[202];
push @{ $codons{$Tigre_T5890_S14} }, $fields[204];
push @{ $codons{$Tigre_T5891_S1} }, $fields[206];
push @{ $codons{$Tigre_T5893_S2} }, $fields[208];
push @{ $codons{$Tinaja1B} }, $fields[210];
push @{ $codons{$Tinaja2B} }, $fields[212];
push @{ $codons{$Tinaja3} }, $fields[214];
push @{ $codons{$Tinaja3B} }, $fields[216];
push @{ $codons{$Tinaja4} }, $fields[218];
push @{ $codons{$Tinaja4B} }, $fields[220];
push @{ $codons{$Tinaja_11} }, $fields[222];
push @{ $codons{$Tinaja_12} }, $fields[224];
push @{ $codons{$Tinaja_1Boro} }, $fields[226];
push @{ $codons{$Tinaja_1Gross} }, $fields[228];
push @{ $codons{$Tinaja_2} }, $fields[230];
push @{ $codons{$Tinaja_2Gross} }, $fields[232];
push @{ $codons{$Tinaja_3} }, $fields[234];
push @{ $codons{$Tinaja_3Gross} }, $fields[236];
push @{ $codons{$Tinaja_5} }, $fields[238];
push @{ $codons{$Tinaja_6} }, $fields[240];
push @{ $codons{$Tinaja_B} }, $fields[242];
push @{ $codons{$Tinaja_C} }, $fields[244];
push @{ $codons{$Tinaja_D} }, $fields[246];
push @{ $codons{$Tinaja_E} }, $fields[248];
push @{ $codons{$Vanquez3} }, $fields[250];
push @{ $codons{$Vasquez_V10_S9} }, $fields[252];
push @{ $codons{$Vasquez_V3_S3} }, $fields[254];
push @{ $codons{$Vasquez_V5_S4} }, $fields[256];
push @{ $codons{$Vasquez_V6_S5} }, $fields[258];
push @{ $codons{$Vasquez_V7_S6} }, $fields[260];
push @{ $codons{$Vasquez_V8_S7} }, $fields[262];
push @{ $codons{$Vasquez_V9_S8} }, $fields[264];
push @{ $codons{$Yerbaniz_T5800_S7} }, $fields[266];
push @{ $codons{$Yerbaniz_T5802_S16} }, $fields[268];
push @{ $codons{$Yerbaniz_T5804_S3} }, $fields[270];
push @{ $codons{$Yerbaniz_T5805_S25} }, $fields[272];
push @{ $codons{$Yerbaniz_T5806_S4} }, $fields[274];
push @{ $codons{$Yerbaniz_T5808_S5} }, $fields[276];
push @{ $codons{$Yerbaniz_T5809_S6} }, $fields[278];
   }

# CHECK
#  print $out_file Dumper(\%codons);


for my $group (keys %codons)
  { my $join = join '/', @{ $codons{$group} };
    my @nucleotides = split '/', $join;
    my $codon1 = join ('', $nucleotides[0], $nucleotides[2], $nucleotides[4]);
    my $length1 = length($codon1);
    my $codon2 = join ('', $nucleotides[1], $nucleotides[3], $nucleotides[5]);
    my $length2 = length($codon2);
    my $codon3 = join ('', $nucleotides[0], $nucleotides[2], $nucleotides[5]);
    my $codon4 = join ('', $nucleotides[1], $nucleotides[3], $nucleotides[4]);
    my $codon5 = join ('', $nucleotides[0], $nucleotides[3], $nucleotides[4]);
    my $codon6 = join ('', $nucleotides[1], $nucleotides[2], $nucleotides[5]);
    my $codon7 = join ('', $nucleotides[0], $nucleotides[3], $nucleotides[5]);
    my $codon8 = join ('', $nucleotides[1], $nucleotides[2], $nucleotides[4]);
    my $genotype1 = join('/', $codon1, $codon2);
    my $genotype2 = join('/', $codon3, $codon4);
    my $genotype3 = join('/', $codon5, $codon6);
    my $genotype4 = join('/', $codon7, $codon8);
    
    my $TAGs1 = () = ($genotype1 =~ /TAG/g);
    my $TAAs1 = () = ($genotype1 =~ /TAA/g);
    my $TGAs1 = () = ($genotype1 =~ /TGA/g);
    
    my $TAGs2 = () = ($genotype2 =~ /TAG/g);
    my $TAAs2 = () = ($genotype2 =~ /TAA/g);
    my $TGAs2 = () = ($genotype2 =~ /TGA/g);
    
    my $TAGs3 = () = ($genotype3 =~ /TAG/g);
    my $TAAs3 = () = ($genotype3 =~ /TAA/g);
    my $TGAs3 = () = ($genotype3 =~ /TGA/g);

    my $TAGs4 = () = ($genotype4 =~ /TAG/g);
    my $TAAs4 = () = ($genotype4 =~ /TAA/g);
    my $TGAs4 = () = ($genotype4 =~ /TGA/g);

    my $geno1stops = $TAGs1 + $TAAs1 + $TGAs1;
    my $geno2stops = $TAGs2 + $TAAs2 + $TGAs2;
    my $geno3stops = $TAGs3 + $TAAs3 + $TGAs3;
    my $geno4stops = $TAGs4 + $TAAs4 + $TGAs4;


   if (($length1 == 3 && $length2 == 3) && ($geno1stops > 0 && $geno2stops > 0 && $geno3stops > 0 && $geno4stops > 0)) {print $out_file "$group\t$genotype1\t$genotype2\t$genotype3\t$genotype4\tPASS\n";}
   else {print $out_file "$group\t$genotype1\t$genotype2\t$genotype3\t$genotype4\tFAIL\n";}
    

 
      
    
  }
