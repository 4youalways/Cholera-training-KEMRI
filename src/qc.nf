nextflow.enable.dsl=2

params.input = "/home/sequser/Cholera-training-KEMRI/data/fastq/*_L001_R{1,2}_001.fastq.gz"


reads_ch = channel.fromFilePairs(params.input, checkIfExists:true).view()