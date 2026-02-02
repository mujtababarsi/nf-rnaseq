process MULTIQC {

    cpus 1
    memory '1 GB'

    conda "${projectDir}/envs/multiqc.yaml"

    input:
    path reports*

    output:
    path "multiqc_report.html" 

    script:
    """
    multiqc .
    """
}