#!/bin/bash
#SBATCH --partition=medium
#SBATCH --job-name=gray
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --share
#SBATCH --mem=250000
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=rkumar@uab.edu

RAWDATA=RAWDATA
RAWDATA_RN=RAWDATA_RN
TRIMMOMATIC=/share/apps/ngs-ccts/TRIMMOMATIC/Trimmomatic-0.36


function uncompress(){
parallel -j23 gunzip ::: ${RAWDATA_RN}/*.fastq.gz
}

function run_trimmomatic(){
mkdir QC_TRIMMOMATIC

parallel -j4 "java -jar /share/apps/ngs-ccts/TRIMMOMATIC/Trimmomatic-0.36/trimmomatic-0.36.jar SE -threads 8 -phred33 -trimlog trimlog.txt ${RAWDATA_RN}/{/.}.fastq QC_TRIMMOMATIC/{/.}_QC.fastq  ILLUMINACLIP:/share/apps/ngs-ccts/TRIMMOMATIC/Trimmomatic-0.36/adapters/TruSeq2-SE.fa:2:30:10  CROP:50 LEADING:3 TRAILING:3 SLIDINGWINDOW:40:15 MINLEN:40" ::: ${RAWDATA_RN}/*_F*	
}

#function rename_files(){
#rename '_F_QC' '' QC_TRIMMOMATIC/*.fastq
#}

function run_edgepro(){
mkdir EDGE_PRO

parallel -j4 "OMP_NUM_THREADS=6 edge.pl -g annotation/L_reuteri_JCM_1112.fa -p annotation/L_reuteri_JCM_1112.gbff.ptt -r annotation/L_reuteri_JCM_1112.gbff.rnt -u {} -o EDGE_PRO/{/.}.ep -s /share/apps/ngs-ccts/EDGE_pro/EDGE_pro_v1.3.1 -t 6" ::: QC_TRIMMOMATIC/*
}

function rename(){
mkdir $RAWDATA_RN

cp ${RAWDATA}/aerobicHOCl/0minA.fastq.gz ${RAWDATA_RN}/AH0A_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/0minB.fastq.gz ${RAWDATA_RN}/AH0B_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/0minC.fastq.gz ${RAWDATA_RN}/AH0C_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/15minA.fastq.gz ${RAWDATA_RN}/AH15A_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/15minB.fastq.gz ${RAWDATA_RN}/AH15B_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/15minC.fastq.gz ${RAWDATA_RN}/AH15C_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/30minA.fastq.gz ${RAWDATA_RN}/AH30A_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/30minB.fastq.gz ${RAWDATA_RN}/AH30B_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/30minC.fastq.gz ${RAWDATA_RN}/AH30C_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/5minA.fastq.gz ${RAWDATA_RN}/AH5A_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/5minB.fastq.gz ${RAWDATA_RN}/AH5B_F.fastq.gz
cp ${RAWDATA}/aerobicHOCl/5minC.fastq.gz ${RAWDATA_RN}/AH5C_F.fastq.gz

cp ${RAWDATA}/anaerobicHOCl/0minA_forward.fastq.gz ${RAWDATA_RN}/NH0A_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/0minB_forward.fastq.gz ${RAWDATA_RN}/NH0B_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/0minC_forward.fastq.gz ${RAWDATA_RN}/NH0C_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/15minA_forward.fastq.gz ${RAWDATA_RN}/NH15A_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/15minB_forward.fastq.gz ${RAWDATA_RN}/NH15B_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/15minC_forward.fastq.gz ${RAWDATA_RN}/NH15C_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/30minA_forward.fastq.gz ${RAWDATA_RN}/NH30A_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/30minB_forward.fastq.gz ${RAWDATA_RN}/NH30B_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/30minC_forward.fastq.gz ${RAWDATA_RN}/NH30C_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/5minA_forward.fastq.gz ${RAWDATA_RN}/NH5A_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/5minB_forward.fastq.gz ${RAWDATA_RN}/NH5B_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/5minC_forward.fastq.gz ${RAWDATA_RN}/NH5C_F.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/0minA_reverse.fastq.gz ${RAWDATA_RN}/NH0A_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/0minB_reverse.fastq.gz ${RAWDATA_RN}/NH0B_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/0minC_reverse.fastq.gz ${RAWDATA_RN}/NH0C_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/15minA_reverse.fastq.gz ${RAWDATA_RN}/NH15A_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/15minB_reverse.fastq.gz ${RAWDATA_RN}/NH15B_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/15minC_reverse.fastq.gz ${RAWDATA_RN}/NH15C_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/30minA_reverse.fastq.gz ${RAWDATA_RN}/NH30A_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/30minB_reverse.fastq.gz ${RAWDATA_RN}/NH30B_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/30minC_reverse.fastq.gz ${RAWDATA_RN}/NH30C_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/5minA_reverse.fastq.gz ${RAWDATA_RN}/NH5A_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/5minB_reverse.fastq.gz ${RAWDATA_RN}/NH5B_R.fastq.gz
cp ${RAWDATA}/anaerobicHOCl/5minC_reverse.fastq.gz ${RAWDATA_RN}/NH5C_R.fastq.gz

cp ${RAWDATA}/anaerobicH2O2/0minA_forward.fastq.gz ${RAWDATA_RN}/NP0A_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/0minB_forward.fastq.gz ${RAWDATA_RN}/NP0B_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/0minC_forward.fastq.gz ${RAWDATA_RN}/NP0C_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/15minA_forward.fastq.gz ${RAWDATA_RN}/NP15A_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/15minB_forward.fastq.gz ${RAWDATA_RN}/NP15B_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/15minC_forward.fastq.gz ${RAWDATA_RN}/NP15C_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/30minA_forward.fastq.gz ${RAWDATA_RN}/NP30A_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/30minB_forward.fastq.gz ${RAWDATA_RN}/NP30B_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/30minC_forward.fastq.gz ${RAWDATA_RN}/NP30C_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/5minA_forward.fastq.gz ${RAWDATA_RN}/NP5A_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/5minB_forward.fastq.gz ${RAWDATA_RN}/NP5B_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/5minC_forward.fastq.gz ${RAWDATA_RN}/NP5C_F.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/0minA_reverse.fastq.gz ${RAWDATA_RN}/NP0A_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/0minB_reverse.fastq.gz ${RAWDATA_RN}/NP0B_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/0minC_reverse.fastq.gz ${RAWDATA_RN}/NP0C_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/15minA_reverse.fastq.gz ${RAWDATA_RN}/NP15A_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/15minB_reverse.fastq.gz ${RAWDATA_RN}/NP15B_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/15minC_reverse.fastq.gz ${RAWDATA_RN}/NP15C_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/30minA_reverse.fastq.gz ${RAWDATA_RN}/NP30A_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/30minB_reverse.fastq.gz ${RAWDATA_RN}/NP30B_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/30minC_reverse.fastq.gz ${RAWDATA_RN}/NP30C_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/5minA_reverse.fastq.gz ${RAWDATA_RN}/NP5A_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/5minB_reverse.fastq.gz ${RAWDATA_RN}/NP5B_R.fastq.gz
cp ${RAWDATA}/anaerobicH2O2/5minC_reverse.fastq.gz ${RAWDATA_RN}/NP5C_R.fastq.gz

}

function get_genome(){
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000714595.1_ASM71459v1/GCA_000714595.1_ASM71459v1_genomic.gff.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000714595.1_ASM71459v1/GCA_000714595.1_ASM71459v1_genomic.fna.gz
gunzip GCA_000714595.1_ASM71459v1_genomic.fna.gz
gunzip GCA_000714595.1_ASM71459v1_genomic.gff.gz
mv GCA_000714595.1_ASM71459v1_genomic.fna CP007799.fa
mv GCA_000714595.1_ASM71459v1_genomic.gff CP007799.gff

#build bowtie index
bowtie2-build CP007799.fa CP007799

}

#function run_bowtie2(){
#}

function run_cuffquant(){
mkdir CUFFQUANT
for i in RC0-1 RC0-2 RC0-3 RC15-1 RC15-2 RC15-3 RC30-1 RC30-2 RC30-3 WT0-1 WT0-2 WT0-3 WT15-1 WT15-2 WT15-3 WT30-1 WT30-2 WT30-3 
do
	cuffquant -o CUFFQUANT/${i} CP007799.gff BOWTIE2/${i}_sort.bam
done
}

function run_cuffdiff(){
mkdir CUFFDIFF
for i in 0 15 30 
do
        cuffdiff -o CUFFDIFF/${i} CP007799.gff CUFFQUANT/RC${i}-1/abundances.cxb,CUFFQUANT/RC${i}-2/abundances.cxb,CUFFQUANT/RC${i}-3/abundances.cxb CUFFQUANT/WT${i}-1/abundances.cxb,CUFFQUANT/WT${i}-2/abundances.cxb,CUFFQUANT/WT${i}-3/abundances.cxb
done
}


#rename
#uncompress
#run_trimmomatic
#rename_files
run_edgepro
#load_module
#run_cuffquant
#run_cuffdiff



