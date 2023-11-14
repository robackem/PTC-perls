
#!/usr/bin/perl

# load needed modules
use strict;
use warnings;
use Getopt::Std;

# define the usage statement variable that will be read if not all the options are met
  my $usage = "\n$0 -a key_file -i input_tab_file -o output_tablines_file -h help\n";

# call the options from the command line (no : after h means it is not required) 
  our ($opt_a, $opt_i, $opt_o, $opt_h);
  getopts("a:i:o:h") or die "$usage";

# print the usage statement and exit the script if not all the options are met or if -h is used
  if ( (!(defined $opt_a)) or (!(defined $opt_i)) or (!(defined $opt_o)) or (defined $opt_h) )
  { print "$usage"; exit; }

# open the two input files
  open (my $annot_file, '<', $opt_a) or die "Cannot open key file\n";
  open (my $in_file, '<', $opt_i) or die "Cannot open input tab file\n";

# open output file
  open (my $out_file, '>', $opt_o) or die "Cannot open output file \n";

################################################################################################

my %firstcodons;
my %secondcodons;
my %thirdcodons;

## GET PTC INFO FROM THE KEY FILE
while (my $line = <$annot_file>)
  {  chomp($line);
     my @fields = split('\t', $line);
     my $chrom = $fields[0];
     my $pos = $fields[1];
     my $stoplocation = join (':', $chrom, $pos);
     my $stopcodon = $fields[3];
     # FIND WHICH NUCLEOTIDE IN THE CODON IS UPPERCASE (I.E. THE CAUSATIVE SNP AT POSITION LISTED IN KEY FILE)
     $stopcodon =~ m/([[:upper:]])/;
     my $CAPS = "$&";
     my $CAPSposition = index($stopcodon,$CAPS);
     # GENERATE THE POSITIONS SURROUNDING THE CAUSATIVE SNP
     my $plusone = $pos + 1;
     my $plustwo = $pos + 2;
     my $minusone = $pos - 1;
     my $minustwo = $pos - 2;
     my $plusoneloc = join (':', $chrom, $plusone); 
     my $plustwoloc = join (':', $chrom, $plustwo); 
     my $minusoneloc = join (':', $chrom, $minusone); 
     my $minustwoloc = join (':', $chrom, $minustwo);
     my $value = join (':', $stoplocation, $stopcodon);

     
# POPULATE A HASH WITH THE NUCLEOTIDE POSITIONS WEL'LL NEED TO PULL FROM THE TAB VCF BASED ON THE POSITION OF THE SNP CAUSING THE PTC 
     if ($CAPSposition == 2)
       { $firstcodons{$stoplocation} = $value;
	 $secondcodons{$plusoneloc} = $value;
	 $thirdcodons{$plustwoloc} = $value;
       }
     elsif ($CAPSposition == 1)
       { $firstcodons{$minusoneloc} = $value;
	 $secondcodons{$stoplocation} = $value;
	 $thirdcodons{$plusoneloc} = $value;
       }
     elsif ($CAPSposition == 0)
       { $firstcodons{$minustwoloc} = $value;
	 $secondcodons{$minusoneloc} = $value;
	 $thirdcodons{$stoplocation} = $value;
       }
  
   }

my %codonhash;

# SEARCH THROUGH THE TAB VCF FOR ALL THE POSITIONS WE NEED TO PULL OUT AS CALCULATED ABOVE. IF THE SCRIPT FINDS A LINE IN THE VCF THAT IS WITHIN A PTC WE'RE TRYING TO CONFIRM IT PRINTS THE GENOTYPES OF EACH INDIVIDUAL TO AN OUTPUT FILE.

# NOTE THAT OUR TAB VCFS CONTAIN MORE INDIVIDUALS THAN USED FOR THE PTC PROJECT, SO WE ARE JUST PULLING THE GENOTYPE CALLS FOR SOME INDIVIDUALS OUT OF THE TOTAL VCF (HENCE THE NEED TO SPECIFY EACH ONE)

while (my $line2 = <$in_file>) 
  {  chomp($line2);
     my @cols = split('\t', $line2);
     my $location = join(':', $cols[0], $cols[1]);
     if (exists($firstcodons{$location}))
       {print $out_file "1\t$location\t$firstcodons{$location}\tChoy_1\t$cols[69]\tChoy_10\t$cols[70]\tChoy_11\t$cols[71]\tChoy_12\t$cols[72]\tChoy_13\t$cols[73]\tChoy_14\t$cols[74]\tChoy_5\t$cols[75]\tChoy_6\t$cols[76]\tChoy_9\t$cols[77]\tEscon_1\t$cols[78]\tEscon_2\t$cols[79]\tEscon_3\t$cols[80]\tEscon_4\t$cols[81]\tEscon_5\t$cols[82]\tEscon_6\t$cols[83]\tEscon_7\t$cols[84]\tEscon_8\t$cols[85]\tEscondido2\t$cols[86]\tMante_T6151_S25\t$cols[106]\tMante_T6152_S24\t$cols[107]\tMante_T6153_S28\t$cols[108]\tMante_T6154_S29\t$cols[109]\tMante_T6155_S26\t$cols[110]\tMante_T6156_S27\t$cols[111]\tMante_T6157_S22\t$cols[112]\tMante_T6158_S20\t$cols[113]\tMante_T6159_S23\t$cols[114]\tMante_T6160_S21\t$cols[115]\tMolino1B\t$cols[117]\tMolino2B\t$cols[118]\tMolino4B\t$cols[119]\tMolino6\t$cols[120]\tMolino_10b\t$cols[121]\tMolino_11a\t$cols[122]\tMolino_12a\t$cols[123]\tMolino_13b\t$cols[124]\tMolino_14a\t$cols[125]\tMolino_15b\t$cols[126]\tMolino_2a\t$cols[127]\tMolino_7a\t$cols[128]\tMolino_9b\t$cols[129]\tMolinos_2Boro\t$cols[130]\tMolinos_D3POG\t$cols[131]\tMontecillos_T5775_S24\t$cols[132]\tMontecillos_T5776_S27\t$cols[133]\tMontecillos_T5777_S19\t$cols[134]\tMontecillos_T5779_S12\t$cols[135]\tMontecillos_T5780_S15\t$cols[136]\tMontecillos_T5781_S18\t$cols[137]\tMontecillos_T5782_S21\t$cols[138]\tMontecillos_T5785_S22\t$cols[139]\tMontecillos_T5786_S29\t$cols[140]\tPach_11\t$cols[143]\tPach_12\t$cols[144]\tPach_14\t$cols[145]\tPach_15\t$cols[146]\tPach_17\t$cols[147]\tPach_3\t$cols[148]\tPach_7\t$cols[149]\tPach_8\t$cols[150]\tPach_9\t$cols[151]\tPachon2B\t$cols[152]\tPachon_1Gross\t$cols[153]\tPachon_2Gross\t$cols[154]\tPachon_3Gross\t$cols[155]\tPachon_6Boro\t$cols[156]\tPachon_E2POG\t$cols[157]\tPachon_F2POG\t$cols[158]\tPachon_G2POG\t$cols[159]\tPachon_H2POG\t$cols[160]\tPachon_ref\t$cols[161]\tPalmaseca_T5512_S13\t$cols[162]\tPalmaseca_T5514_S8\t$cols[163]\tPalmaseca_T5515_S17\t$cols[164]\tPalmaseca_T5517_S9\t$cols[165]\tPalmaseca_T5518_S10\t$cols[166]\tPalmaseca_T5519_S11\t$cols[167]\tPalmaseca_T5522_S30\t$cols[168]\tPalmaseca_T5523_S11\t$cols[169]\tRascon1\t$cols[179]\tRascon2\t$cols[180]\tRascon3\t$cols[181]\tRascon3B\t$cols[182]\tRascon4\t$cols[183]\tRascon5\t$cols[184]\tRascon_12\t$cols[185]\tRascon_13\t$cols[186]\tRascon_15\t$cols[187]\tRascon_16\t$cols[188]\tRascon_2\t$cols[189]\tRascon_4\t$cols[190]\tRascon_6\t$cols[191]\tRascon_8\t$cols[192]\tT5879_Tigre_S31\t$cols[203]\tT5882_Tigre_S30\t$cols[204]\tTigre2\t$cols[206]\tTigre_T5881_S20\t$cols[207]\tTigre_T5883_S23\t$cols[208]\tTigre_T5884_S26\t$cols[209]\tTigre_T5885_S28\t$cols[210]\tTigre_T5890_S14\t$cols[211]\tTigre_T5891_S1\t$cols[212]\tTigre_T5893_S2\t$cols[213]\tTinaja1B\t$cols[214]\tTinaja2B\t$cols[215]\tTinaja3\t$cols[216]\tTinaja3B\t$cols[217]\tTinaja4\t$cols[218]\tTinaja4B\t$cols[219]\tTinaja_11\t$cols[220]\tTinaja_12\t$cols[221]\tTinaja_1Boro\t$cols[222]\tTinaja_1Gross\t$cols[223]\tTinaja_2\t$cols[224]\tTinaja_2Gross\t$cols[225]\tTinaja_3\t$cols[226]\tTinaja_3Gross\t$cols[227]\tTinaja_5\t$cols[228]\tTinaja_6\t$cols[229]\tTinaja_B\t$cols[230]\tTinaja_C\t$cols[231]\tTinaja_D\t$cols[232]\tTinaja_E\t$cols[233]\tVanquez3\t$cols[237]\tVasquez_V10_S9\t$cols[238]\tVasquez_V3_S3\t$cols[239]\tVasquez_V5_S4\t$cols[240]\tVasquez_V6_S5\t$cols[241]\tVasquez_V7_S6\t$cols[242]\tVasquez_V8_S7\t$cols[243]\tVasquez_V9_S8\t$cols[244]\tYerbaniz_T5800_S7\t$cols[246]\tYerbaniz_T5802_S16\t$cols[247]\tYerbaniz_T5804_S3\t$cols[248]\tYerbaniz_T5805_S25\t$cols[249]\tYerbaniz_T5806_S4\t$cols[250]\tYerbaniz_T5808_S5\t$cols[251]\tYerbaniz_T5809_S6\t$cols[252]\n";}
      elsif (exists($secondcodons{$location}))
       {print $out_file "2\t$location\t$secondcodons{$location}\tChoy_1\t$cols[69]\tChoy_10\t$cols[70]\tChoy_11\t$cols[71]\tChoy_12\t$cols[72]\tChoy_13\t$cols[73]\tChoy_14\t$cols[74]\tChoy_5\t$cols[75]\tChoy_6\t$cols[76]\tChoy_9\t$cols[77]\tEscon_1\t$cols[78]\tEscon_2\t$cols[79]\tEscon_3\t$cols[80]\tEscon_4\t$cols[81]\tEscon_5\t$cols[82]\tEscon_6\t$cols[83]\tEscon_7\t$cols[84]\tEscon_8\t$cols[85]\tEscondido2\t$cols[86]\tMante_T6151_S25\t$cols[106]\tMante_T6152_S24\t$cols[107]\tMante_T6153_S28\t$cols[108]\tMante_T6154_S29\t$cols[109]\tMante_T6155_S26\t$cols[110]\tMante_T6156_S27\t$cols[111]\tMante_T6157_S22\t$cols[112]\tMante_T6158_S20\t$cols[113]\tMante_T6159_S23\t$cols[114]\tMante_T6160_S21\t$cols[115]\tMolino1B\t$cols[117]\tMolino2B\t$cols[118]\tMolino4B\t$cols[119]\tMolino6\t$cols[120]\tMolino_10b\t$cols[121]\tMolino_11a\t$cols[122]\tMolino_12a\t$cols[123]\tMolino_13b\t$cols[124]\tMolino_14a\t$cols[125]\tMolino_15b\t$cols[126]\tMolino_2a\t$cols[127]\tMolino_7a\t$cols[128]\tMolino_9b\t$cols[129]\tMolinos_2Boro\t$cols[130]\tMolinos_D3POG\t$cols[131]\tMontecillos_T5775_S24\t$cols[132]\tMontecillos_T5776_S27\t$cols[133]\tMontecillos_T5777_S19\t$cols[134]\tMontecillos_T5779_S12\t$cols[135]\tMontecillos_T5780_S15\t$cols[136]\tMontecillos_T5781_S18\t$cols[137]\tMontecillos_T5782_S21\t$cols[138]\tMontecillos_T5785_S22\t$cols[139]\tMontecillos_T5786_S29\t$cols[140]\tPach_11\t$cols[143]\tPach_12\t$cols[144]\tPach_14\t$cols[145]\tPach_15\t$cols[146]\tPach_17\t$cols[147]\tPach_3\t$cols[148]\tPach_7\t$cols[149]\tPach_8\t$cols[150]\tPach_9\t$cols[151]\tPachon2B\t$cols[152]\tPachon_1Gross\t$cols[153]\tPachon_2Gross\t$cols[154]\tPachon_3Gross\t$cols[155]\tPachon_6Boro\t$cols[156]\tPachon_E2POG\t$cols[157]\tPachon_F2POG\t$cols[158]\tPachon_G2POG\t$cols[159]\tPachon_H2POG\t$cols[160]\tPachon_ref\t$cols[161]\tPalmaseca_T5512_S13\t$cols[162]\tPalmaseca_T5514_S8\t$cols[163]\tPalmaseca_T5515_S17\t$cols[164]\tPalmaseca_T5517_S9\t$cols[165]\tPalmaseca_T5518_S10\t$cols[166]\tPalmaseca_T5519_S11\t$cols[167]\tPalmaseca_T5522_S30\t$cols[168]\tPalmaseca_T5523_S11\t$cols[169]\tRascon1\t$cols[179]\tRascon2\t$cols[180]\tRascon3\t$cols[181]\tRascon3B\t$cols[182]\tRascon4\t$cols[183]\tRascon5\t$cols[184]\tRascon_12\t$cols[185]\tRascon_13\t$cols[186]\tRascon_15\t$cols[187]\tRascon_16\t$cols[188]\tRascon_2\t$cols[189]\tRascon_4\t$cols[190]\tRascon_6\t$cols[191]\tRascon_8\t$cols[192]\tT5879_Tigre_S31\t$cols[203]\tT5882_Tigre_S30\t$cols[204]\tTigre2\t$cols[206]\tTigre_T5881_S20\t$cols[207]\tTigre_T5883_S23\t$cols[208]\tTigre_T5884_S26\t$cols[209]\tTigre_T5885_S28\t$cols[210]\tTigre_T5890_S14\t$cols[211]\tTigre_T5891_S1\t$cols[212]\tTigre_T5893_S2\t$cols[213]\tTinaja1B\t$cols[214]\tTinaja2B\t$cols[215]\tTinaja3\t$cols[216]\tTinaja3B\t$cols[217]\tTinaja4\t$cols[218]\tTinaja4B\t$cols[219]\tTinaja_11\t$cols[220]\tTinaja_12\t$cols[221]\tTinaja_1Boro\t$cols[222]\tTinaja_1Gross\t$cols[223]\tTinaja_2\t$cols[224]\tTinaja_2Gross\t$cols[225]\tTinaja_3\t$cols[226]\tTinaja_3Gross\t$cols[227]\tTinaja_5\t$cols[228]\tTinaja_6\t$cols[229]\tTinaja_B\t$cols[230]\tTinaja_C\t$cols[231]\tTinaja_D\t$cols[232]\tTinaja_E\t$cols[233]\tVanquez3\t$cols[237]\tVasquez_V10_S9\t$cols[238]\tVasquez_V3_S3\t$cols[239]\tVasquez_V5_S4\t$cols[240]\tVasquez_V6_S5\t$cols[241]\tVasquez_V7_S6\t$cols[242]\tVasquez_V8_S7\t$cols[243]\tVasquez_V9_S8\t$cols[244]\tYerbaniz_T5800_S7\t$cols[246]\tYerbaniz_T5802_S16\t$cols[247]\tYerbaniz_T5804_S3\t$cols[248]\tYerbaniz_T5805_S25\t$cols[249]\tYerbaniz_T5806_S4\t$cols[250]\tYerbaniz_T5808_S5\t$cols[251]\tYerbaniz_T5809_S6\t$cols[252]\n";}
      elsif (exists($thirdcodons{$location}))
       {print $out_file "3\t$location\t$thirdcodons{$location}\tChoy_1\t$cols[69]\tChoy_10\t$cols[70]\tChoy_11\t$cols[71]\tChoy_12\t$cols[72]\tChoy_13\t$cols[73]\tChoy_14\t$cols[74]\tChoy_5\t$cols[75]\tChoy_6\t$cols[76]\tChoy_9\t$cols[77]\tEscon_1\t$cols[78]\tEscon_2\t$cols[79]\tEscon_3\t$cols[80]\tEscon_4\t$cols[81]\tEscon_5\t$cols[82]\tEscon_6\t$cols[83]\tEscon_7\t$cols[84]\tEscon_8\t$cols[85]\tEscondido2\t$cols[86]\tMante_T6151_S25\t$cols[106]\tMante_T6152_S24\t$cols[107]\tMante_T6153_S28\t$cols[108]\tMante_T6154_S29\t$cols[109]\tMante_T6155_S26\t$cols[110]\tMante_T6156_S27\t$cols[111]\tMante_T6157_S22\t$cols[112]\tMante_T6158_S20\t$cols[113]\tMante_T6159_S23\t$cols[114]\tMante_T6160_S21\t$cols[115]\tMolino1B\t$cols[117]\tMolino2B\t$cols[118]\tMolino4B\t$cols[119]\tMolino6\t$cols[120]\tMolino_10b\t$cols[121]\tMolino_11a\t$cols[122]\tMolino_12a\t$cols[123]\tMolino_13b\t$cols[124]\tMolino_14a\t$cols[125]\tMolino_15b\t$cols[126]\tMolino_2a\t$cols[127]\tMolino_7a\t$cols[128]\tMolino_9b\t$cols[129]\tMolinos_2Boro\t$cols[130]\tMolinos_D3POG\t$cols[131]\tMontecillos_T5775_S24\t$cols[132]\tMontecillos_T5776_S27\t$cols[133]\tMontecillos_T5777_S19\t$cols[134]\tMontecillos_T5779_S12\t$cols[135]\tMontecillos_T5780_S15\t$cols[136]\tMontecillos_T5781_S18\t$cols[137]\tMontecillos_T5782_S21\t$cols[138]\tMontecillos_T5785_S22\t$cols[139]\tMontecillos_T5786_S29\t$cols[140]\tPach_11\t$cols[143]\tPach_12\t$cols[144]\tPach_14\t$cols[145]\tPach_15\t$cols[146]\tPach_17\t$cols[147]\tPach_3\t$cols[148]\tPach_7\t$cols[149]\tPach_8\t$cols[150]\tPach_9\t$cols[151]\tPachon2B\t$cols[152]\tPachon_1Gross\t$cols[153]\tPachon_2Gross\t$cols[154]\tPachon_3Gross\t$cols[155]\tPachon_6Boro\t$cols[156]\tPachon_E2POG\t$cols[157]\tPachon_F2POG\t$cols[158]\tPachon_G2POG\t$cols[159]\tPachon_H2POG\t$cols[160]\tPachon_ref\t$cols[161]\tPalmaseca_T5512_S13\t$cols[162]\tPalmaseca_T5514_S8\t$cols[163]\tPalmaseca_T5515_S17\t$cols[164]\tPalmaseca_T5517_S9\t$cols[165]\tPalmaseca_T5518_S10\t$cols[166]\tPalmaseca_T5519_S11\t$cols[167]\tPalmaseca_T5522_S30\t$cols[168]\tPalmaseca_T5523_S11\t$cols[169]\tRascon1\t$cols[179]\tRascon2\t$cols[180]\tRascon3\t$cols[181]\tRascon3B\t$cols[182]\tRascon4\t$cols[183]\tRascon5\t$cols[184]\tRascon_12\t$cols[185]\tRascon_13\t$cols[186]\tRascon_15\t$cols[187]\tRascon_16\t$cols[188]\tRascon_2\t$cols[189]\tRascon_4\t$cols[190]\tRascon_6\t$cols[191]\tRascon_8\t$cols[192]\tT5879_Tigre_S31\t$cols[203]\tT5882_Tigre_S30\t$cols[204]\tTigre2\t$cols[206]\tTigre_T5881_S20\t$cols[207]\tTigre_T5883_S23\t$cols[208]\tTigre_T5884_S26\t$cols[209]\tTigre_T5885_S28\t$cols[210]\tTigre_T5890_S14\t$cols[211]\tTigre_T5891_S1\t$cols[212]\tTigre_T5893_S2\t$cols[213]\tTinaja1B\t$cols[214]\tTinaja2B\t$cols[215]\tTinaja3\t$cols[216]\tTinaja3B\t$cols[217]\tTinaja4\t$cols[218]\tTinaja4B\t$cols[219]\tTinaja_11\t$cols[220]\tTinaja_12\t$cols[221]\tTinaja_1Boro\t$cols[222]\tTinaja_1Gross\t$cols[223]\tTinaja_2\t$cols[224]\tTinaja_2Gross\t$cols[225]\tTinaja_3\t$cols[226]\tTinaja_3Gross\t$cols[227]\tTinaja_5\t$cols[228]\tTinaja_6\t$cols[229]\tTinaja_B\t$cols[230]\tTinaja_C\t$cols[231]\tTinaja_D\t$cols[232]\tTinaja_E\t$cols[233]\tVanquez3\t$cols[237]\tVasquez_V10_S9\t$cols[238]\tVasquez_V3_S3\t$cols[239]\tVasquez_V5_S4\t$cols[240]\tVasquez_V6_S5\t$cols[241]\tVasquez_V7_S6\t$cols[242]\tVasquez_V8_S7\t$cols[243]\tVasquez_V9_S8\t$cols[244]\tYerbaniz_T5800_S7\t$cols[246]\tYerbaniz_T5802_S16\t$cols[247]\tYerbaniz_T5804_S3\t$cols[248]\tYerbaniz_T5805_S25\t$cols[249]\tYerbaniz_T5806_S4\t$cols[250]\tYerbaniz_T5808_S5\t$cols[251]\tYerbaniz_T5809_S6\t$cols[252]\n";}
     

      
   }


