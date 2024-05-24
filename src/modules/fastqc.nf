
process FASTQC {

    tag "$sample_id"
    container 'staphb/fastqc:0.12.1'
    //container 'phylogenetics:0.0.6'

    input:
    tuple val(sample_id), path(reads)
    
    output:
    tuple val(sample_id), path("*.html"), emit: html
    tuple val(sample_id), path("*.zip"), emit: zip
    

    script:
    """
    fastqc --threads $task.cpus ${reads}
    """
}
