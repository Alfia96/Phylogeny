#!/bin/bash

#Directory containing the fasta file
fasta_directory = "/home/alfia/Downloads/Trial/"
cd fasta_directory
#Outputdirectory for aligned sequences and tree
output_directory = "/home/alfia/Downloads/BacteriaPhylo"

#Perform Multiple sequence alignment using MAFFT
mafft --auto brucella.fasta > brucella_output.fasta

#Performing MSA if there are multiple fasta files
mafft --auto ${fasta_directory}/*.fasta > ${output_directory}/aligned_output.fasta

#Building phylogenetic tree using IQTREE2
iqtree2 -s ${output_directory}/aligned_output.fasta -bb 1000 -m TEST
iqtree2 -s brucella_output.fasta -bb 1000 -m TEST

#Generate a consensus tree from the bootstrap replicates
iqtree2 -s ${output_directory}/aligned_output.fasta -b ${output_directory}/consensus.treefile
iqtree2 -b 1000 brucella_output.fasta 

echo "Pipeline completed and successfully created tree file!"
