
process IQTREE {

    tag "$sample_id"
    container 'staphb/iqtree2:2.2.2.7'
    debug true
    input:
    path phylo
    path constant
    
    output:
    path 'phylo.aln.*'
    
    script:
    """
    #!/bin/bash
    iqtree2 -nt AUTO -fconst \$(cat ${constant}) -s ${phylo} -m GTR+G -keep-ident -bb 1000 --threads-max 80 --bnni -t PARS -ninit 2 -T AUTO

    """
}
