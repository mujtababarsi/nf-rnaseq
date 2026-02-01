process FastQC {

    tag "$sample_id"

    cpus 1
    memory '1 GB'

    conda 'nf-fastqc'

    input:
    tuple val(sample_id), path(fastq)

    output:
    path "*.zip",  emit: zip
    path "*.html", emit: html

    script:
    """
    fastqc $fastq --outdir .
    """
}
