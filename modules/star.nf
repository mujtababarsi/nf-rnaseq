process STAR_ALIGN {

    tag "$sample_id"
    publishDir "${params.outdir}/alignment/star", mode: 'copy'

    cpus 2
    memory '6 GB'
    container 'quay.io/biocontainers/star:2.7.10b--h6b7c446_1'

    input:
    tuple val(sample_id), path(reads)
    path star_index   // <--- Correct! You defined the variable here.

    output:
    tuple val(sample_id), path("*Aligned.sortedByCoord.out.bam"), emit: bam
    path "*Log.final.out", emit: log  // <--- ADD THIS LINE (Required for MultiQC)

    script:
    """
    STAR \
      --genomeDir ${star_index} \
      --readFilesIn ${reads} \
      --readFilesCommand zcat \
      --runThreadN ${task.cpus} \
      --outFileNamePrefix ${sample_id}_ \
      --outSAMtype BAM SortedByCoordinate \
      --outSAMunmapped Within \
      --outSAMattributes Standard
    """
} 