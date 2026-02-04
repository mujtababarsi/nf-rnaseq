process FEATURECOUNTS {
    tag "$sample_id" 
    publishDir "${params.outdir}/quantification", mode: 'copy'
    cpus 2
    memory '2 GB'

    container 'quay.io/biocontainers/subread:2.0.1--hed695b0_0'
    input:
    tuple val(sample_id), path(bam)

    output:
    path "*.txt", emit: counts

    script:
    """
    featureCounts -a ${params.gtf} -o ${sample_id}_counts.txt $bam
    """
}