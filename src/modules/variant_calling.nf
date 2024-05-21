process SNIPPY{
    tag "calling snps for ${sample_id}"
    container 'staphb/snippy:4.6.0-SC2'
    cpus 8
    
    input:
    tuple val(sample_id), path(reads)
    each path('ref')


    output:
    path "${sample_id}"
 
    script :
    """
    snippy --cpus ${task.cpus} --outdir ${sample_id} --reference ${ref} --R1 ${reads[0]} --R2 ${reads[0]} --force
    
    """
}

process SNIPPY_CORE{
    tag "calling snps for ${sample_id}"
    container 'staphb/snippy:4.6.0-SC2'
    cpus 8
    
    input:
    tuple val(sample_id), path(reads)
    each path('ref')


    output:
    path "${sample_id}"
 
    script :
    """
    snippy --cpus ${task.cpus} --outdir ${sample_id} --reference ${ref} --R1 ${reads[0]} --R2 ${reads[0]} --force
    
    """
}
