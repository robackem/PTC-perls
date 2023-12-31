# PTC-perls
Custom perl scripts used for confirming presence of premature termination codons (PTCs) in Astyanax mexicanus cavefish whole genome sequences identified by Ensembl Variant Effect Predictor (VEP) v.100

**Note:** Generate a usage statement for any of my scripts using 

```
perl script.pl -h
```

## **Goal:** 
"Manually" check all PTCs called by VEP and confirm that 1) they are generated by single nucleotide changes rather than indels, and 2) a stop is always produced, regardless of potential phasing (given that we did not have phasing information with our sequence data)

## **Pre-processing steps:**
To confirm the presence of PTCs called by VEP we revisited the original VCF file given to VEP as input. 
First, we converted the VCF to tab format using vcftools (vcf-to-tab) to make it easier to pull genotypes for each individual at each position. 
Second, we generated two "key" files of the PTCs we needed to confirm. One key file contained PTCs on the forward (1) strand and the other contained PTCs on the reverse strand (-1). 

Example key file:

```
CHROMOSOME  POSITION  STOP
NW_019170535.1	1119926	Tag
NW_019170535.1	11277655	tgA
NW_019170535.1	12659336	tGa
```
The STOP column indicates the PTC call from VEP, with capital letters indicating the SNP that causes the PTC, which occurs at the position listed in the second column. *This is essential information which will be used by my perl scripts to confirm the PTC.*

## **Step 1: Pull relevant lines from tab file** 
### **get_forwardPTC_tablines.pl** and **get_reversePTC_tablines.pl**
For each putative PTC in the key file, we pulled the genotype call for the three nucleotide positions making up the stop codon for each individual. These scripts are run with the corresponding key file (forward or reverse) and the tab vcf as inputs, and outputs a file for use in the next step. *(Additionally the file outputs some helpful information for checking that things ran properly, like if you have all 3 nucleotides in the codon, etc.)*

Example of output (shortened to only show one individual with the stop and one without):

```
#INDEX.IN.CODON  POSITION.IN.TAB.VCF  POSITION.OF.STOP-TYPE  INDIVIDUAL  GENOTYPE  INDIVIDUAL  GENOTYPE ...
1  NW_019170535.1:1119926	NW_019170535.1:1119926-Tag  Tinaja2B  T/T  Tinaja3B  A/A
2  NW_019170535.1:1119927	NW_019170535.1:1119926-Tag  Tinaja2B  A/A  Tinaja3B  A/A
3  NW_019170535.1:1119928	NW_019170535.1:1119926-Tag  Tinaja2B  G/G  Tinaja3B  G/G
```

## **Step 2: Check PTCs** 
### **check_PTCs_forward.pl** and **check_PTCs_reverse.pl**
These scripts take the three genotype calls across the putative PTC, split each allele (eg. T/T is split to T and T individually) and generates each possible phasing combination of alleles. If a PTC is present and produced in every possible phasing, the PTC passes the check. Failed PTCs are also output as a sanity check that things are working properly. PTCs which pass the check in 1+ individual (or whatever parameters you want) can then be pulled out from this file. These scripts are run with the corresponding output files from the last step as input and ouputs a final file indicating whether each putative PTC in each individual passes or fails the check. 

Example of output (again, shortened to include a pass and fail of the same PTC, plus an example of a PTC that fails because it is present in only some phasing situations):

```
#PTC.BEING.CHECKED.AND.INDIVIDUAL  PHASING1  PHASING2  PHASING3  PHASING4  PASS/FAIL
NW_019170535.1:1119926-Tag:Tinaja2B	AAG/TAG	AAG/TAG	AAG/TAG	AAG/TAG	PASS
NW_019170535.1:1119926-Tag:Tinaja3B	AAG/AAG	AAG/AAG	AAG/AAG	AAG/AAG	FAIL
NW_019170535.1:11894639-taA:Mante_T6151_S25	TAT/ACA	TAA/ACT	TCT/AAA	TCA/AAT	FAIL

```

Please feel free to reach out with any questions! 

-EMMA
