#!/bin/bash
source bowtie2-2.2.9

projectdir=/tsl/scratch/shrestha/bozeng/project_forward_genetic_screening/
ref=/tsl/scratch/shrestha/bozeng/project_forward_genetic_screening/reference/Magnaporthe_oryzae.MG8.dna.toplevel.fa


function check_file_timestamp() {
	if test ! -e $2
	then
        	return 1
	else
        	if test $1 -nt $2
		then
                	return 1
        	else
                	return 0
		fi
	fi

}



# Building index
check_file_timestamp ${ref} ${projectdir}/reference/Magnaporthe_oryzae.MG8.dna.toplevel.fa.1.bt2
if test $? -eq 1; then
	echo "Creating index"
	echo bash ${projectdir}/scripts/create_bowtie_index.sh $ref
	echo "Indexing done"
	echo "ref is newer"

else
	echo "Indexing done"
fi

# aligning WT samples
for WT in WT_1_1.fq.gz,WT_1_2.fq.gz  WT_2_1.fq.gz,WT_2_2.fq.gz WT_3_1.fq.gz,WT_3_2.fq.gz  WT_4_1.fq.gz,WT_4_2.fq.gz  WT_5_1.fq.gz,WT_5_2.fq.gz; do
	R1=$(echo $WT | awk -F "," '{print $1}')
	R2=$(echo $WT | awk -F "," '{print $2}')
	sample=$(echo $R1 | sed 's/_/ /g' | awk '{print $1"_"$2}')
	check_file_timestamp ${projectdir}/reference/Magnaporthe_oryzae.MG8.dna.toplevel.fa.1.bt2 ${projectdir}/result/${sample}_bowtie_aligned.sorted.bam
	if test $? -eq 1; then
		bash ${projectdir}/scripts/align_with_bowtie.sh $projectdir $ref /tsl/data/reads/ntalbot/uv_mutagenesis/guy11_mep2_gfp_control/rna_conidia_guy11_mep2_gfp_control/raw/${R1} /tsl/data/reads/ntalbot/uv_mutagenesis/guy11_mep2_gfp_control/rna_conidia_guy11_mep2_gfp_control/raw/${R2} ${projectdir}/results/${sample}_bowtie_aligned.sorted.bam $sample
	fi
	echo "Sample $sample aligning completed"
done

# aligning KO samples
for KO in KO_1_1.fq.gz,KO_1_2.fq.gz  KO_2_1.fq.gz,KO_2_2.fq.gz  KO_3_1.fq.gz,KO_3_2.fq.gz  KO_4_1.fq.gz,KO_4_2.fq.gz  KO_5_1.fq.gz,KO_5_2.fq.gz; do
	R1=$(echo $KO | awk -F "," '{print $1}')
	R2=$(echo $KO | awk -F "," '{print $2}')
	sample=$(echo $R1 | sed 's/_/ /g' | awk '{print $1"_"$2}')
	check_file_timestamp ${projectdir}/reference/Magnaporthe_oryzae.MG8.dna.toplevel.fa.1.bt2 ${projectdir}/result/${sample}_bowtie_aligned.sorted.bam
	if test $? -eq 1; then
		bash ${projectdir}/scripts/align_with_bowtie.sh $projectdir $ref /tsl/data/reads/ntalbot/uv_mutagenesis/rgs1_ko/rgs1_ko_rna_conidia/raw/${R1} /tsl/data/reads/ntalbot/uv_mutagenesis/rgs1_ko/rgs1_ko_rna_conidia/raw/${R2} ${projectdir}/results/${sample}_bowtie_aligned.sorted.bam $sample
	fi
	echo "Sample $sample aligning completed"
done

#aligning CERT7 samples
for cer7 in CER7_1_1.fq.gz,CER7_1_2.fq.gz  CER7_2_1.fq.gz,CER7_2_2.fq.gz  CER7_3_1.fq.gz,CER7_3_2.fq.gz  CER7_4_1.fq.gz,CER7_4_2.fq.gz  CER7_5_1.fq.gz,CER7_5_2.fq.gz; do
	R1=$(echo $cer7 | awk -F "," '{print $1}')
	R2=$(echo $cer7 | awk -F "," '{print $2}')
	sample=$(echo $R1 | sed 's/_/ /g' | awk '{print $1"_"$2}')
	check_file_timestamp ${projectdir}/reference/Magnaporthe_oryzae.MG8.dna.toplevel.fa.1.bt2 ${projectdir}/result/${sample}_bowtie_aligned.sorted.bam
	if test $? -eq 1; then
		bash ${projectdir}/scripts/align_with_bowtie.sh $projectdir $ref /tsl/data/reads/ntalbot/uv_mutagenesis/cer7_genome/cer7_conidia/raw/${R1} /tsl/data/reads/ntalbot/uv_mutagenesis/cer7_genome/cer7_conidia/raw/${R2} ${projectdir}/results/${sample}_bowtie_aligned.sorted.bam $sample
	fi
	echo "Sample $sample aligning completed"
done
