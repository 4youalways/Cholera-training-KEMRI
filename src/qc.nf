nextflow.enable.dsl=2

//params.input = "/home/sequser/Cholera-training-KEMRI/data/fastq/*_L001_R{1,2}_001.fastq.gz"
params.input = "/Users/zuza/repos/Cholera-training-KEMRI/data/fastq/*_{1,2}.fastq.gz" // in Zuzas laptop




include { FASTQC as before_trim } from './modules/fastqc.nf' 
include { FASTQC as after_trim }  from './modules/fastqc.nf'
include { TRIMMOMATIC } from './modules/trimming_and_filtering.nf'
include { SNIPPY } from './modules/variant_calling.nf'
include { SNIPPY_CORE  } from './modules/variant_calling.nf'
include { SNP_SITES } from './modules/variant_calling.nf'



workflow  {
    reads_ch = channel.fromFilePairs(params.input, checkIfExists:true)
    ref_ch = channel.fromPath(params.ref, checkIfExists:true)
    before_trim(reads_ch)
    trimmed = TRIMMOMATIC(reads_ch) // trimming and filtering
    after_trim(trimmed)
    snps = SNIPPY(trimmed, ref_ch).collect() // variant calling step
    full_aln = SNIPPY_CORE(snps, ref_ch) // generating fasta alignment
    SNP_SITES(full_aln)
}
