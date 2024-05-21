nextflow.enable.dsl=2

//params.input = "/home/sequser/Cholera-training-KEMRI/data/fastq/*_L001_R{1,2}_001.fastq.gz"
params.input = "/Users/zuza/repos/Cholera-training-KEMRI/data/fastq/*_{1,2}.fastq.gz" // in Zuzas laptop
params.outdir = "../results"

process FASTQC {
    container 'staphb/fastqc:0.12.1'
    publishDir "${params.outdir}", mode: 'copy'

    input:
    tuple val(sample_id), path('reads')
    
    output:
    file "fastqc_output/"
    
    script:
    """
    mkdir fastqc_output
    fastqc -o fastqc_output ${reads}
    """
}




workflow  {
    reads_ch = channel.fromFilePairs(params.input, checkIfExists:true).view()
    FASTQC(reads_ch)

}
