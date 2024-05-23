nextflow.enable.dsl=2





include { FASTQC as before_trim } from './modules/fastqc.nf' 
include { FASTQC as after_trim }  from './modules/fastqc.nf'
include { TRIMMOMATIC } from './modules/trimming_and_filtering.nf'
include { SNIPPY } from './modules/variant_calling.nf'
include { SNIPPY_CORE  } from './modules/variant_calling.nf'
include { SNP_SITES } from './modules/variant_calling.nf'
include { IQTREE } from './modules/iqtree.nf'



workflow  {
    reads_ch = channel.fromPath(params.sample_sheet)
    .splitCsv(header: true)
    .map {
        row ->
        meta = row.sample_name
        [meta, [
            file(row.read_1),
            file(row.read_2)
        ]]
    }
    .view()

    ref_ch = channel.fromPath(params.ref, checkIfExists:true)
    before_trim(reads_ch)
    trimmed = TRIMMOMATIC(reads_ch) // trimming and filtering
    after_trim(trimmed)
    snps = SNIPPY(trimmed, ref_ch).collect() // variant calling step
    full_aln = SNIPPY_CORE(snps, ref_ch) // generating fasta alignment
    phylo = SNP_SITES(full_aln)   
    IQTREE(SNP_SITES.out.phylo, SNP_SITES.out.constant)

}
