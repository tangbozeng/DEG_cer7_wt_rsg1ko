#!/bin/bash

source tophat-2.1.1
source bowtie2-2.2.9
projectdir=$1
refindex=$2
sample=$3
R1=$4
R2=$5
mkdir -p ${projectdir}/results/tophat_${sample}
tophat2 --num-threads 4 --no-discordant --no-mixed --rg-id ${sample} --rg-sample ${sample} --rg-library LIB_${sample} -o ${projectdir}/results/tophat_${sample} $refindex $R1 $R2
