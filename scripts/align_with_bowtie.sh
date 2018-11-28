#!/bin/bash

source bowtie2-2.2.9
source samtools-1.9
# usage $0 projectdir refIndex forwardReads reverseReads outputSam readgroupname

projectdir=$1
refIndex=$2
forwardReads=$3
reverseReads=$4
output=$5
rg=$6
sample=$6

mkdir -p ${projectdir}/results

bowtie2 --time --un ${projectdir}/results/${sample}_unaligned_reads.fastq --al ${projectdir}/results/${sample}aligned_atleast_once.fastq --no-unal --rg-id $rg --rg $rg --threads 8 -x $refIndex -1 $forwardReads -2 $reverseReads | samtools sort --reference $refIndex --threads 4 -m 2G  --output-fmt BAM -o ${output}
